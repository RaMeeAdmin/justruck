import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_manifest_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/manifest/generate_manifest_screen.dart';
import 'package:justruck/manifest/manifest_details_screen.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/common_functions.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/web_api/get_manifest_list_api.dart';

class ManifestListScreen extends StatefulWidget
{
  _ManifestListScreen createState() => _ManifestListScreen();
}

class _ManifestListScreen extends State<ManifestListScreen>
{
  List<BeanManifestDetails> listManifestDetails = List.empty(growable: true);
  bool _showAddFab = true;
  bool _showProgress = false, _showNotFound = false;
  String role = "0";

  @override
  void initState()
  {
    //listManifestDetails = BeanManifestDetails.getDefaultManifestList();
    _getSharedPreferences();
  }

  _getSharedPreferences() async
  {
    role = await PreferenceHelper.getLoggedInAs();

    if(role == CommonConstants.typeTransporter)
    {
      setState(() {
        _showAddFab = true;
      });
    }
    else
    {
      setState(() {
        _showAddFab = false;
      });
    }

    _getManifestList();
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
        appBar: AppBar(title: Text(S.of(context).manifest)),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:10.0, bottom: 10, left: 5.0, right: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildManifestDetailsList(),
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
                child: CommonWidgets.getNoDetailsFoundWidget(_showNotFound, S.of(context).manifestDetailsNotFound),
              )
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: _showAddFab,
          child: FloatingActionButton.extended(
            backgroundColor: primaryColor,
            extendedIconLabelSpacing: 5,
            label: Text(
              S.of(context).neww,
              style: TextStyle(fontSize: 12),
            ),
            icon: const Icon(Icons.add, color: Colors.white, size: 13),
            onPressed: ()
            {
              _navigateToManifestGenerateScreen();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildManifestDetailsList()
  {
    var _manifestDetailsList = ListView.builder(
        shrinkWrap: true,
        itemCount: listManifestDetails.length,
        itemBuilder: (context, index)
        {
          return GestureDetector(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: CommonWidgets.getH3NormalText(listManifestDetails[index].vehicleNumber, Colors.black)
                        ),
                        CommonWidgets.getH3NormalText("# "+listManifestDetails[index].manifestId, Colors.black),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidgets.getH3NormalText(S.of(context).routeName+" : ", Colors.grey),
                        Expanded(
                            child: CommonWidgets.getH3NormalText(
                                listManifestDetails[index].routeStartLocName.toString().trim()+" - "+
                                    listManifestDetails[index].routeEndLocName.toString().trim(), logo3
                            )
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidgets.getH3NormalText(S.of(context).driverName+" : ", Colors.grey),
                        Expanded(
                            child: CommonWidgets.getH3NormalText(listManifestDetails[index].driverName, Colors.black)
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidgets.getH3NormalText(S.of(context).driverMobileNumber+" : ", Colors.grey),
                        Expanded(
                            child: CommonWidgets.getH3NormalText(listManifestDetails[index].driverMobileNo, skyBlue)
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidgets.getH3NormalText(S.of(context).manifestDate+" : ", Colors.grey),
                        Expanded(
                            child: CommonWidgets.getH3NormalText(
                                CommonFunctions.getFormattedDate(listManifestDetails[index].manifestDate)+" \u2022 "+
                                    CommonFunctions.getTwelveHourTime(listManifestDetails[index].timeCreated),
                                Colors.black
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            onTap: () => _decideScreenToJump(listManifestDetails[index].manifestId),
          );
        }
    );
    return _manifestDetailsList;
  }

  _navigateToManifestGenerateScreen() async
  {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> GenerateManifestScreen()));
    if(result==true)
    {
      _getManifestList();
    }
  }

  _decideScreenToJump(String manifestId) async
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ManifestDetailsScreen(manifestId)));
  }

  _getManifestList() async
  {
    setState(()
    {
      _showProgress = true;
      _showNotFound = false;
    });

    List<BeanManifestDetails> tempList = await GetManifestListAPI.getManifestList();

    if(tempList.isNotEmpty)
    {
      setState(()
      {
        _showProgress = false;
        listManifestDetails = tempList;
      });
    }
    else
    {
      setState(()
      {
        _showProgress = false;
        _showNotFound = true;
      });
    }
  }
}