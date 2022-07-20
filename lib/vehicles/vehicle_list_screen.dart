import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_vehicle_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/vehicles/add_vehicle_screen.dart';
import 'package:justruck/web_api/get_vehicle_list_api.dart';

class VehicleListScreen extends StatefulWidget
{
  _VehicleListScreen createState() => _VehicleListScreen();
}

class _VehicleListScreen extends State<VehicleListScreen>
{
  List<BeanVehicleDetails> _listAllVehicles = List.empty(growable: true);
  List<BeanVehicleDetails> _listVehiclesFiltered = List.empty(growable: true);

  bool _showProgress = false, _showNotFound = false;

  @override
  void initState()
  {
    //listVehicleDetails = BeanVehicleDetails.getDefaultVehicleList();
    _getVehicleList();
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
        appBar: AppBar(title: Text(S.of(context).myVehicles)),
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
                        labelText: S.of(context).searchVehicle,
                        hintText: S.of(context).vehicleSearchHint,
                        counterText: "",
                        contentPadding: Style.getTextFieldContentPadding(),
                        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                      ),
                      onChanged: (String query)
                      {
                        List<BeanVehicleDetails> _tempList = filterList(query);
                        setState(() {
                          _listVehiclesFiltered = _tempList;
                        });
                      },
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top:10.0),
                        child: _buildVehicleList(),
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
                child: CommonWidgets.getNoDetailsFoundWidget(_showNotFound, S.of(context).vehicleDetailsNotFound),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          extendedIconLabelSpacing: 5,
          label: Text(
            S.of(context).addVehicle,
            style: TextStyle(fontSize: 12),
          ),
          icon: const Icon(Icons.add, color: Colors.white, size: 13),
          onPressed: ()
          {
            _navigateToAddVehicleScreen();
          },
        ),
      ),
    );
  }

  Widget _buildVehicleList()
  {
    var _vehicleDetailsList = ListView.builder(
        shrinkWrap: true,
        itemCount: _listVehiclesFiltered.length,
        itemBuilder: (context, index)
        {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  SizedBox(
                    width: 90,
                    height: 70,
                    child: Image.network(_listVehiclesFiltered[index].vehicleImage, fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace)
                        {
                          return CommonWidgets.notFoundPlaceHolder();
                        }),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      margin: const EdgeInsets.only(left :5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidgets.getH2NormalText(_listVehiclesFiltered[index].vehicleNumber, Colors.black),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidgets.getH3NormalText(S.of(context).brand+" : ", Colors.grey),
                              Expanded(child: CommonWidgets.getH3NormalText(_listVehiclesFiltered[index].vehicleBrandName, Colors.black))
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidgets.getH3NormalText(S.of(context).model+" : ", Colors.grey),
                              Expanded(child: CommonWidgets.getH3NormalText(_listVehiclesFiltered[index].vehicleModelName, Colors.black))
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidgets.getH3NormalText(S.of(context).loadCapacity+" : ", Colors.grey),
                              Expanded(child: CommonWidgets.getH3NormalText(_listVehiclesFiltered[index].loadCapacity, Colors.black))
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
    return _vehicleDetailsList;
  }

  List<BeanVehicleDetails> filterList(String pattern)
  {
    List<BeanVehicleDetails> _tempList = List.empty(growable: true);
    _tempList.clear();

    for(int i=0; i<_listAllVehicles.length; i++)
    {
      if(_listAllVehicles[i].vehicleNumber.toLowerCase().contains(pattern.toLowerCase()))
      {
        _tempList.add(_listAllVehicles[i]);
      }
      else if(_listAllVehicles[i].vehicleBrandName.toLowerCase().contains(pattern.toLowerCase()))
      {
        _tempList.add(_listAllVehicles[i]);
      }
      else if(_listAllVehicles[i].vehicleModelName.toLowerCase().contains(pattern.toLowerCase()))
      {
        _tempList.add(_listAllVehicles[i]);
      }
      else if(_listAllVehicles[i].loadCapacity.toLowerCase().contains(pattern.toLowerCase()))
      {
        _tempList.add(_listAllVehicles[i]);
      }
    }

    return _tempList;
  }

  _navigateToAddVehicleScreen() async
  {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> AddVehicleScreen()));
    if(result==true)
    {
      _getVehicleList();
    }
  }

  _getVehicleList() async
  {
    setState(()
    {
      _showProgress = true;
      _showNotFound = false;
    });

    List<BeanVehicleDetails> tempList = await GetVehicleListAPI.getVehicleDetailsList();

    setState(() { _showProgress = false; });

    if(tempList.length > 0)
    {
      setState(() {
        _listAllVehicles = tempList;
        _listVehiclesFiltered = _listAllVehicles;
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