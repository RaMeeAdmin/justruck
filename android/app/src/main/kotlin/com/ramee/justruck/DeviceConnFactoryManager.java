package com.ramee.justruck;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.usb.UsbDevice;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;

import com.gprinter.io.BluetoothPort;
import com.gprinter.io.EthernetPort;
import com.gprinter.io.PortManager;
import com.gprinter.io.SerialPort;
import com.gprinter.io.UsbPort;

import java.io.IOException;
import java.util.Vector;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import static android.hardware.usb.UsbManager.ACTION_USB_DEVICE_DETACHED;

public class DeviceConnFactoryManager
{
    public static final byte FLAG = 0x10;
    public static final String ACTION_CONN_STATE = "action_connect_state";
    public static final String ACTION_QUERY_PRINTER_STATE = "action_query_printer_state";
    public static final String STATE = "state";
    public static final String DEVICE_ID = "id";
    public static final int CONN_STATE_DISCONNECT = 0x90;
    public static final int CONN_STATE_CONNECTING = CONN_STATE_DISCONNECT << 1;
    public static final int CONN_STATE_FAILED = CONN_STATE_DISCONNECT << 2;
    public static final int CONN_STATE_CONNECTED = CONN_STATE_DISCONNECT << 3;
    private static final String TAG = DeviceConnFactoryManager.class.getSimpleName();
    /**
     * ESC to query the real-time status of the printer. Paper out status
     */
    private static final int ESC_STATE_PAPER_ERR = 0x20;
    /**
     * ESC command to query the real-time status of the printer, the printer cover opening status
     */
    private static final int ESC_STATE_COVER_OPEN = 0x04;
    /**
     * The ESC command queries the real-time status of the printer, and the printer reports the error status
     */
    private static final int ESC_STATE_ERR_OCCURS = 0x40;
    /**
     * ESC low battery
     */
    private static final int ESC_LOW_POWER = 0x31;
    /**
     * Battery in ESC
     */
    private static final int ESC_AMID_POWER = 0x32;
    /**
     * ESC high battery
     */
    private static final int ESC_HIGH_POWER = 0x33;
    /**
     * ESC is charging
     */
    private static final int ESC_CHARGING = 0x35;
    /**
     * The TSC command queries the real-time status of the printer. The printer is out of paper.
     */
    private static final int TSC_STATE_PAPER_ERR = 0x04;
    /**
     * TSC command to query the real-time status of the printer, the printer cover opening status
     */
    private static final int TSC_STATE_COVER_OPEN = 0x01;
    /**
     * TSC command to query the real-time status of the printer Printer error status
     */
    private static final int TSC_STATE_ERR_OCCURS = 0x80;
    /**
     * The CPCL command queries the real-time status of the printer. The printer is out of paper.
     */
    private static final int CPCL_STATE_PAPER_ERR = 0x01;
    /**
     * The CPCL command queries the real-time status of the printer. The printer cover is opened.
     */

    private static final int CPCL_STATE_COVER_OPEN = 0x02;
    private static final int READ_DATA = 10000;
    private static final String READ_DATA_CNT = "read_data_cnt";
    private static final String READ_BUFFER_ARRAY = "read_buffer_array";
    public static boolean whichFlag = true;
    private static DeviceConnFactoryManager[] deviceConnFactoryManagers = new DeviceConnFactoryManager[4];
    public PortManager mPort;
    public CONN_METHOD connMethod;
    public PrinterReader reader;
    private String ip;
    private int port;
    private String macAddress;
    private UsbDevice mUsbDevice;
    private Context mContext;
    private String serialPortPath;
    private int baudrate;
    private int id;

    BroadcastReceiver usbStateReceiver = new BroadcastReceiver()
    {
        @Override
        public void onReceive(Context context, Intent intent)
        {
            String action = intent.getAction();
            switch (action) {
                case ACTION_USB_DEVICE_DETACHED:
                    sendStateBroadcast(CONN_STATE_DISCONNECT);
                    break;
                default:
                    break;
            }
        }
    };

    private boolean isOpenPort;
    /**
     * ESC query printer real-time status command
     */
    private byte[] esc = {0x10, 0x04, 0x02};
    /**
     * TSC query printer status command
     */
    private byte[] tsc = {0x1b, '!', '?'};
    private byte[] cpcl = {0x1b, 0x68};
    private byte[] sendCommand;
    /**
     * Determine whether the command used by the printer is an ESC command
     */
    private PrinterCommand currentPrinterCommand;
    private Handler mHandler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case READ_DATA:
                    int cnt = msg.getData().getInt(READ_DATA_CNT); //data length > 0;
                    byte[] buffer = msg.getData().getByteArray(READ_BUFFER_ARRAY);  //data
                    //Only the query status return value is processed here, other return values ​​can be parsed by referring to the programming manual
                    if (buffer == null) {
                        return;
                    }
                    int result = judgeResponseType(buffer[0]); //data shift right
                    String status = App.getContext().getString(R.string.str_printer_conn_normal);
                    if (sendCommand == esc) {
                        //Set the current printer mode to ESC mode
                        if (currentPrinterCommand == null) {
                            currentPrinterCommand = PrinterCommand.ESC;
                            sendStateBroadcast(CONN_STATE_CONNECTED);
                        } else {//Query printer status
                            if (result == 0) {//Printer Status Inquiry
                                Intent intent = new Intent(ACTION_QUERY_PRINTER_STATE);
                                intent.putExtra(DEVICE_ID, id);
                                App.getContext().sendBroadcast(intent);
                            } else if (result == 1) {//Query the real-time status of the printer
                                if (whichFlag) {
                                    if ((buffer[0] & ESC_STATE_PAPER_ERR) > 0) {
                                        status += " " + App.getContext().getString(R.string.str_printer_out_of_paper);
                                    }
                                    if ((buffer[0] & ESC_STATE_COVER_OPEN) > 0) {
                                        status += " " + App.getContext().getString(R.string.str_printer_open_cover);
                                    }
                                    if ((buffer[0] & ESC_STATE_ERR_OCCURS) > 0) {
                                        status += " " + App.getContext().getString(R.string.str_printer_error);
                                    }
                                } else {
                                    if ((buffer[0] == ESC_LOW_POWER)) {
                                        status = App.getContext().getString(R.string.str_low_power);
                                    } else if ((buffer[0] == ESC_AMID_POWER)) {
                                        status = App.getContext().getString(R.string.str_amid_power);
                                    } else if ((buffer[0] == ESC_HIGH_POWER)) {
                                        status = App.getContext().getString(R.string.str_high_power);
                                    } else if ((buffer[0] == ESC_CHARGING)) {
                                        status = App.getContext().getString(R.string.str_charging);
                                    }
                                }

                                System.out.println(App.getContext().getString(R.string.str_state) + status);
                                String mode = App.getContext().getString(R.string.str_printer_printmode_esc);
                                Utils.toast(App.getContext(), mode + " " + status);
                            }
                        }
                    } else if (sendCommand == tsc) {
                        //Set the current printer mode to TSC mode
                        if (currentPrinterCommand == null) {
                            currentPrinterCommand = PrinterCommand.TSC;
                            sendStateBroadcast(CONN_STATE_CONNECTED);
                        } else {
                            if (cnt == 1) {//Query the real-time status of the printer
                                if ((buffer[0] & TSC_STATE_PAPER_ERR) > 0) {//out of paper
                                    status += " " + App.getContext().getString(R.string.str_printer_out_of_paper);
                                }
                                if ((buffer[0] & TSC_STATE_COVER_OPEN) > 0) {//open the lid
                                    status += " " + App.getContext().getString(R.string.str_printer_open_cover);
                                }
                                if ((buffer[0] & TSC_STATE_ERR_OCCURS) > 0) {//printer error
                                    status += " " + App.getContext().getString(R.string.str_printer_error);
                                }
                                System.out.println(App.getContext().getString(R.string.str_state) + status);
                                String mode = App.getContext().getString(R.string.str_printer_printmode_tsc);
                                Utils.toast(App.getContext(), mode + " " + status);
                            } else {//Printer Status Inquiry
                                Intent intent = new Intent(ACTION_QUERY_PRINTER_STATE);
                                intent.putExtra(DEVICE_ID, id);
                                App.getContext().sendBroadcast(intent);
                            }
                        }
                    } else if (sendCommand == cpcl) {
                        if (currentPrinterCommand == null) {
                            currentPrinterCommand = PrinterCommand.CPCL;
                            sendStateBroadcast(CONN_STATE_CONNECTED);
                        } else {
                            if (cnt == 1) {
                                System.out.println(App.getContext().getString(R.string.str_state) + status);
                                if ((buffer[0] == CPCL_STATE_PAPER_ERR)) {//out of paper
                                    status += " " + App.getContext().getString(R.string.str_printer_out_of_paper);
                                }
                                if ((buffer[0] == CPCL_STATE_COVER_OPEN)) {//open the lid
                                    status += " " + App.getContext().getString(R.string.str_printer_open_cover);
                                }
                                String mode = App.getContext().getString(R.string.str_printer_printmode_cpcl);
                                Utils.toast(App.getContext(), mode + " " + status);
                            } else {//Printer Status Inquiry
                                Intent intent = new Intent(ACTION_QUERY_PRINTER_STATE);
                                intent.putExtra(DEVICE_ID, id);
                                App.getContext().sendBroadcast(intent);
                            }
                        }
                    }
                    break;
                default:
                    break;
            }
        }
    };

    private DeviceConnFactoryManager(Build build) {
        this.connMethod = build.connMethod;
        this.macAddress = build.macAddress;
        this.port = build.port;
        this.ip = build.ip;
        this.mUsbDevice = build.usbDevice;
        this.mContext = build.context;
        this.serialPortPath = build.serialPortPath;
        this.baudrate = build.baudrate;
        this.id = build.id;
        deviceConnFactoryManagers[id] = this;
    }

    public static DeviceConnFactoryManager[] getDeviceConnFactoryManagers() {
        return deviceConnFactoryManagers;
    }

    public static void closeAllPort() {
        for (DeviceConnFactoryManager deviceConnFactoryManager : deviceConnFactoryManagers) {
            if (deviceConnFactoryManager != null) {
                Log.e(TAG, "cloaseAllPort() id -> " + deviceConnFactoryManager.id);
                deviceConnFactoryManager.closePort(deviceConnFactoryManager.id);
                deviceConnFactoryManagers[deviceConnFactoryManager.id] = null;
            }
        }
    }

    /**
     * close port
     */
    public void closePort(int id) {
        if (this.mPort != null) {
            System.out.println("id -> " + id);
            reader.cancel();
            boolean b = this.mPort.closePort();
            if (b) {
                this.mPort = null;
                isOpenPort = false;
                currentPrinterCommand = null;
            }
        }
        sendStateBroadcast(CONN_STATE_DISCONNECT);
    }

    /**
     * open port
     *
     * @return
     */
    public void openPort() {
        deviceConnFactoryManagers[id].isOpenPort = false;
        sendStateBroadcast(CONN_STATE_CONNECTING);
        switch (deviceConnFactoryManagers[id].connMethod) {
            case BLUETOOTH:
                System.out.println("id -> " + id);
                mPort = new BluetoothPort(macAddress);
                isOpenPort = deviceConnFactoryManagers[id].mPort.openPort();
                break;
            case USB:
                mPort = new UsbPort(mContext, mUsbDevice);
                isOpenPort = mPort.openPort();
                if (isOpenPort) {
                    IntentFilter filter = new IntentFilter(ACTION_USB_DEVICE_DETACHED);
                    mContext.registerReceiver(usbStateReceiver, filter);
                }
                break;
            case WIFI:
                mPort = new EthernetPort(ip, port);
                isOpenPort = mPort.openPort();
                break;
            case SERIAL_PORT:
                mPort = new SerialPort(serialPortPath, baudrate, 0);
                isOpenPort = mPort.openPort();
                break;
            default:
                break;
        }

        //After the port is opened successfully, check the printer commands ESC, TSC, CPCL used to connect the printer
        if (isOpenPort) {
            queryCommand();
            // currentPrinterCommand = PrinterCommand.ESC;
            // currentPrinterCommand = PrinterCommand.TSC;
            // currentPrinterCommand = PrinterCommand.CPCL;
            // sendStateBroadcast(CONN_STATE_CONNECTED);
        } else {
            if (this.mPort != null) {
                this.mPort = null;
            }
            sendStateBroadcast(CONN_STATE_FAILED);
        }
    }

    private void sendStateBroadcast(int state) {
        Intent intent = new Intent(ACTION_CONN_STATE);
        intent.putExtra(STATE, state);
        intent.putExtra(DEVICE_ID, id);
        App.getContext().sendBroadcast(intent);
    }

    /**
     * Query the printer commands used by the currently connected printer (ESC (EscCommand.java), TSC (LabelCommand.java))
     */
    private void queryCommand() {
        //Open the read printer return data thread
        reader = new PrinterReader();
        reader.start(); //read data thread
        //Query the command used by the printer
        queryPrinterCommand(); //
    }

    /**
     * Query the commands currently used by the printer (TSC, ESC)
     */
    private void queryPrinterCommand() {
        //Thread pool add task
        ThreadPool.getInstantiation().addTask(new Runnable() {
            @Override
            public void run() {
                //Send ESC to query printer status command
                sendCommand = esc;
                Vector<Byte> data = new Vector<>(esc.length);
                for (int i = 0; i < esc.length; i++) {
                    data.add(esc[i]);
                }
                sendDataImmediately(data); //send esc data
                //Start the timer, and send the TSC query printer status command when there is no return value every 2000 milliseconds
                final ThreadFactoryBuilder threadFactoryBuilder = new ThreadFactoryBuilder("Timer");
                final ScheduledExecutorService scheduledExecutorService = new ScheduledThreadPoolExecutor(1, threadFactoryBuilder);
                scheduledExecutorService.schedule(threadFactoryBuilder.newThread(new Runnable() {
                    @Override
                    public void run() {
                        if (currentPrinterCommand == null || currentPrinterCommand != PrinterCommand.ESC) {
                            Log.e(TAG, Thread.currentThread().getName());
                            //Send TSC query printer status command
                            sendCommand = tsc;
                            Vector<Byte> data = new Vector<>(tsc.length);
                            for (int i = 0; i < tsc.length; i++) {
                                data.add(tsc[i]);
                            }
                            sendDataImmediately(data);
                            //Start the timer, and send the CPCL query printer status command when there is no return value every 2000 milliseconds
                            scheduledExecutorService.schedule(threadFactoryBuilder.newThread(new Runnable() {
                                @Override
                                public void run() {
                                    if (currentPrinterCommand == null || (currentPrinterCommand != PrinterCommand.ESC && currentPrinterCommand != PrinterCommand.TSC)) {
                                        Log.e(TAG, Thread.currentThread().getName());
                                        //Send CPCL query printer status command
                                        sendCommand = cpcl;
                                        Vector<Byte> data = new Vector<Byte>(cpcl.length);
                                        for (int i = 0; i < cpcl.length; i++) {
                                            data.add(cpcl[i]);
                                        }
                                        sendDataImmediately(data);
                                        //Start the timer, every 2000 milliseconds the printer has no responder to stop reading the printer data thread and close the port
                                        scheduledExecutorService.schedule(threadFactoryBuilder.newThread(new Runnable() {
                                            @Override
                                            public void run() {
                                                if (currentPrinterCommand == null) {
                                                    if (reader != null) {
                                                        reader.cancel();
                                                        mPort.closePort();
                                                        isOpenPort = false;
                                                        mPort = null;
                                                        sendStateBroadcast(CONN_STATE_FAILED);
                                                    }
                                                }
                                            }
                                        }), 2000, TimeUnit.MILLISECONDS);
                                    }
                                }
                            }), 2000, TimeUnit.MILLISECONDS);
                        }
                    }
                }), 2000, TimeUnit.MILLISECONDS);
            }
        });
    }

    public void sendDataImmediately(final Vector<Byte> data) {
        if (this.mPort == null) {
            return;
        }
        try {
            //  Log.e(TAG, "data -> " + new String(com.gprinter.command.GpUtils.convertVectorByteTobytes(data), "gb2312"));
            this.mPort.writeDataImmediately(data, 0, data.size());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Get port connection method
     *
     * @return
     */
    public CONN_METHOD getConnMethod() {
        return connMethod;
    }

    /**
     * Get the port open status (true open, false not open)
     *
     * @return
     */
    public boolean getConnState() {
        return isOpenPort;
    }

    /**
     * Get the physical address of the connected bluetooth
     *
     * @return
     */
    public String getMacAddress() {
        return macAddress;
    }

    /**
     * Get the port number of the connection network port
     *
     * @return
     */
    public int getPort() {
        return port;
    }

    /**
     * Get the IP of the connected network port
     *
     * @return
     */
    public String getIp() {
        return ip;
    }

    /**
     * Get connected USB device information
     *
     * @return
     */
    public UsbDevice usbDevice() {
        return mUsbDevice;
    }

    /**
     * Get serial number
     *
     * @return
     */
    public String getSerialPortPath() {
        return serialPortPath;
    }

    /**
     * get baud rate
     *
     * @return
     */
    public int getBaudrate() {
        return baudrate;
    }

    /**
     * Get current printer command
     *
     * @return PrinterCommand
     */
    public PrinterCommand getCurrentPrinterCommand() {
        return deviceConnFactoryManagers[id].currentPrinterCommand;
    }

    public int readDataImmediately(byte[] buffer) throws IOException {
        return this.mPort.readData(buffer);
    }

    /**
     * Determine whether it is real-time status (10 04 02) or query status (1D 72 01)
     */
    private int judgeResponseType(byte r) {
        return (byte) ((r & FLAG) >> 4);
    }

    public enum CONN_METHOD {
        //Bluetooth connection
        BLUETOOTH("BLUETOOTH"),
        //USB connection
        USB("USB"),
        //wifi connection
        WIFI("WIFI"),
        //Serial connection
        SERIAL_PORT("SERIAL_PORT");

        private String name;

        private CONN_METHOD(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return this.name;
        }
    }

    public static final class Build {
        private String ip;
        private String macAddress;
        private UsbDevice usbDevice;
        private int port;
        private CONN_METHOD connMethod;
        private Context context;
        private String serialPortPath;
        private int baudrate;
        private int id;

        public Build setIp(String ip) {
            this.ip = ip;
            return this;
        }

        public Build setMacAddress(String macAddress) {
            this.macAddress = macAddress;
            return this;
        }

        public Build setUsbDevice(UsbDevice usbDevice) {
            this.usbDevice = usbDevice;
            return this;
        }

        public Build setPort(int port) {
            this.port = port;
            return this;
        }

        public Build setConnMethod(CONN_METHOD connMethod) {
            this.connMethod = connMethod;
            return this;
        }

        public Build setContext(Context context) {
            this.context = context;
            return this;
        }

        public Build setId(int id) {
            this.id = id;
            return this;
        }

        public Build setSerialPort(String serialPortPath) {
            this.serialPortPath = serialPortPath;
            return this;
        }

        public Build setBaudrate(int baudrate) {
            this.baudrate = baudrate;
            return this;
        }

        public DeviceConnFactoryManager build() {
            return new DeviceConnFactoryManager(this);
        }
    }

    class PrinterReader extends Thread {
        private boolean isRun = false;

        private byte[] buffer = new byte[100];

        public PrinterReader() {
            isRun = true;
        }

        @Override
        public void run() {
            try {
                while (isRun) {
                    //Read printer return information
                    int len = readDataImmediately(buffer);
                    if (len > 0) {
                        Message message = Message.obtain();
                        message.what = READ_DATA;
                        Bundle bundle = new Bundle();
                        bundle.putInt(READ_DATA_CNT, len); //Data length
                        bundle.putByteArray(READ_BUFFER_ARRAY, buffer); //data
                        message.setData(bundle);
                        mHandler.sendMessage(message);
                    }
                }
            } catch (Exception e) {
                if (deviceConnFactoryManagers[id] != null) {
                    closePort(id);
                }
            }
        }

        public void cancel() {
            isRun = false;
        }
    }
}
