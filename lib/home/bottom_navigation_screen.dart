import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_login_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/customWidgets/menu_bottom_navigation.dart';
import 'package:justruck/customer/customer_list_screen.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/home/dashboard_screen.dart';
import 'package:justruck/language/change_language_screen.dart';
import 'package:justruck/login/change_password_screen.dart';
import 'package:justruck/login/login_screen.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/parcel/track_parcel_screen.dart';
import 'package:justruck/providers/update_grid_provider.dart';
import 'package:justruck/qr_scanner/qr_scanner_screen.dart';
import 'package:justruck/reports/reports_stat_screen.dart';
import 'package:justruck/settings/settings_screen.dart';
import 'package:provider/src/provider.dart';

class BottomNavigationScreen extends StatefulWidget
{
  _BottomNavigationScreen createState() => _BottomNavigationScreen();
}

class _BottomNavigationScreen extends State<BottomNavigationScreen>
{
  String role = "0";
  int _selectedPage = 0;

  final List<Widget> _pageOptions = [ DashboardScreen(), QRScannerScreen(), TrackParcelScreen(), ReportsStatScreen() ];
  List<String> _titles = [Strings.jusTruck, Strings.scanQR, Strings.trackParcel, Strings.reports];

  BeanLoginDetails loginDetails = BeanLoginDetails();

  bool _showMenuCustomer = false;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState()
  {
    _getSharedPreferences();
  }
  
  _getSharedPreferences() async
  {
    role = await PreferenceHelper.getLoggedInAs();
    loginDetails = await PreferenceHelper.getLoginDetails();

    if(role == CommonConstants.typeTransporter)
    {
      _showMenuCustomer = true;
    }
    else
    {
      _showMenuCustomer = false;
    }

    setState(() {

    });
  }

  _updateLabelsAsPerLocale(BuildContext context)
  {
    setState(() {
      _titles = [Strings.jusTruck, S.of(context).scanQR, S.of(context).trackParcel, S.of(context).reports];
    });
  }

  void _onItemTapped(int index)
  {
    setState(() {
      _selectedPage = index;
    });
  }

  Future<bool> _onWillPop() async
  {
    if(_scaffoldKey.currentState!.isDrawerOpen)
    {
      Navigator.of(context).pop();
      return Future<bool>.value(false);
    }
    else
    {
      //Navigator.of(context).pop();

      return await showDialog(context: context,
          builder: (BuildContext context)
         {
           return AlertDialog(
             title: Text(S.of(context).confirmation),
             content: SingleChildScrollView(
               child: ListBody(
                 children: [
                   Text(S.of(context).wantToExitApp)
                 ],
               ),
             ),
             actions: [
               TextButton(
                 child: Text(S.of(context).no),
                 onPressed: ()
                 {
                   Navigator.of(context).pop(false);
                 },
               ),
               TextButton(
                 child: Text(S.of(context).yesExit),
                 onPressed: ()
                 {
                   Navigator.of(context).pop(true);
                 },
               ),
             ],
           );
         }
      );
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_titles[_selectedPage]),
          /*actions: <Widget>
          [
            IconButton(onPressed:() { CommonWidgets.showToast("Scanning"); }, icon: const Icon(Icons.qr_code_scanner))
          ],*/
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [logo2, logo1])
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonWidgets.getFlutterIcon(70, 70),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: CommonWidgets.getH3NormalText(S.of(context).hello+", "+loginDetails.companyName, Colors.white),
                          //child: CommonWidgets.getH3NormalText(S.of(context).hello+", "+"A1 Transporters and Logistics Services Pvt Ltd", Colors.white),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: CommonWidgets.getH3NormalText(loginDetails.username, Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _showMenuCustomer,
                  child: ListTile(
                    title: Text(S.of(context).customers),
                    leading: const Icon(Icons.person),
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
                    onTap: ()
                    {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomerListScreen()));
                    },
                  )
              ),
              ListTile(
                title: Text(S.of(context).settings),
                leading: const Icon(Icons.settings),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
                onTap: () async
                {
                  Navigator.pop(context);
                  await Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsScreen()));
                  _updateLabelsAsPerLocale(context);
                },
              ),
              ListTile(
                title: Text(S.of(context).logout),
                leading: const Icon(Icons.power_settings_new),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
                onTap: ()
                {
                  Navigator.pop(context);
                  _logoutAlert();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: MenuBottomNavigation.getBottomNavigationMenu(context, role),
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedPage,
          selectedItemColor: logo3,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          elevation: 5,
        ),
        body: _pageOptions[_selectedPage],
      ),
    );
  }

  Future<void> _logoutAlert() async
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
              children: <Widget>[
                Text(S.of(context).logoutMessage),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).yesLogout),
              onPressed: ()
              {
                Navigator.of(context).pop();
                _logoutFromApp();
              },
            ),
          ],
        );
      },
    );
  }

  _logoutFromApp()
  {
    PreferenceHelper.clearAllPreferences();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
  }
}