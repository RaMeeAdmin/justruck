import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_driver_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/driver/add_driver_screen.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/web_api/get_driver_list_api.dart';

class DriverListScreen extends StatefulWidget
{
  _DriverListScreen createState() => _DriverListScreen();
}

class _DriverListScreen extends State<DriverListScreen>
{
  List<BeanDriverDetails> _listDriversAll = List.empty(growable: true);
  List<BeanDriverDetails> _listDriversFiltered = List.empty(growable: true);

  bool _showProgress = false, _showNotFound = false;

  @override
  void initState()
  {
    //_listDriverDetails = BeanDriverDetails.getDefaultDriverList();
    _getDriverList();
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
        appBar: AppBar(title: Text(S.of(context).drivers)),
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
                        labelText: S.of(context).searchDriver,
                        hintText: S.of(context).driverSearchHint,
                        counterText: "",
                        contentPadding: Style.getTextFieldContentPadding(),
                        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                      ),
                      onChanged: (String query)
                      {
                        List<BeanDriverDetails> _tempList = filterList(query);
                        setState(() {
                          _listDriversFiltered = _tempList;
                        });
                      },
                    ),
                    Expanded(
                      child: _buildDriverList(),
                    ),
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
                child: CommonWidgets.getNoDetailsFoundWidget(_showNotFound, S.of(context).driverDetailsNotFound),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          extendedIconLabelSpacing: 5,
          label: Text(
            S.of(context).addDriver,
            style: TextStyle(fontSize: 12),
          ),
          icon: const Icon(Icons.add, color: Colors.white, size: 13),
          onPressed: ()
          {
            _navigateToAddDriverScreen();
          },
        ),
      ),
    );
  }

  _buildDriverList()
  {
    var _driverDetailsList = ListView.builder(
        shrinkWrap: true,
        itemCount: _listDriversFiltered.length,
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
                    height: 90,
                    child: Image.network(_listDriversFiltered[index].driverImage, fit: BoxFit.cover,
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
                          CommonWidgets.getH2NormalText(_listDriversFiltered[index].driverName, Colors.black),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidgets.getH3NormalText(S.of(context).mobileNumber+" : ", Colors.grey),
                              Expanded(
                                child: CommonWidgets.getH3NormalText(_listDriversFiltered[index].mobileNumber, skyBlue),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidgets.getH3NormalText(S.of(context).address+" : ", Colors.grey),
                              Expanded(
                                child: Text(_listDriversFiltered[index].currentAddressLine1,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle( fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black)
                                )
                              )
                            ],
                          ),
                          Wrap(
                            children: _getVehicleNumberChips(_listDriversFiltered[index].assignedVehicle),
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
    return _driverDetailsList;
  }

  List<Widget> _getVehicleNumberChips(String completeStringWithCommas)
  {
    List<Widget> _listChips = List.empty(growable: true);

    _listChips.add(CommonWidgets.getH3NormalText(S.of(context).assignedVehicle+" : ", Colors.grey));

    List<String> listVehicleNumbers = completeStringWithCommas.split(",");

    for (int i=0; i<listVehicleNumbers.length; i++)
    {
      if(listVehicleNumbers[i].toString().trim().isNotEmpty)
      {
        /*_listChips.add(
            Padding(padding: const EdgeInsets.all(1.0),
                child: Chip(
                    backgroundColor: veryLightGray,
                    label: CommonWidgets.getH4NormalText(listVehicleNumbers[i].toString().trim(), Colors.black),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,padding: const EdgeInsets.all(0)
                )
            )
        );*/

        _listChips.add(
            Container(
                color: veryLightGray,
                padding: const EdgeInsets.only(left: 3.0, right: 3.0, top: 1, bottom: 1),
                margin: const EdgeInsets.all(1.0),
                child: CommonWidgets.getH4NormalText(listVehicleNumbers[i].toString().trim(), Colors.black)
            )
        );

      }
    }

    return _listChips;
  }

  List<BeanDriverDetails> filterList(String pattern)
  {
    List<BeanDriverDetails> _tempList = List.empty(growable: true);
    _tempList.clear();

    for(int i=0; i<_listDriversAll.length; i++)
    {
      if(_listDriversAll[i].driverName.toLowerCase().contains(pattern.toLowerCase()))
      {
        _tempList.add(_listDriversAll[i]);
      }
      else if(_listDriversAll[i].mobileNumber.toLowerCase().contains(pattern.toLowerCase()))
      {
        _tempList.add(_listDriversAll[i]);
      }
    }

    return _tempList;
  }

  _navigateToAddDriverScreen() async
  {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> AddDriverScreen()));
    if(result==true)
    {
      _getDriverList();
    }
  }

  _getDriverList() async
  {
    setState(()
    {
      _showProgress = true;
      _showNotFound = false;
    });

    List<BeanDriverDetails> tempList = await GetDriverListAPI.getDriverDetailsList();

    setState(() { _showProgress = false; });

    if(tempList.length > 0)
    {
      setState(()
      {
        _listDriversAll = tempList;
        _listDriversFiltered = _listDriversAll;
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