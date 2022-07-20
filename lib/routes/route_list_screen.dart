import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/beans/bean_route_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/routes/add_route_screen.dart';
import 'package:justruck/web_api/get_route_list_api.dart';

class RouteListScreen extends StatefulWidget
{
  _RouteListScreen createState() => _RouteListScreen();
}

class _RouteListScreen extends State<RouteListScreen>
{
  bool _showProgress = false, _showNotFound = false;
  List<BeanRouteDetails> _listAllRoutes =  List.empty(growable: true);
  List<BeanRouteDetails> _listRoutesFiltered =  List.empty(growable: true);

  @override
  void initState()
  {
    //listRoutes = BeanRouteDetails.getDefaultRoutes();
    _getRoutesList();
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
        appBar: AppBar(
          title: Text(S.of(context).myRoutes),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:10.0, bottom: 10, left: 5.0, right: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: S.of(context).searchRoute,
                        hintText: S.of(context).routeSearchHint,
                        counterText: "",
                        contentPadding: Style.getTextFieldContentPadding(),
                        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                      ),
                      onChanged: (String query)
                      {
                        List<BeanRouteDetails> _tempList = filterList(query);
                        setState(() {
                          _listRoutesFiltered = _tempList;
                        });
                      },
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top:10.0),
                        child: _buildRouteList()
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Visibility(
                  visible: _showProgress,
                  child: const CircularProgressIndicator(strokeWidth: CommonConstants.progressBarWidth),
                ),
              ),
              Center(
                child: CommonWidgets.getNoDetailsFoundWidget(_showNotFound, S.of(context).routeDetailsNotFound),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          extendedIconLabelSpacing: 5,
          label: Text(
            S.of(context).addRoute,
            style: TextStyle(fontSize: 12),
          ),
          icon: const Icon(Icons.add, color: Colors.white, size: 13),
          onPressed: ()
          {
            _navigateToAddRouteScreen();
          },
        ),
      ),
    );
  }

  Widget _buildRouteList()
  {
    var _routeDetailsList = ListView.builder(
        shrinkWrap: true,
        itemCount: _listRoutesFiltered.length,
        itemBuilder: (context, index)
        {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CommonWidgets.getH3NormalText(_listRoutesFiltered[index].routeName, skyBlue),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_pin, size: 18, color: logo3),
                      Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CommonWidgets.getH3NormalText("...", Colors.grey)
                      ),
                      Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CommonWidgets.getH3NormalText(_listRoutesFiltered[index].startLocationName, Colors.black)
                      ),
                      Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CommonWidgets.getH3NormalText(S.of(context).to, Colors.grey)
                      ),
                      Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CommonWidgets.getH3NormalText(_listRoutesFiltered[index].endLocationName, Colors.black)
                      ),
                      Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CommonWidgets.getH3NormalText("...", Colors.grey)
                      ),
                      const Icon(Icons.location_pin, size: 18, color: logo1),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidgets.getH3NormalText(S.of(context).intermediateLocations, Colors.black),
                        Wrap(
                          children: _getIntermediateLocationWidget(_listRoutesFiltered[index].listIntermediateLocations),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
    return _routeDetailsList;
  }

  List<Widget> _getIntermediateLocationWidget(List<BeanIdValue> _listIntermediateLocations)
  {
    List<Widget> _listChips = List.empty(growable: true);

    for (int i=0; i<_listIntermediateLocations.length; i++)
    {
      _listChips.add( Padding(
          padding: const EdgeInsets.all(1.0),
          child: Chip(
              backgroundColor: veryLightGray,
              label: CommonWidgets.getH4NormalText(_listIntermediateLocations[i].value.toString().trim(), Colors.black),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,padding: const EdgeInsets.all(0)
          )
        ),
      );
    }

    return _listChips;
  }

  List<BeanRouteDetails> filterList(String pattern)
  {
    List<BeanRouteDetails> _tempList =  List.empty(growable: true);
    _tempList.clear();

    for(int i=0; i<_listAllRoutes.length; i++)
    {
      if(_listAllRoutes[i].routeName.toLowerCase().contains(pattern.toLowerCase()))
      {
        _tempList.add(_listAllRoutes[i]);
      }
      else if(_listAllRoutes[i].startLocationName.toLowerCase().contains(pattern.toLowerCase()) ||
              _listAllRoutes[i].endLocationName.toLowerCase().contains(pattern.toLowerCase()) )
      {
        _tempList.add(_listAllRoutes[i]);
      }
      else
      {
        List<BeanIdValue> intermediateLocations = _listAllRoutes[i].listIntermediateLocations;

        for(int im=0; im < intermediateLocations.length; im++)
        {
          if(intermediateLocations[im].value.toString().toLowerCase().contains(pattern.toLowerCase()))
          {
            _tempList.add(_listAllRoutes[i]);
            break;
          }
        }
      }
    }

    return _tempList;
  }

  _navigateToAddRouteScreen() async
  {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> AddRouteScreen()));
    if(result==true)
    {
      _getRoutesList();
    }
  }

  _getRoutesList() async
  {
    setState(()
    {
      _showProgress = true;
      _showNotFound = false;
    });

    List<BeanRouteDetails> tempList = await GetRouteListAPI.getRouteList();

    setState(() { _showProgress = false; });

    if(tempList.length > 0)
    {
      setState(() {
        _listAllRoutes = tempList;
        _listRoutesFiltered = _listAllRoutes;
      });
    }
    else
    {
      setState(() {
        _showNotFound = true;
      });
    }
  }
}