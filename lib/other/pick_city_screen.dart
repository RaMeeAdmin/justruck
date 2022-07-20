import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_city.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/web_api/get_city_list_by_name_api.dart';

class PickCityScreen extends StatefulWidget
{
  final String title;
  const PickCityScreen(this.title);
  _PickCityScreen createState() => _PickCityScreen();
}

class _PickCityScreen extends State<PickCityScreen>
{
  TextEditingController _controllerCityName = TextEditingController();

  List<BeanCity> listCitiesMain = List.empty(growable: true);
  List<BeanCity> listCitiesTemp = List.empty(growable: true);
  bool _showProgress = false;

  @override
  void initState()
  {

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
        appBar: AppBar(title: Text(widget.title)),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: _controllerCityName,
                  keyboardType: TextInputType.text,
                  onChanged: (String value)
                  {
                    if(value.length == 3)
                    {
                      _getCityListByName(value.toString().trim());
                    }
                    else if(value.length > 3)
                    {
                      _searchCityLocallyFromList(value.toString().trim());
                    }
                    else if(value.length < 3)
                    {
                      setState(() {
                        listCitiesMain.clear();
                        listCitiesTemp.clear();
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: Strings.searchByCityName+" *",
                    counterText: "",
                    contentPadding: Style.getTextFieldContentPadding(),
                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                  ),
                ),
                Expanded(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                                child: _buildCityList()
                            ),
                          ],
                        ),
                        Center(
                          child: Visibility(
                            visible: _showProgress,
                            child: const CircularProgressIndicator(strokeWidth: CommonConstants.progressBarWidth),
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  _buildCityList()
  {
    var _parcelDetailsList = ListView.separated(
      shrinkWrap: true,
      itemCount: listCitiesTemp.length,
      itemBuilder: (context, index)
      {
        return GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>
              [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CommonWidgets.getH3NormalText(listCitiesTemp[index].cityName, skyBlue),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      CommonWidgets.getH4NormalText(listCitiesTemp[index].districtName, Colors.grey),
                      CommonWidgets.getH4NormalText(" | ", Colors.grey),
                      CommonWidgets.getH4NormalText(listCitiesTemp[index].pinCode, Colors.grey)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CommonWidgets.getH4NormalText(listCitiesTemp[index].stateName, Colors.grey),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.pop(context, listCitiesTemp[index]);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index)
      {
        return Container(
          height: 1,
          color: lightGray, // Custom style
        );
      },
    );
    return _parcelDetailsList;
  }

  _searchCityLocallyFromList(String pattern)
  {
    List<BeanCity> tempList = List.empty(growable: true);
    listCitiesMain.forEach((cityDetails)
    {
      if(cityDetails.cityName.toString().toLowerCase().contains(pattern.toLowerCase()))
      {
        tempList.add(cityDetails);
      }

      if(tempList.length>0)
      {
        setState(() {
          listCitiesTemp = tempList;
        });
      }
    });
  }

  _getCityListByName(String pattern) async
  {
    setState(() {
      listCitiesMain.clear();
      _showProgress = true;
    });

    List<BeanCity> tempList = await GetCityListByNameAPI.getCityListForMatchingPattern(pattern);

    setState(() { _showProgress = false; });

    if(tempList.length > 0)
    {
      listCitiesMain = tempList;
      listCitiesTemp = tempList;
      _searchCityLocallyFromList(_controllerCityName.text.toString());
      /*setState(() {
        listCities = tempList;
      });*/
    }
  }
}