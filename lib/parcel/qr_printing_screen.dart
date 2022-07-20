import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/settings/settings_screen.dart';

class QRPrintingScreen extends StatefulWidget
{
  final String parcelId, receiverName, fromCityName, toCityName, bookingAgencyName, qrCodeURL;
  const QRPrintingScreen(this.parcelId, this.receiverName, this.fromCityName, this.toCityName, this.bookingAgencyName, this.qrCodeURL);
  _QRPrintingScreen createState() => _QRPrintingScreen();
}

class _QRPrintingScreen extends State<QRPrintingScreen>
{
  static const platform = MethodChannel('com.ramee.justruck/printing');

  BeanIdValue _labelPrinterDetails = BeanIdValue("", "");

  @override
  void initState()
  {
    _initUI();
  }

  _initUI() async
  {
    _labelPrinterDetails = await PreferenceHelper.getLabelPrinterDetails();

    setState(() {

    });
  }

  Future<bool> _onWillPop()
  {
    Navigator.of(context).pop();
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context)
  {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).viewPrintQR)),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Image.network(widget.qrCodeURL, fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace)
                          {
                            return CommonWidgets.notFoundPlaceHolder();
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: CommonWidgets.getH3NormalText(widget.parcelId, Colors.black),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: Style.getSquareBorder(),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(5.0),
                                child: _labelPrinterDetails.id.trim().isEmpty ?
                                Column(
                                  children: [
                                    CommonWidgets.getH4NormalText(S.of(context).noPrinterSet, Colors.black),
                                    CommonWidgets.getH4NormalText(S.of(context).tapToSet, Colors.grey),
                                  ],
                                ) :
                                Column(
                                  children: [
                                    CommonWidgets.getH4NormalText(_labelPrinterDetails.value, Colors.black),
                                    CommonWidgets.getH4NormalText(_labelPrinterDetails.id, Colors.grey),
                                  ],
                                ),
                              ),
                              onTap: () async
                              {
                                await Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsScreen()));
                                _initUI();
                              },
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                                child: Text(S.of(context).print),
                                style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap
                                ),
                                onPressed: () async
                                {
                                  if(Platform.isAndroid)
                                  {
                                    if(_labelPrinterDetails.id.trim().isNotEmpty)
                                    {
                                      _turnOnTheBluetooth();
                                    }
                                    else
                                    {
                                      bool? action = await CommonWidgets.showMessagePopup(context, S.of(context).message,
                                          S.of(context).noPrinterSet+" "+S.of(context).plzSetPrinter, false);
                                    }
                                  }
                                  else
                                  {
                                    _showAndroidOnlyDialog();
                                  }
                                }
                            )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showAndroidOnlyDialog() async
  {
    showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text(S.of(context).message),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget> [
                CommonWidgets.getH3NormalText(S.of(context).printAndroidOnlyMessage, Colors.black),
              ],
            ),
          ),
          actions: <Widget> [
            TextButton(
              child: Text(S.of(context).okay),
              onPressed: ()
              {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  _turnOnTheBluetooth() async
  {
    try {
      await platform.invokeMethod('checkBluetoothPermission',
      {
        "parcelId":widget.parcelId,
        "receiverName":widget.receiverName,
        "fromCityName":widget.fromCityName,
        "toCityName":widget.toCityName,
        "bookingAgency":widget.bookingAgencyName,
        "qrCodeURL":widget.qrCodeURL,
        "bluetoothDeviceId": _labelPrinterDetails.id.trim(),
      });
    } on PlatformException catch (e)
    {

    }
  }
}