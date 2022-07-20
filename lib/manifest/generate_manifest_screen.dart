import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_manifest_details.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_route_details.dart';
import 'package:justruck/beans/bean_trucker_details.dart';
import 'package:justruck/beans/bean_vehicle_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/web_api/add_manifest_api.dart';
import 'package:justruck/web_api/get_parcel_list_api.dart';
import 'package:justruck/web_api/get_parcel_list_routewise_api.dart';
import 'package:justruck/web_api/get_route_list_api.dart';
import 'package:justruck/web_api/get_vehicle_list_api.dart';

class GenerateManifestScreen extends StatefulWidget
{
  _GenerateManifestScreen createState() => _GenerateManifestScreen();
}

class _GenerateManifestScreen extends State<GenerateManifestScreen>
{
  List<BeanRouteDetails> _listRoutes = List.empty(growable: true);
  late BeanRouteDetails _selectedRoute;

  List<BeanVehicleDetails> _listVehicles = List.empty(growable: true);
  late BeanVehicleDetails _selectedVehicle;

  List<BeanParcelDetails> _listParcelDetails = List.empty(growable: true);
  List<BeanParcelDetails> _listFilteredParcelDetails = List.empty(growable: true);

  bool _showProgress = false, _showNotFound = false, _showList = false;
  bool checkedAll = false;
  int checkedParcelCount = 0;

  TextEditingController _controllerSearch = TextEditingController();

  @override
  void initState()
  {
    _listRoutes = BeanRouteDetails.getDefaultRoutes();
    _selectedRoute = _listRoutes[0];

    _listVehicles = BeanVehicleDetails.getDefaultVehicleList();
    _selectedVehicle = _listVehicles[0];

    //_listParcelDetails = BeanParcelDetails.getBookedParcelList();

    _getDataFromServer();
  }

  _getDataFromServer() async
  {
    await _getMyRouteList();
    await _getMyVehicleList();
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
        appBar: AppBar(title: Text(S.of(context).generateManifest)),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              decoration: Style.getRoundedGreyBorder(),
                              margin: const EdgeInsets.only(top: 0, right: 2),
                              child: Padding(
                                padding: const EdgeInsets.only(left:3,top: 0,bottom: 0, right: 3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 5, right: 5),
                                  child: DropdownButton<BeanRouteDetails>(
                                    value: _selectedRoute,
                                    isExpanded: true,
                                    underline: Container(color: Colors.transparent),
                                    items: _listRoutes.map((type) =>
                                        DropdownMenuItem(
                                            child: CommonWidgets.getH3NormalText(type.routeName, Colors.black),
                                            value: type)
                                    ).toList(),
                                    onChanged: (value)
                                    {
                                      _unCheckAllParcels();
                                      _handleCheckCountAndStat();

                                      setState(()
                                      {
                                        _selectedRoute = value!;
                                      });

                                      _controllerSearch.clear();
                                      _getRouteWiseParcelList();
                                    },
                                  ),
                                ),
                              ),
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              decoration: Style.getRoundedGreyBorder(),
                              margin: const EdgeInsets.only(top: 0, left: 2),
                              child: Padding(
                                padding: const EdgeInsets.only(left:3,top: 0,bottom: 0, right: 3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 5, right: 5),
                                  child: DropdownButton<BeanVehicleDetails>(
                                    value: _selectedVehicle,
                                    isExpanded: true,
                                    underline: Container(color: Colors.transparent),
                                    items: _listVehicles.map((type) =>
                                      DropdownMenuItem(
                                          child: CommonWidgets.getH3NormalText(type.vehicleNumber, Colors.black),
                                          value: type)
                                    ).toList(),
                                    onChanged: (value)
                                    {
                                      setState(()
                                      {
                                        _selectedVehicle = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Visibility(
                            visible: _showList,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Checkbox(
                                              value: checkedAll,
                                              checkColor: Colors.white,
                                              activeColor: logo3,
                                              onChanged: (checkStatus)
                                              {
                                                if(checkStatus==true) {
                                                  _checkAllParcels();
                                                }
                                                else {
                                                  _unCheckAllParcels();
                                                }

                                                _handleCheckCountAndStat();
                                              }
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CommonWidgets.getH3NormalText(checkedParcelCount.toString(), Colors.black),
                                              const SizedBox(width: 5),
                                              CommonWidgets.getH3NormalText(S.of(context).selected, Colors.black)
                                            ],
                                          )
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          color: veryLightGray,
                                          margin: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
                                          child: TextFormField(
                                            controller: _controllerSearch,
                                            textInputAction: TextInputAction.done,
                                            style: const TextStyle(color: Colors.black),
                                            textAlignVertical: TextAlignVertical.center,
                                            onChanged: (String value)
                                            {
                                              List<BeanParcelDetails> _tempList = _filterParcelList(value);
                                              setState(() {
                                                _listFilteredParcelDetails = _tempList;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: S.of(context).search,
                                              hintStyle: const TextStyle(color: Colors.grey),
                                              contentPadding: const EdgeInsets.only(left: 10),
                                              isDense: true,
                                              suffixIcon: IconButton(
                                                icon: const Icon(Icons.close),
                                                onPressed: ()
                                                {
                                                  _controllerSearch.clear();
                                                  List<BeanParcelDetails> _tempList = _filterParcelList("");
                                                  setState(() {
                                                    _listFilteredParcelDetails = _tempList;
                                                  });
                                                },
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Expanded(
                                    child: _buildParcelDetailsList(),
                                  ),
                                ],
                              )
                          ),
                          Center(
                            child: Visibility(
                              visible: _showProgress,
                              child: const CircularProgressIndicator(strokeWidth: CommonConstants.progressBarWidth),
                            ),
                          ),
                          Center(
                            child: CommonWidgets.getNoDetailsFoundWidget(_showNotFound, S.of(context).parcelDetailsNotFoundForSelectedRoute),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top:10.0),
                      child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(S.of(context).generateManifest.toUpperCase()),
                        ),
                        onPressed: ()
                        {
                          if(_validate())
                          {
                            _generateManifest();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
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
        itemCount: _listFilteredParcelDetails.length,
        itemBuilder: (context, index)
        {
          return Card(
            margin: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Checkbox(
                    value: _listFilteredParcelDetails[index].checked,
                    checkColor: Colors.white,
                    activeColor: logo3,
                    onChanged: (checkStatus)
                    {
                      setState(() {
                        _listFilteredParcelDetails[index].checked = checkStatus!;
                        _handleCheckCountAndStat();
                      });
                    }
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 1.0, bottom: 1.0),
                              child: CommonWidgets.getH3NormalText(_listFilteredParcelDetails[index].parcelId, Colors.black),
                            ),
                            Row(
                              children: [
                                Container(
                                  color: Style.getColorByParcelStatus(_listFilteredParcelDetails[index].parcelStatus),
                                  padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 1.0, bottom: 1.0),
                                  child: CommonWidgets.getH3NormalText(BeanParcelDetails.getParcelStatusString(_listFilteredParcelDetails[index].parcelStatus), Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Wrap(
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 1.0, bottom: 1.0),
                                child: CommonWidgets.getH3NormalText(_listFilteredParcelDetails[index].senderCityName, skyBlue)
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 1.0, bottom: 1.0),
                                child: CommonWidgets.getH3NormalText(S.of(context).to, Colors.grey)
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 1.0, bottom: 1.0),
                                child: CommonWidgets.getH3NormalText(_listFilteredParcelDetails[index].receiverCityName, skyBlue)
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 1.0, bottom: 1.0),
                                child: CommonWidgets.getH3NormalText(S.of(context).from, Colors.grey)
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 1.0, bottom: 1.0),
                                  child: CommonWidgets.getH3NormalText(_listFilteredParcelDetails[index].senderName, Colors.black)
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 1.0, bottom: 1.0),
                                child: CommonWidgets.getH3NormalText(S.of(context).to, Colors.grey)
                            ),
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 1.0, bottom: 1.0),
                                    child: CommonWidgets.getH3NormalText(_listFilteredParcelDetails[index].receiverName, Colors.black)
                                ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 1.0, bottom: 1.0),
                                child: CommonWidgets.getH3NormalText(S.of(context).bookingDate, Colors.grey)
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 1.0, bottom: 1.0),
                                child: CommonWidgets.getH3NormalText(_listFilteredParcelDetails[index].parcelBookingDate, Colors.black)
                            ),
                          ],
                        )
                      ],
                    ),
                )
              ],
            )
          );
        }
    );
    return _parcelDetailsList;
  }

  _checkAllParcels()
  {
    for (int i=0; i < _listParcelDetails.length; i++)
    {
      _listParcelDetails[i].checked = true;
    }
  }

  _unCheckAllParcels()
  {
    for (int i=0; i < _listParcelDetails.length; i++)
    {
      _listParcelDetails[i].checked = false;
    }
  }

  _handleCheckCountAndStat()
  {
    bool allChecked = true;
    int checkedCount = 0;
    for (int i=0; i < _listParcelDetails.length; i++)
    {
      if(_listParcelDetails[i].checked == true)
      {
        checkedCount = checkedCount + 1;
      }
    }

    if(checkedCount > 0 && checkedCount == _listParcelDetails.length )
    {
      allChecked = true;
    }
    else
    {
      allChecked = false;
    }

    if(allChecked)
    {
      setState(()
      {
        checkedAll = true;
        checkedParcelCount = checkedCount;
      });
    }
    else
    {
      setState(()
      {
        checkedAll = false;
        checkedParcelCount = checkedCount;
      });
    }
  }

  _filterParcelList(String pattern)
  {
    List<BeanParcelDetails> _tempList = List.empty(growable: true);
    _tempList.clear();

    for (int i=0; i<_listParcelDetails.length; i++)
    {
      if( _listParcelDetails[i].parcelId.toLowerCase().contains(pattern.toLowerCase()) ||
          _listParcelDetails[i].senderCityName.toLowerCase().contains(pattern.toLowerCase()) ||
          _listParcelDetails[i].receiverCityName.toLowerCase().contains(pattern.toLowerCase())
      )
      {
        _tempList.add(_listParcelDetails[i]);
      }
    }

    return _tempList;
  }

  bool _validate()
  {
    bool valid = true;

    if(_selectedRoute.routeId=="0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectRoute);
    }
    else if(_selectedVehicle.vehicleId=="0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectVehicle);
    }
    else if(checkedParcelCount==0)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).selectParcelToAddInManifest);
    }

    return valid;
  }

  _getMyRouteList() async
  {
    setState(() { _showProgress = true; });

    List<BeanRouteDetails> tempList = await GetRouteListAPI.getRouteList();

    if(tempList.isNotEmpty)
    {
      setState(() {
        _listRoutes.addAll(tempList);
      });
    }

    setState(() { _showProgress = false; });
  }

  _getMyVehicleList() async
  {
    setState(() { _showProgress = true; });

    List<BeanVehicleDetails> tempList = await GetVehicleListAPI.getVehicleDetailsList();

    if(tempList.isNotEmpty)
    {
      setState(() {
        _listVehicles.addAll(tempList);
      });
    }

    setState(() { _showProgress = false; });
  }

  _getRouteWiseParcelList() async
  {
    setState(()
    {
      _showList = false;
      _showNotFound = false;
      _showProgress = true;
    });

    String routeId = _selectedRoute.routeId;
    List<BeanParcelDetails> tempList = await GetParcelListRouteWiseAPI.retrieveParcelListForRoute(routeId);

    if(tempList.isNotEmpty)
    {
      setState(()
      {
        _showList = true;
        _listParcelDetails = tempList;
        _listFilteredParcelDetails = _listParcelDetails;
        _showProgress = false;
      });
    }
    else
    {
      setState(()
      {
        _showList = false;
        _showNotFound = true;
        _showProgress = false;
      });
    }
  }

  _generateManifest() async
  {
    List<BeanParcelDetails> listManifestParcels = List.empty(growable: true);
    listManifestParcels.clear();

    for (int i=0; i<_listParcelDetails.length; i++)
    {
      if(_listParcelDetails[i].checked)
      {
        listManifestParcels.add(_listParcelDetails[i]);
      }
    }

    BeanManifestDetails md = BeanManifestDetails("", "", "", "", "");
    md.listParcelDetails = listManifestParcels;
    md.vehicleNumber = _selectedVehicle.vehicleNumber;
    md.vehicleId = _selectedVehicle.vehicleId;
    md.routeId = _selectedRoute.routeId;

    setState(() { _showProgress = true; });

    bool manifestAdded = await AddManifestAPI.generateManifest(md);

    setState(() { _showProgress = false; });

    if(manifestAdded)
    {
      Navigator.of(context).pop(true);
    }
  }
}