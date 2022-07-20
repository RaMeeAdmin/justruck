import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:justruck/beans/bean_city.dart';
import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/beans/bean_route_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/customWidgets/widget_intermediate_location.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/pick_city_screen.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/web_api/add_route_api.dart';

class AddRouteScreen extends StatefulWidget
{
  _AddRouteScreen createState() => _AddRouteScreen();
}

class _AddRouteScreen extends State<AddRouteScreen>
{
  bool _showProgress = false;

  TextEditingController _controllerRouteName = TextEditingController();
  TextEditingController _controllerRadiusInKM = TextEditingController();

  List<WidgetIntermediateLocation> listWidgetIntermediateLoc = List.empty(growable: true);

  List _routeTypeList = CommonConstants.routeType;
  late String _selectedRouteType;

  bool showRadiusField = true;

  BeanCity _selectedStartCity = BeanCity("0", Strings.startLocation+" *");
  BeanCity _selectedEndCity = BeanCity("0", Strings.endLocation+" *");

  @override
  void initState()
  {
    _selectedRouteType = _routeTypeList[0];
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
        appBar: AppBar(title: Text(S.of(context).addRoute)),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerRouteName,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          decoration: InputDecoration(
                            labelText: S.of(context).routeName+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      GestureDetector(
                          child: CommonWidgets.pickCityField(_selectedStartCity.cityName),
                          onTap: () async
                          {
                            BeanCity cityDetails = await Navigator.push(context, MaterialPageRoute(builder: (context)=> PickCityScreen(S.of(context).startLocation)));
                            setState(() {
                              _selectedStartCity = cityDetails;
                            });
                          }
                      ),
                      GestureDetector(
                          child: CommonWidgets.pickCityField(_selectedEndCity.cityName),
                          onTap: () async
                          {
                            BeanCity cityDetails = await Navigator.push(context, MaterialPageRoute(builder: (context)=> PickCityScreen(S.of(context).endLocation)));
                            setState(() {
                              _selectedEndCity = cityDetails;
                            });
                          }
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: CommonWidgets.getH2NormalText(S.of(context).intermediateLocations, Colors.black),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: _buildIntermediateLocationList(),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              label: Text(S.of(context).addAnother),
                              style: ElevatedButton.styleFrom(primary: logo3),
                              onPressed: ()
                              {
                                addIntermediateLocation();
                              }
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: Row(
                          children: [
                            CommonWidgets.getH2NormalText(S.of(context).routeType+" *", Colors.black),
                            Expanded(flex: 1, child: getPayRadioButton(0)),
                            Expanded(flex: 1, child: getPayRadioButton(1))
                          ],
                        ),
                      ),
                      Visibility(
                        visible: showRadiusField,
                          child: Container(
                            margin: const EdgeInsets.only(top:10.0),
                            child: TextFormField(
                              controller: _controllerRadiusInKM,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              maxLength: 30,
                              decoration: InputDecoration(
                                labelText: S.of(context).radiusInKM+" *",
                                counterText: "",
                                contentPadding: Style.getTextFieldContentPadding(),
                                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                              ),
                            ),
                          )
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top:10.0),
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(S.of(context).addRoute.toUpperCase()),
                          ),
                          onPressed: ()
                          {
                            if(validate())
                            {
                              _submitRouteDetails();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: Visibility(
                  visible: _showProgress,
                  child: const CircularProgressIndicator(strokeWidth: CommonConstants.progressBarWidth),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildIntermediateLocationList()
  {
    var _intermediateLocationsList = ListView.builder(
        shrinkWrap: true,
        itemCount: listWidgetIntermediateLoc.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index)
        {
          return Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                      child: CommonWidgets.pickCityField(listWidgetIntermediateLoc[index].selectedLocation.cityName),
                      onTap: () async
                      {
                        BeanCity cityDetails = await Navigator.push(context, MaterialPageRoute(builder: (context)=> PickCityScreen(S.of(context).pickLocation)));
                        setState(() {
                          listWidgetIntermediateLoc[index].selectedLocation = cityDetails;
                        });
                      }
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_sharp, color: Colors.grey,),
                  onPressed :() => removeIntermediateLocation(index),
                )
              ],
            ),
          );
        }
    );
    return _intermediateLocationsList;
  }

  Row getPayRadioButton(int index)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          visualDensity: VisualDensity(horizontal: -3, vertical: -3),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeColor: Theme.of(context).primaryColor,
          value: _routeTypeList[index],
          groupValue: _selectedRouteType,
          onChanged: (value)
          {
            setState(()
            {
              _selectedRouteType = value.toString();
              print(value);
              if(_selectedRouteType.toLowerCase() == CommonConstants.routeType[0].toString().toLowerCase())
              {
                // if open
                setState(() {
                  showRadiusField = true;
                });
              }
              else
              {
                // if Point to Point
                setState(() {
                  showRadiusField = false;
                });
              }
            });
          },
        ),
        Expanded(
            flex: 1,
            child: Text(_routeTypeList[index])
        )
      ],
    );
  }

  addIntermediateLocation()
  {
    setState(()
    {
      listWidgetIntermediateLoc.add(WidgetIntermediateLocation());
    });
  }

  removeIntermediateLocation(int index)
  {
    setState(() {
      listWidgetIntermediateLoc.removeAt(index);
    });
  }

  bool validate()
  {
    bool valid = true;

    if(_controllerRouteName.text.trim().toString().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterRouteName);
    }
    else if(_selectedStartCity.cityId=="0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectStartLocation);
    }
    else if(_selectedEndCity.cityId=="0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectEndLocation);
    }
    else if(_selectedRouteType.toLowerCase()==CommonConstants.routeType[0].toLowerCase()
        && _controllerRadiusInKM.text.trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterRadius);
    }

    return valid;
  }

  _submitRouteDetails() async
  {
    String routeName = _controllerRouteName.text.trim().toString();
    String startLocationId = _selectedStartCity.cityId;
    String endLocationId = _selectedEndCity.cityId;

    String routeType = "";

    if(_selectedRouteType.toLowerCase()==CommonConstants.routeType[0].toLowerCase()) {
      routeType = CommonConstants.routeTypeOpen;
    }
    else {
      routeType = CommonConstants.routeTypePointToPoint;
    }

    BeanRouteDetails routeDetails = BeanRouteDetails("", routeName, startLocationId, endLocationId);
    routeDetails.routeType = routeType;
    routeDetails.radiusInKM = _controllerRadiusInKM.text.toString().trim();

    List<BeanIdValue> intermediateLocations = List.empty(growable: true);

    for (int i=0; i < listWidgetIntermediateLoc.length; i++)
    {
      String id = listWidgetIntermediateLoc[i].selectedLocation.cityId;
      String value = listWidgetIntermediateLoc[i].selectedLocation.cityName;
      intermediateLocations.add(BeanIdValue(id, value));
    }

    routeDetails.listIntermediateLocations = intermediateLocations;

    setState(() { _showProgress = true; });

    bool routeAdded = await AddRouteAPI.saveRouteDetails(routeDetails);

    setState(() { _showProgress = false; });

    if(routeAdded)
    {
      Navigator.of(context).pop(true);
    }
  }
}