package com.ramee.justruck;

import android.Manifest;
import android.app.Activity;
import android.app.AlertDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.os.Handler;
import android.os.Message;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.gprinter.command.EscCommand;
import com.gprinter.command.FactoryCommand;
import com.gprinter.command.LabelCommand;

import java.io.ByteArrayOutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;
import java.util.Vector;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import static android.hardware.usb.UsbManager.ACTION_USB_DEVICE_ATTACHED;
import static android.hardware.usb.UsbManager.ACTION_USB_DEVICE_DETACHED;
import static com.ramee.justruck.Constants.ACTION_USB_PERMISSION;
import static com.ramee.justruck.Constants.MESSAGE_UPDATE_PARAMETER;
import static com.ramee.justruck.DeviceConnFactoryManager.ACTION_QUERY_PRINTER_STATE;

public class MainActivity extends FlutterActivity
{
    private static final String	TAG	= "MainActivity";
    private static final String CHANNEL = "com.ramee.justruck/printing";

    private	String[] permissions = { Manifest.permission.BLUETOOTH };
    private BluetoothAdapter mBluetoothAdapter;
    public static final int  REQUEST_ENABLE_BT      = 2;
    public static final int  REQUEST_CONNECT_DEVICE = 3;

    private static final int REQUEST_CODE = 0x004;

    public static final int REQUEST_ENABLE_BT_FOR_PAIRED_LIST_ONLY = 3625;
    public static final int REQUEST_ENABLE_BT_FOR_PRINT = 9662;

    ArrayList<String> per = new ArrayList<>();

    private ArrayAdapter<String> DevicesArrayAdapter;
    ListView list_btDevices;
    String selectedBT = "";
    private int	id = 0;

    private ThreadPool	threadPool;

    private static final int CONN_STATE_DISCONN = 0x007;
    private static final int PRINTER_COMMAND_ERROR = 0x008;
    private static final int CONN_MOST_DEVICES	= 0x11;
    private static final int CONN_PRINTER	= 0x12;

    String parcelId = "",receiverName = "",fromCityName = "",toCityName = "", bookingAgency = "", qrCodeURL = "";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine)
    {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) ->
                {
                    if(call.method.equalsIgnoreCase("checkBluetoothPermission"))
                    {
                        HashMap<String, String> arguments = call.arguments();
                        parcelId = arguments.get("parcelId");
                        receiverName = arguments.get("receiverName");
                        fromCityName = arguments.get("fromCityName");
                        toCityName = arguments.get("toCityName");
                        bookingAgency = arguments.get("bookingAgency");
                        qrCodeURL = arguments.get("qrCodeURL");

                        selectedBT = arguments.get("bluetoothDeviceId");

                        if(selectedBT!=null &&  !selectedBT.trim().isEmpty() )
                        {
                            mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
                            if (mBluetoothAdapter!= null)
                            {
                                if (!mBluetoothAdapter.isEnabled())
                                {
                                    Intent enableIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                                    startActivityForResult(enableIntent, REQUEST_ENABLE_BT_FOR_PRINT);
                                }
                                else
                                {
                                    closeport();
                                    connectToBluetoothUsingMacAddress(selectedBT);
                                }
                            }
                        }
                        else
                        {
                            initBluetooth();
                        }
                    }

                    if(call.method.equalsIgnoreCase("pairedDevices"))
                    {
                        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
                        if (mBluetoothAdapter == null)
                        {
                            Toast.makeText(this, "Bluetooth is not supported by the device", Toast.LENGTH_SHORT).show();
                        }
                        else
                        {
                            if (!mBluetoothAdapter.isEnabled())
                            {
                                Intent enableIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                                startActivityForResult(enableIntent, REQUEST_ENABLE_BT_FOR_PAIRED_LIST_ONLY);
                            }
                            else
                            {
                                ArrayList<Object> pairedDevicesList = getBluetoothParedDevicesList();
                                result.success(pairedDevicesList);
                            }
                        }
                    }
                });
    }

    public void initBluetooth()
    {
        // Get the local Bluetooth adapter
        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        // If the adapter is null, then Bluetooth is not supported
        if (mBluetoothAdapter == null)
        {
            Toast.makeText(this, "Bluetooth is not supported by the device", Toast.LENGTH_SHORT).show();
        }
        else
        {
            // If BT is not on, request that it be enabled.
            // setupChat() will then be called during onActivityResult
            if (!mBluetoothAdapter.isEnabled())
            {
                Intent enableIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                startActivityForResult(enableIntent, REQUEST_ENABLE_BT);
            }
            else
            {
                getPairedDeviceList();
            }
        }
    }

    protected void getPairedDeviceList()
    {
        DevicesArrayAdapter = new ArrayAdapter<>(this, R.layout.bluetooth_device_name_item);

        Set<BluetoothDevice> pairedDevices = mBluetoothAdapter.getBondedDevices();
        System.out.println("No of paired devices = "+pairedDevices.size());

        AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
        AlertDialog dialog;
        builder.setTitle("Select Printer");

        TextView txtv_message;

        View view = getLayoutInflater().inflate(R.layout.dialog_device_list, null);
        list_btDevices = view.findViewById(R.id.list_btDevices);
        list_btDevices.setAdapter(DevicesArrayAdapter);

        txtv_message = view.findViewById(R.id.txtv_message);

        builder.setView(view);

        dialog = builder.create();
        dialog.show();

        if(pairedDevices.size() > 0)
        {
            txtv_message.setVisibility(View.GONE);

            for (BluetoothDevice device : pairedDevices)
            {
                DevicesArrayAdapter.add(device.getName() + "\n" + device.getAddress());
            }

            list_btDevices.setOnItemClickListener(new AdapterView.OnItemClickListener()
            {
                @Override
                public void onItemClick(AdapterView<?> parent, View v, int position, long id)
                {
                    closeport();
                    String info = ((TextView) v).getText().toString();
                    String bt_macAddress = info.substring(info.length() - 17);
                    selectedBT = bt_macAddress;
                    dialog.dismiss();

                    connectToBluetoothUsingMacAddress(selectedBT);
                }
            });
        }
        else
        {
            txtv_message.setVisibility(View.VISIBLE);
            txtv_message.setText("No Paired device found.\nPlease Pair your bluetooth printer with this device");
        }
    }

    protected void connectToBluetoothUsingMacAddress(String address)
    {
        new DeviceConnFactoryManager.Build().setId(id)
                .setConnMethod(DeviceConnFactoryManager.CONN_METHOD.BLUETOOTH)
                .setMacAddress(address)
                .build();

        Log.d(TAG, "onActivityResult: connect to bluetooth" + id);

        threadPool = ThreadPool.getInstantiation();
        threadPool.addTask(new Runnable()
        {
            @Override
            public void run()
            {
                DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id].openPort();
            }
        });
    }

    private void closeport()
    {
        if ( DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id] != null && DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id].mPort != null )
        {
            DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id].reader.cancel();
            DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id].mPort.closePort();
            DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id].mPort = null;
        }
    }

    private BroadcastReceiver receiver = new BroadcastReceiver()
    {
        @Override
        public void onReceive(Context context, Intent intent)
        {
            String action = intent.getAction();
            switch ( action )
            {
                case DeviceConnFactoryManager.ACTION_CONN_STATE:
                    int state = intent.getIntExtra( DeviceConnFactoryManager.STATE, -1 );
                    int deviceId = intent.getIntExtra( DeviceConnFactoryManager.DEVICE_ID, -1 );
                    switch ( state )
                    {
                        case DeviceConnFactoryManager.CONN_STATE_DISCONNECT:
                            if ( id == deviceId )
                            {
                                System.out.println(getString( R.string.str_conn_state_disconnect));
                            }
                            break;
                        case DeviceConnFactoryManager.CONN_STATE_CONNECTING:
                            System.out.println( getString( R.string.str_conn_state_connecting ) );
                            break;
                        case DeviceConnFactoryManager.CONN_STATE_CONNECTED:
                            System.out.println( getString( R.string.str_conn_state_connected ) + "\n" + getConnDeviceInfo());
                            btnReceiptPrint();
                            break;
                        case DeviceConnFactoryManager.CONN_STATE_FAILED:
                            Utils.toast( MainActivity.this, getString( R.string.str_conn_fail ) );
                            /* wificonn=false; */
                            System.out.println( getString( R.string.str_conn_state_disconnect ) );
                            break;
                        default:
                            break;
                    }
                    break;
                default:
                    break;
            }
        }
    };

    private String getConnDeviceInfo()
    {
        String	str	= "";
        DeviceConnFactoryManager	deviceConnFactoryManager = DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id];
        if ( deviceConnFactoryManager != null
                && deviceConnFactoryManager.getConnState() )
        {
            if ( "USB".equals( deviceConnFactoryManager.getConnMethod().toString() ) )
            {
                str	+= "USB\n";
                str	+= "USB Name: " + deviceConnFactoryManager.usbDevice().getDeviceName();
            } else if ( "WIFI".equals( deviceConnFactoryManager.getConnMethod().toString() ) )
            {
                str	+= "WIFI\n";
                str	+= "IP: " + deviceConnFactoryManager.getIp() + "\t";
                str	+= "Port: " + deviceConnFactoryManager.getPort();
            } else if ( "BLUETOOTH".equals( deviceConnFactoryManager.getConnMethod().toString() ) )
            {
                str	+= "BLUETOOTH\n";
                str	+= "MacAddress: " + deviceConnFactoryManager.getMacAddress();
            } else if ( "SERIAL_PORT".equals( deviceConnFactoryManager.getConnMethod().toString() ) )
            {
                str	+= "SERIAL_PORT\n";
                str	+= "Path: " + deviceConnFactoryManager.getSerialPortPath() + "\t";
                str	+= "Baudrate: " + deviceConnFactoryManager.getBaudrate();
            }
        }
        return(str);
    }

    @Override
    protected void onStart()
    {
        super.onStart();
        IntentFilter filter = new IntentFilter( ACTION_USB_PERMISSION );
        filter.addAction( ACTION_USB_DEVICE_DETACHED );
        filter.addAction( ACTION_QUERY_PRINTER_STATE );
        filter.addAction( DeviceConnFactoryManager.ACTION_CONN_STATE );
        filter.addAction( ACTION_USB_DEVICE_ATTACHED );
        registerReceiver( receiver, filter );
    }

    @Override
    protected void onStop()
    {
        super.onStop();
        unregisterReceiver( receiver );
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_ENABLE_BT)
        {
            if (resultCode == Activity.RESULT_OK)
            {
                // bluetooth is opened
                getPairedDeviceList();
            }
            else
            {
                // bluetooth is not open
                Toast.makeText(this, "Bluetooth is not enabled", Toast.LENGTH_SHORT).show();
            }
        }

        if(requestCode == REQUEST_ENABLE_BT_FOR_PAIRED_LIST_ONLY)
        {
            if (resultCode == Activity.RESULT_OK)
            {
                // bluetooth is opened
                getBluetoothParedDevicesList();
            }
            else
            {
                // bluetooth is not open
                Toast.makeText(this, "Bluetooth is not enabled", Toast.LENGTH_SHORT).show();
            }
        }

        if(requestCode == REQUEST_ENABLE_BT_FOR_PRINT)
        {
            if (resultCode == Activity.RESULT_OK)
            {
                closeport();
                connectToBluetoothUsingMacAddress(selectedBT);
            }
            else
            {
                // bluetooth is not open
                Toast.makeText(this, "Bluetooth is not enabled", Toast.LENGTH_SHORT).show();
            }
        }
    }

    public void btnReceiptPrint()
    {
        if ( DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id] == null ||
                !DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id].getConnState() )
        {
            Utils.toast( this, getString( R.string.str_cann_printer ) );
            return;
        }

        threadPool = ThreadPool.getInstantiation();
        threadPool.addTask( new Runnable()
        {
            @Override
            public void run()
            {
                if ( DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id].getCurrentPrinterCommand() == PrinterCommand.TSC )
                {
                    //sendReceiptWithResponse();
                    sendLabel();
                }
                else
                {
                    mHandler.obtainMessage( PRINTER_COMMAND_ERROR ).sendToTarget();
                }
            }
        } );
    }

    private Handler mHandler = new Handler()
    {
        @Override
        public void handleMessage( Message msg )
        {
            switch ( msg.what )
            {
                case CONN_STATE_DISCONN:
                    if ( DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id] != null || !DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id].getConnState() )
                    {
                        DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id].closePort( id );
                        Utils.toast( MainActivity.this, getString( R.string.str_disconnect_success ) );
                    }
                    break;
                case PRINTER_COMMAND_ERROR:
                    Utils.toast( MainActivity.this, getString( R.string.str_choice_printer_command ) );
                    break;
                case CONN_PRINTER:
                    Utils.toast( MainActivity.this, getString( R.string.str_cann_printer ) );
                    break;
                case MESSAGE_UPDATE_PARAMETER:
                    String strIp = msg.getData().getString( "Ip" );
                    String strPort = msg.getData().getString( "Port" );
                    /* 初始化端口信息 */
                    new DeviceConnFactoryManager.Build()
                            /* 设置端口连接方式 */
                            .setConnMethod( DeviceConnFactoryManager.CONN_METHOD.WIFI )
                            /* 设置端口IP地址 */
                            .setIp( strIp )
                            /* 设置端口ID（主要用于连接多设备） */
                            .setId( id )
                            /* 设置连接的热点端口号 */
                            .setPort( Integer.parseInt( strPort ) )
                            .build();
                    threadPool = ThreadPool.getInstantiation();
                    threadPool.addTask( new Runnable()
                    {
                        @Override
                        public void run()
                        {
                            DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id].openPort();
                        }
                    } );
                    break;
                default:
                    new DeviceConnFactoryManager.Build()
                            /* 设置端口连接方式 */
                            .setConnMethod( DeviceConnFactoryManager.CONN_METHOD.WIFI )
                            /* 设置端口IP地址 */
                            .setIp( "192.168.2.227" )
                            /* 设置端口ID（主要用于连接多设备） */
                            .setId( id )
                            /* 设置连接的热点端口号 */
                            .setPort( 9100 )
                            .build();
                    threadPool.addTask( new Runnable()
                    {
                        @Override
                        public void run()
                        {
                            DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id].openPort();
                        }
                    } );
                    break;
            }
        }
    };

    void sendReceiptWithResponse()
    {
        EscCommand esc = new EscCommand();
        esc.addInitializePrinter();
        esc.addTurnReverseModeOnOrOff(EscCommand.ENABLE.ON);
        //esc.addPrintAndFeedLines( (byte) 1 );
        /* set print center */
        esc.addSelectJustification( EscCommand.JUSTIFICATION.CENTER);

        /* Set to double height and width */
        esc.addSelectPrintModes( EscCommand.FONT.FONTA, EscCommand.ENABLE.OFF, EscCommand.ENABLE.ON, EscCommand.ENABLE.ON, EscCommand.ENABLE.OFF );

        /* print text */
        //esc.addText( "JustTruck" );
        //esc.addPrintAndLineFeed();

        /* print text */
        /* Cancel double height and double width */
        //esc.addSelectPrintModes( EscCommand.FONT.FONTA, EscCommand.ENABLE.OFF, EscCommand.ENABLE.OFF, EscCommand.ENABLE.OFF, EscCommand.ENABLE.OFF );
        /* set print left alignment */
        //esc.addSelectJustification( EscCommand.JUSTIFICATION.LEFT );
        /* print text */
        //esc.addText( "Print text\n" );
        /* print text */
        //esc.addText( "Welcome to use SMARNET printer!\n" );

        /* Printing Traditional Chinese requires the printer to support the traditional font library */

        // uncomment below multiline comment later
        /*String message = "Jiabo Zhihui Receipt Printer\n";
        esc.addText( message, "GB2312" );
        esc.addPrintAndLineFeed();*/

        /* Absolute position For details, please refer to the GP58 programming manual */

        // uncomment below multiline comment later

        /*esc.addText( "Wisdom" );
        esc.addSetHorAndVerMotionUnits( (byte) 7, (byte) 0 );
        esc.addSetAbsolutePrintPosition( (short) 6 );
        esc.addText( "The internet" );
        esc.addSetAbsolutePrintPosition( (short) 10 );
        esc.addText( "equipment" );
        esc.addPrintAndLineFeed();*/

        /* print pictures */
        //esc.addText( "Print bitmap!\n" );
        Bitmap background = BitmapFactory.decodeResource( getResources(), R.drawable.canvas);
        background = Bitmap.createScaledBitmap(background, 570, 140, false);
        System.out.println("Bitmap width = "+background.getWidth());
        System.out.println("Bitmap height = "+background.getHeight());

        int color = Color.argb(255, 0, 0, 0);

        background = drawTextOnImage(background, "Booking Id : "+parcelId, 175,30,20, color);
        background = drawTextOnImage(background, "To : "+receiverName, 175,55,20, color);
        background = drawTextOnImage(background, fromCityName+" to "+toCityName, 175,80,20, color);
        background = drawTextOnImage(background, "Booking By : ", 175,105,20, color);
        background = drawTextOnImage(background, bookingAgency, 175,130,20, color);

        URL url = null;
        try
        {
            url = new URL(qrCodeURL);
            Bitmap qrBitmap = BitmapFactory.decodeStream(url.openConnection().getInputStream());
            Bitmap qrContent = drawImageOnImage(background, qrBitmap, 5, 1, 140, 140);
            //esc.addRastBitImage( background, 280, 0);
            esc.addRastBitImage( qrContent, qrContent.getWidth(), 0);
        } catch (Exception e) {
            e.printStackTrace();
        }


        /* Printing 1D barcodes */
        /* print text */
        //esc.addText( "Print code128\n" );
        //esc.addSelectPrintingPositionForHRICharacters( EscCommand.HRI_POSITION.BELOW );
        /*
         * Set the barcode to identify the character position below the barcode
         * Set the barcode height to 60 points
         */
        //esc.addSetBarcodeHeight( (byte) 60 );
        /* Set barcode unit width to 1 */
        //esc.addSetBarcodeWidth( (byte) 1 );
        /* Print Code128 code */
        //esc.addCODE128( esc.genCodeB( "RaMee Group" ) );
        //esc.addPrintAndLineFeed();


        /*
         * QRCode command printing This command can only be used on models that support QRCode command printing.
         * On models that do not support QR code command printing, you need to send a QR code image
         */
        /* print text */
        //esc.addText( "Print QRcode\n" );
        /* Set error correction level */
        //esc.addSelectErrorCorrectionLevelForQRCode( (byte) 0x31 );
        /* Set qrcode module size */
        //esc.addSelectSizeOfModuleForQRCode( (byte) 3 );
        /* set qrcode content */
        //esc.addStoreQRCodeData( "https://rameegroup.co.in/" );
        //esc.addPrintQRCode(); /* print QRCode */
        //esc.addPrintAndLineFeed();

        /* set print left alignment */
        //esc.addSelectJustification( EscCommand.JUSTIFICATION.CENTER );
        /* print text */
        //esc.addText( "Completed!\r\n" );

        /* open the cash drawer */
        //esc.addGeneratePlus( LabelCommand.FOOT.F5, (byte) 255, (byte) 255 );
        esc.addPrintAndFeedLines( (byte) 2 );
        /* Added query printer status for continuous printing */
        byte[] bytes = { 29, 114, 1 };
        esc.addUserCommand( bytes );
        Vector<Byte> datas = esc.getCommand();
        /* send data */
        DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id].sendDataImmediately( datas );
    }

    /**
     * send label
     */
    void sendLabel()
    {
        LabelCommand tsc = new LabelCommand();
        /* Set the label size, set according to the actual size */
        tsc.addSize( 75, 25);
        /* Set the label gap, set according to the actual size, if it is no gap paper, set it to 0 */
        tsc.addGap(3);
        tsc.addDensity(LabelCommand.DENSITY.DNESITY15);
        /* set print orientation */
        tsc.addDirection( LabelCommand.DIRECTION.FORWARD, LabelCommand.MIRROR.NORMAL );
        /* Turn on printing with Response for continuous printing */
        tsc.addQueryPrinterStatus( LabelCommand.RESPONSE_MODE.ON);
        /* set origin coordinates */
        tsc.addReference( 0, 0);
        /* Tear off mode on */
        tsc.addTear( EscCommand.ENABLE.OFF);

        /* clear print buffer */
        tsc.addCls();

        /* draw pictures */
        Bitmap background = BitmapFactory.decodeResource( getResources(), R.drawable.canvas);
        background = Bitmap.createScaledBitmap(background, 570, 140, false);
        System.out.println("Bitmap width = "+background.getWidth());
        System.out.println("Bitmap height = "+background.getHeight());
        int color = Color.argb(255, 0, 0, 0);

        background = drawTextOnImage(background, "Booking Id : "+parcelId, 175,30,20, color);
        background = drawTextOnImage(background, "To : "+receiverName, 175,55,20, color);
        background = drawTextOnImage(background, fromCityName+" to "+toCityName, 175,80,20, color);
        background = drawTextOnImage(background, "Booking By : ", 175,105,20, color);
        background = drawTextOnImage(background, bookingAgency, 175,130,20, color);

        URL url = null;
        try
        {
            url = new URL(qrCodeURL);
            Bitmap qrBitmap = BitmapFactory.decodeStream(url.openConnection().getInputStream());
            Bitmap qrContent = drawImageOnImage(background, qrBitmap, 5, 1, 140, 140);
            //esc.addRastBitImage( background, 280, 0);
            tsc.addBitmap( 5, 20, LabelCommand.BITMAP_MODE.OVERWRITE, 570, qrContent );
        } catch (Exception e) {
            e.printStackTrace();
        }

        /* print labels */
        tsc.addPrint( 1, 1);

        /* Buzzer sounds after printing label */
        tsc.addSound( 2, 0 );
        //tsc.addCashdrwer( LabelCommand.FOOT.F5, 255, 255 );
        Vector<Byte> datas = tsc.getCommand();
        /* send data */
        if ( DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id] == null )
        {
            Log.d(TAG, "sendLabel: printer is empty");
            return;
        }
        DeviceConnFactoryManager.getDeviceConnFactoryManagers()[id].sendDataImmediately( datas );
    }

    public Bitmap drawTextOnImage(Bitmap bm, String text, int x, int y, float textSize, int color)
    {
        Bitmap newBitmap = null;

        try
        {
            Bitmap.Config config = bm.getConfig();
            if(config == null){
                config = Bitmap.Config.ARGB_8888;
            }

            newBitmap = Bitmap.createBitmap(bm.getWidth(), bm.getHeight(), config);
            Canvas newCanvas = new Canvas(newBitmap);

            newCanvas.drawBitmap(bm, 0, 0, null);

            /* ------------------- Draw transperent background --------------- */

            /* --------------------------------------------------------------- */
            Rect rectText1 = new Rect();
            if(text!=null)
            {
                Paint paintText1 = new Paint(Paint.ANTI_ALIAS_FLAG);
                //paintText1.setColor(Color.BLACK);
                paintText1.setColor(color);
                paintText1.setTextSize(textSize);
                paintText1.setStyle(Paint.Style.FILL);

                paintText1.getTextBounds(text, 0, text.length(), rectText1);

                newCanvas.drawText(text, x, y, paintText1);
            }

        }catch (Exception e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return newBitmap;
    }

    public Bitmap drawImageOnImage(Bitmap background, Bitmap pic, int x_to_draw, int y_to_draw, int width, int height)
    {
        try
        {
            Canvas newCanvas = new Canvas(background);
            Bitmap img_bitmap = Bitmap.createScaledBitmap(pic, width, height, true);
            newCanvas.drawBitmap(img_bitmap, x_to_draw, y_to_draw,new Paint());
        }catch (Exception e)
        {
        }

        return background;
    }

    public ArrayList<Object> getBluetoothParedDevicesList()
    {
        ArrayList<Object> listPairedDevices = new ArrayList<>();
        listPairedDevices.clear();

        Set<BluetoothDevice> pairedDevices = mBluetoothAdapter.getBondedDevices();

        for (BluetoothDevice device : pairedDevices)
        {
            listPairedDevices.add(device.getName()+" "+device.getAddress());
            //listPairedDevices.add(device);
        }

        System.out.println("Paired Devices => "+pairedDevices.size());

        return listPairedDevices;
    }

    public static String bitMapToString(Bitmap bitmap)
    {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, baos);
        byte[] b = baos.toByteArray();
        String temp = Base64.encodeToString(b, Base64.DEFAULT);
        return temp;
    }
}