import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_location_details.dart';
import 'package:justruck/beans/bean_login_details.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/customWidgets/widget_parcel_details.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/location_helper.dart';
import 'package:justruck/other/permission_helper.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/strings.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/parcel/parcel_delivery_screen.dart';
import 'package:justruck/web_api/get_parcel_details_api.dart';
import 'package:justruck/web_api/mark_parcel_received_api.dart';
import 'package:justruck/web_api/save_parcel_track_api.dart';


class QRScannerScreen extends StatefulWidget
{
  _QRScannerScreen createState() => _QRScannerScreen();
}

class _QRScannerScreen extends State<QRScannerScreen>
{
  String role = "0";
  bool _showScanMessage = true, _showDetailsLayout = false, _showProgress = false, _showNotFound = false;
  bool _receiveButtonVisibility = false;

  late BeanParcelDetails parcelDetails = BeanParcelDetails("-", "", "-", "-", "-", "-", "-");
  String scannedDetails = "";

  BeanLocationDetails beanLocationDetails = BeanLocationDetails("0.0", "0.0", "");
  BeanLoginDetails loginDetails = BeanLoginDetails();

  TextEditingController _controllerParcelNumber = TextEditingController();
  String _parcelIdToGetDetails = "";

  @override
  void initState()
  {
    _checkLocationPermission();
    _getSharedPreferences();
  }

  _getSharedPreferences() async
  {
    role = await PreferenceHelper.getLoggedInAs();
    loginDetails = await PreferenceHelper.getLoginDetails();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Visibility(
                        visible: _showDetailsLayout,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  WidgetParcelDetails.getParcelDetailsLayout(context, parcelDetails),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Visibility(
                                          visible: _receiveButtonVisibility,
                                          child: Container(
                                            margin: const EdgeInsets.only(right:3),
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              child: CommonWidgets.getH3NormalText(S.of(context).markReceived, Colors.white),
                                              onPressed: ()
                                              {
                                                _markParcelReceived(parcelDetails);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Visibility(
                                          visible: (
                                              parcelDetails.parcelStatus.trim().toLowerCase()!=CommonConstants.statusDelivered.toLowerCase() &&
                                              ( (role==CommonConstants.typeTransporter && loginDetails.userId == parcelDetails.receivingTransporterId) ||
                                                (role==CommonConstants.typeDriver && loginDetails.userId == parcelDetails.assignedDriverId) )
                                          ) ? true : false,
                                          child: Container(
                                            margin: const EdgeInsets.only(left:3),
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                child: CommonWidgets.getH3NormalText(S.of(context).proceedDelivery, Colors.white),
                                                onPressed: () async
                                                {
                                                  var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> ParcelDeliveryScreen(parcelDetails)));
                                                  if(result==true)
                                                  {
                                                    _getParcelDetails(_parcelIdToGetDetails);
                                                  }
                                                },
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(darkGreen))
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                      Center(
                        child: Visibility(
                          visible: _showScanMessage,
                          child: CommonWidgets.getH3NormalText(S.of(context).scanQRCodeOnParcel, Colors.black),
                        ),
                      ),
                      Center(
                        child: Visibility(
                          visible: _showProgress,
                          child: const CircularProgressIndicator(strokeWidth: CommonConstants.progressBarWidth),
                        ),
                      ),
                      Center(
                        child: CommonWidgets.getNoDetailsFoundWidget(_showNotFound, S.of(context).parcelDetailsNotFound),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                            icon: const Icon(Icons.qr_code_scanner),
                            label: Text(S.of(context).scanQR),
                            style: ElevatedButton.styleFrom(primary: logo3),
                            onPressed: ()
                            {
                              _openScanner();
                            }
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 0, top: 5, bottom: 5),
                            child: Column(
                              children: [
                                CommonWidgets.getH4NormalText(S.of(context).unableToScan, Colors.black),
                                CommonWidgets.getH4NormalText(S.of(context).searchHere, orange),
                              ],
                            ),
                          ),
                          onTap: () =>
                          {
                            _parcelNumberInputPopup()
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _parcelNumberInputPopup() async
  {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text(S.of(context).search),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget> [
                CommonWidgets.getH3NormalText(S.of(context).searchByParcelId, Colors.black),
                Container(
                  child: TextFormField(
                    controller: _controllerParcelNumber,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    maxLength: 30,
                    decoration: InputDecoration(
                      hintText: S.of(context).parcelId+" *",
                      counterText: "",
                      contentPadding: Style.getTextFieldContentPadding(),
                      border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).search),
              onPressed: ()
              {
                if(_controllerParcelNumber.text.toString().trim().isNotEmpty)
                {
                  Navigator.of(context).pop();
                  _parcelIdToGetDetails = _controllerParcelNumber.text.toString().trim();
                  _getParcelDetails(_parcelIdToGetDetails);
                }
                else
                {
                  CommonWidgets.showToast(S.of(context).plzEnterParcelNo);
                }
              },
            ),
          ],
        );
      },
    );
  }

  _openScanner() async
  {
    final result = await BarcodeScanner.scan();
    _parcelIdToGetDetails = result.rawContent;
    _getParcelDetails(_parcelIdToGetDetails);
  }

  _checkLocationPermission() async
  {
    bool granted = await PermissionHelper.checkLocationPermission();
    if(!granted)
    {
      print("Permission Not Granted");
      await PermissionHelper.requestLocationPermission();
    }
    else
    {
      print("Permission Granted");
      beanLocationDetails = await LocationHelper.getDeviceLocation();
    }
  }

  _getParcelDetails(String scannedParcelId) async
  {
    setState(()
    {
      _showScanMessage = false;
      _showDetailsLayout = false;
      _showProgress = true;
      _showNotFound = false;
    });

    BeanParcelDetails tempDetails = await GetParcelDetailsAPI.getParcelDetailsFor(scannedParcelId);

    if(tempDetails.parcelId!="0")
    {
      setState(()
      {
        parcelDetails = BeanParcelDetails.copyParcelDetails(tempDetails);

        _showScanMessage = false;
        _showDetailsLayout = true;
        _showProgress = false;
        _showNotFound = false;
      });

      if(role == CommonConstants.typeTransporter)
      {
        if(tempDetails.receivingTransporterId == loginDetails.userId && tempDetails.isReceived=="N")
        {
          setState(() {
            _receiveButtonVisibility = true;
          });
        }
        else
        {
          setState(() {
            _receiveButtonVisibility = false;
          });
        }
      }

      // Un comment below code if you want to keep track of scanned history

      /*List<BeanParcelDetails> listParcelDetails = List.empty(growable: true);
      BeanParcelDetails tempDetails1 = tempDetails;
      tempDetails1.parcelStatus = CommonConstants.statusScanned;
      tempDetails1.trackDescription = CommonConstants.scannedMessage;
      tempDetails1.isScanned = "Y";
      listParcelDetails.add(tempDetails1);

      setState(() { _showProgress = true; });
      bool marked = await SaveParcelTrackAPI.updateParcelTrack(listParcelDetails, beanLocationDetails);
      setState(() { _showProgress = false; });*/
    }
    else
    {
      setState(()
      {
        _showScanMessage = false;
        _showDetailsLayout = false;
        _showProgress = false;
        _showNotFound = true;
      });
    }
  }

  _markParcelReceived(BeanParcelDetails tempParcelDetails) async
  {
    setState(() {
      _showProgress = true;
    });

    BeanResponse beanResponse =  await MarkParcelReceivedAPI.markParcelAsReceived(tempParcelDetails.parcelId);
    if(beanResponse.success)
    {
      CommonWidgets.showToast(beanResponse.message);

      setState(()
      {
        parcelDetails.isReceived = "Y";
        _receiveButtonVisibility = false;
        _showProgress = false;
      });

      // after marking parcel as received. Updating parcel track details

      List<BeanParcelDetails> listParcelDetails = List.empty(growable: true);
      tempParcelDetails.parcelStatus = CommonConstants.statusReceived;
      tempParcelDetails.trackDescription = CommonConstants.receivedMessage +" "+loginDetails.companyName;
      tempParcelDetails.isScanned = "N";
      tempParcelDetails.isReceived = "Y";
      listParcelDetails.add(tempParcelDetails);

      setState(() { _showProgress = true; });
      bool marked = await SaveParcelTrackAPI.updateParcelTrack(listParcelDetails, beanLocationDetails);
      setState(() { _showProgress = false; });

    }
    else
    {
      setState(() {
        _showProgress = false;
      });
    }
  }
}