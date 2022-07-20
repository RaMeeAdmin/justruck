import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_location_details.dart';
import 'package:justruck/beans/bean_manifest_details.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/common_functions.dart';
import 'package:justruck/other/location_helper.dart';
import 'package:justruck/other/permission_helper.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:justruck/web_api/get_manifest_details_api.dart';
import 'package:justruck/web_api/remove_parcel_from_manifest_api.dart';
import 'package:justruck/web_api/save_parcel_track_api.dart';

class ManifestDetailsScreen extends StatefulWidget
{
  final String manifestId;
  const ManifestDetailsScreen(this.manifestId);
  _ManifestDetailsScreen createState() => _ManifestDetailsScreen();
}

class _ManifestDetailsScreen extends State<ManifestDetailsScreen>
{
  BeanManifestDetails manifestDetails = BeanManifestDetails("", "", "", "", "");
  List<BeanParcelDetails> _listManifestParcels = List.empty(growable: true);
  BeanLocationDetails beanLocationDetails = BeanLocationDetails("0.0", "0.0", "");

  String role = "";
  bool _showProgress = false, _showNotFound = false;
  bool _scanButtonVisibility = false, _confirmButtonVisibility = false;

  @override
  void initState()
  {
    //_listManifestParcels = BeanParcelDetails.getBookedParcelList();
    _getSharedPreferences();
    _getManifestDetails();
    _checkLocationPermission();
  }

  _getSharedPreferences() async
  {
    role = await PreferenceHelper.getLoggedInAs();
    if(role == CommonConstants.typeDriver)
    {
      setState(() {
        _scanButtonVisibility = true;
        _confirmButtonVisibility = true;
      });
    }
    else
    {
      setState(() {
        _scanButtonVisibility = false;
        _confirmButtonVisibility = false;
      });
    }
  }

  _checkLocationPermission() async
  {
    bool granted = await PermissionHelper.checkLocationPermission();
    if(!granted)
    {
      await PermissionHelper.requestLocationPermission();
    }
    else
    {
      beanLocationDetails = await LocationHelper.getDeviceLocation();
    }
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
        appBar: AppBar(title: Text(S.of(context).manifestDetails), elevation: 0.5),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Column(
                      children:
                      [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3.0),
                              decoration: Style.getSquareBorder(),
                              child: Column(
                                children: [
                                  CommonWidgets.getH4NormalText(S.of(context).manifestId, gray),
                                  CommonWidgets.getH4NormalText(widget.manifestId, Colors.black, maxLines: 1),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: Style.getSquareBorder(),
                                child: Column(
                                  children: [
                                    CommonWidgets.getH4NormalText(S.of(context).date, gray),
                                    CommonWidgets.getH4NormalText(CommonFunctions.getFormattedDate(manifestDetails.manifestDate), Colors.black, maxLines: 1),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: Style.getSquareBorder(),
                                child: Column(
                                  children: [
                                    CommonWidgets.getH4NormalText(S.of(context).vehicleNumber, gray, maxLines: 1),
                                    CommonWidgets.getH4NormalText(manifestDetails.vehicleNumber, Colors.black, maxLines: 1),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: Style.getSquareBorder(),
                                child: Column(
                                  children: [
                                    CommonWidgets.getH4NormalText(S.of(context).from, gray, maxLines: 1),
                                    CommonWidgets.getH4NormalText(manifestDetails.routeStartLocName, Colors.black, maxLines: 1),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: Style.getSquareBorder(),
                                child: Column(
                                  children: [
                                    CommonWidgets.getH4NormalText(S.of(context).to, gray, maxLines: 1),
                                    CommonWidgets.getH4NormalText(manifestDetails.routeEndLocName, Colors.black, maxLines: 1),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: Style.getSquareBorder(),
                                child: Column(
                                  children: [
                                    CommonWidgets.getH4NormalText(S.of(context).driverName, gray, maxLines: 1),
                                    CommonWidgets.getH4NormalText(manifestDetails.driverName, Colors.black, maxLines: 1),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: Style.getSquareBorder(),
                                child: Column(
                                  children: [
                                    CommonWidgets.getH4NormalText(S.of(context).driverMobileNumber, gray),
                                    CommonWidgets.getH4NormalText(manifestDetails.driverMobileNo, Colors.black, maxLines: 1),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 0.0, top: 5.0),
                      width: double.infinity,
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonWidgets.getH3NormalText(S.of(context).parcelDetails, Colors.black),
                                CommonWidgets.getH4NormalText(CommonFunctions.replacePatternByText("[count]", _listManifestParcels.length.toString(), S.of(context).parcelsOnRoute), logo3),
                              ],
                            ),
                          ),
                          Visibility(
                              visible: _scanButtonVisibility,
                              child: ElevatedButton.icon(
                                  icon: const Icon(Icons.qr_code_scanner),
                                  label: Text(S.of(context).scanQR),
                                  style: ElevatedButton.styleFrom(primary: logo3),
                                  onPressed: ()
                                  {
                                    _openScanner();
                                  }
                              )
                          )
                        ],
                      )
                  ),
                  Expanded(
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 0.0, top: 0.0),
                            padding: const EdgeInsets.all(3.0),
                            child: _buildParcelDetailsList(),
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
                      )
                  ),
                  Visibility(
                      visible: _confirmButtonVisibility,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(S.of(context).confirmLoading.toUpperCase()),
                          ),
                          onPressed: ()
                          {
                            if(_validate())
                            {
                              _markParcelToInTransitState();
                            }
                            else
                            {
                              CommonWidgets.showToast(S.of(context).plzScanQRCodeOnParcel);
                            }
                          },
                        ),
                      )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParcelDetailsList()
  {
    var _parcelDetailsList = ListView.builder(
        shrinkWrap: true,
        itemCount: _listManifestParcels.length,
        itemBuilder: (context, index)
        {
          return Card(
            margin: const EdgeInsets.only(top: 5, left: 1, right: 1),
            clipBehavior: Clip.hardEdge,
            elevation: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Style.getColorByParcelStatus(_listManifestParcels[index].parcelStatus),
                  padding: const EdgeInsets.all(5.0),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: CommonWidgets.getH4NormalText(BeanParcelDetails.getParcelStatusString(_listManifestParcels[index].parcelStatus), Colors.white),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CommonWidgets.getH3NormalText(_listManifestParcels[index].parcelId, Colors.black),
                      ),
                      Wrap(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CommonWidgets.getH3NormalText(_listManifestParcels[index].senderCityName, skyBlue)
                          ),
                          Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CommonWidgets.getH3NormalText(S.of(context).to, Colors.grey)
                          ),
                          Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CommonWidgets.getH3NormalText(_listManifestParcels[index].receiverCityName, skyBlue)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Visibility(
                      visible: _listManifestParcels[index].isSelected,
                        child: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                const Icon(Icons.done, color: Colors.green),
                                CommonWidgets.getH4NormalText(Strings.scanned, lightGray),
                              ],
                            ),
                          ),
                          onTap: () {
                            _removeFromScanListAlert(index);
                          }
                        )
                    )
                  ],
                ),
                Column(
                  children: [
                    Visibility(
                        visible: ( role == CommonConstants.typeTransporter &&
                            _listManifestParcels[index].parcelStatus.toLowerCase().trim() == CommonConstants.statusBooked)
                            ? true : false,
                        child: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  const Icon(Icons.close, color: Colors.red),
                                  CommonWidgets.getH4NormalText(S.of(context).remove, Colors.red),
                                ],
                              ),
                            ),
                            onTap: () {
                              _removeFromManifestListAlert(index);
                            }
                        )
                    )
                  ],
                )
              ],
            ),
          );
        },
    );
    return _parcelDetailsList;
  }

  _openScanner() async
  {
    final result = await BarcodeScanner.scan();
    String scannedDetails = result.rawContent;
    if(scannedDetails.trim().isNotEmpty)
    {
      int position = _searchParcelIdPositionInList(scannedDetails);

      if(position>-1)
      {
        if(_listManifestParcels[position].parcelStatus.toLowerCase() == CommonConstants.statusBooked.toLowerCase())
        {
          setState(() {
            _listManifestParcels[position].isSelected = true;
          });
        }
        else
        {
          CommonWidgets.showMessagePopup(context, S.of(context).message, S.of(context).bookedStatusOnly, false);
        }
      }
      else
      {
        CommonWidgets.showMessagePopup(context, S.of(context).message, S.of(context).notInManifest, false);
      }
    }
  }

  int _searchParcelIdPositionInList(String parcelId)
  {
    int position = -1;

    for (int i=0; i<_listManifestParcels.length; i++)
    {
      if(_listManifestParcels[i].parcelId==parcelId)
      {
        position = i;
        break;
      }
    }

    return position;
  }

  Future<void> _removeFromScanListAlert(int index) async
  {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text(S.of(context).confirmation),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget> [
                Text(CommonFunctions.replacePatternByText("[parcel_id]", _listManifestParcels[index].parcelId, S.of(context).removeFromScannedMessage)),
              ],
            ),
          ),
          actions: <Widget> [
            TextButton(
              child: Text(S.of(context).no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).yesRemove),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _listManifestParcels[index].isSelected = false;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _removeFromManifestListAlert(int index) async
  {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text(S.of(context).confirmation),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget> [
                Text(CommonFunctions.replacePatternByText("[parcel_id]", _listManifestParcels[index].parcelId, S.of(context).removeFromManifestMessage)),
              ],
            ),
          ),
          actions: <Widget> [
            TextButton(
              child: Text(S.of(context).no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).yesRemove),
              onPressed: ()
              {
                Navigator.of(context).pop();
                _removeParcelFromManifest(index);
              },
            ),
          ],
        );
      },
    );
  }

  bool _validate()
  {
    bool _valid = false;

    for (int i=0; i < _listManifestParcels.length; i++)
    {
      if(_listManifestParcels[i].isSelected==true)
      {
        _valid = true;
        break;
      }
    }

    return _valid;
  }

  _getManifestDetails() async
  {
    setState(()
    {
      _showNotFound = false;
      _showProgress = true;
    });

    BeanManifestDetails tempDetails = await GetManifestDetailsAPI.getManifestDetailsFor(widget.manifestId);
    if(tempDetails.listParcelDetails.isNotEmpty)
    {
      setState(()
      {
        manifestDetails = tempDetails;
        _listManifestParcels = tempDetails.listParcelDetails;
        _showProgress = false;
      });
    }
    else
    {
      setState(()
      {
        _showNotFound = true;
        _showProgress = false;
      });
    }
  }

  _markParcelToInTransitState() async
  {
    List<BeanParcelDetails> _tempList = List.empty(growable: true);

    for (int i=0; i < _listManifestParcels.length; i++)
    {
      if(_listManifestParcels[i].isSelected==true)
      {
        _listManifestParcels[i].parcelStatus = CommonConstants.statusInTransit;
        _listManifestParcels[i].trackDescription = CommonConstants.inTransitMessage;
        _listManifestParcels[i].isScanned = "N";

        _tempList.add(_listManifestParcels[i]);
      }
    }

    setState(() { _showProgress = true; });

    bool marked = await SaveParcelTrackAPI.updateParcelTrack(_tempList, beanLocationDetails);

    setState(() { _showProgress = false; });

    if(marked)
    {
      Navigator.of(context).pop(true);
    }
  }

  _removeParcelFromManifest(int index) async
  {
    setState(() { _showProgress = true; });

    BeanResponse response = await RemoveParcelFromManifestAPI.removeParcelFromManifestList(widget.manifestId, _listManifestParcels[index].parcelId.toString());

    if(response.success)
    {
      setState(() {
        _listManifestParcels.removeAt(index);
        _showProgress = false;
      });
    }
    else
    {
      setState(() { _showProgress = false; });
    }
  }
}