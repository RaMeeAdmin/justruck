import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/language/change_language_screen.dart';
import 'package:justruck/login/change_password_screen.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/common_functions.dart';
import 'package:justruck/other/preference_helper.dart';

class SettingsScreen extends StatefulWidget
{
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen>
{
  static const platform = MethodChannel('com.ramee.justruck/printing');

  String _locale = "";
  BeanIdValue _labelPrinterDetails = BeanIdValue("", "");

  @override
  void initState()
  {
    _initUI();
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
        appBar: AppBar(title: Text(S.of(context).settings)),
        body: SafeArea(
          child: Stack(
            children:
            [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: CommonWidgets.getH3NormalText(S.of(context).common, darkGrey),
                                margin: const EdgeInsets.only(left: 5, bottom: 2)
                            ),
                            Card(
                              margin: EdgeInsets.zero,
                              elevation: 1,
                              child: Column(
                                children: [
                                  InkWell(
                                    child: CommonWidgets.getSettingsNavigationContainer(Icons.language,
                                        S.of(context).language, CommonFunctions.getLanguageNameFromLocale(_locale)),
                                    onTap: () async
                                    {
                                      await Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangeLanguageScreen()));
                                      _initUI();
                                    },
                                  ),
                                  CommonWidgets.getDividerLine(),
                                  InkWell(
                                    child: CommonWidgets.getSettingsNavigationContainer(Icons.lock,
                                        S.of(context).changePin, ""),
                                    onTap: () async
                                    {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePasswordScreen()));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top:15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: CommonWidgets.getH3NormalText(S.of(context).printer, darkGrey),
                                margin: const EdgeInsets.only(left: 5, bottom: 2)
                            ),
                            Card(
                              margin: EdgeInsets.zero,
                              elevation: 1,
                              child: Column(
                                children: [
                                  InkWell(
                                    child: CommonWidgets.getSettingsNavigationContainer(Icons.print, S.of(context).labelPrinter,
                                        _labelPrinterDetails.id.trim().isEmpty ? S.of(context).set :
                                        _labelPrinterDetails.value+"\n"+_labelPrinterDetails.id),
                                    onTap: () async
                                    {
                                      if(Platform.isAndroid)
                                      {
                                        List<BeanIdValue> _listPairedDevices = await _getPairedBluetoothDevice();
                                        BeanIdValue? printerDetails = await CommonWidgets.showIdValueListPopup(context,
                                            _listPairedDevices, S.of(context).selectPrinter,
                                            notFoundMessage: S.of(context).noPairedDeviceFound);
                                        if(printerDetails!=null && printerDetails.value.toString().trim().isNotEmpty)
                                        {
                                          await PreferenceHelper.setLabelPrinterDetails(printerDetails);
                                          _initUI();
                                        }
                                      }
                                      else
                                      {
                                        CommonWidgets.showMessagePopup(context, S.of(context).message,
                                            S.of(context).printAndroidOnlyMessage, false);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _initUI() async
  {
    _locale = await PreferenceHelper.getAppLanguage();
    _labelPrinterDetails = await PreferenceHelper.getLabelPrinterDetails();

    setState(()
    {

    });
  }

  Future<List<BeanIdValue>> _getPairedBluetoothDevice() async
  {
    List<BeanIdValue> _listPairedDevices = List.empty(growable: true);

    try
    {
      List<Object?> pairedDevice = await platform.invokeMethod('pairedDevices');

      for (int i=0; i<pairedDevice.length; i++)
      {
        String strIdName = pairedDevice[i].toString();

        String deviceName = strIdName.substring(0, strIdName.length-17);
        print("Name => "+deviceName);

        String deviceId = strIdName.substring(strIdName.length-17, strIdName.length);
        print("BT Device Id => "+deviceId);

        BeanIdValue btInfo = BeanIdValue(deviceId.trim(), deviceName.trim());
        _listPairedDevices.add(btInfo);
      }

    } on PlatformException catch (e)
    {
      print(e.stacktrace);
    }

    return _listPairedDevices;
  }
}