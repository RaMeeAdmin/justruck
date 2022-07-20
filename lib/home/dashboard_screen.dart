import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_banner_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/driver/driver_list_screen.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/manifest/manifest_list_screen.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/parcel/book_parcel_screen.dart';
import 'package:justruck/parcel/book_parcel_list_screen.dart';
import 'package:justruck/parcel/parcel_list_tab_screen.dart';
import 'package:justruck/routes/route_list_screen.dart';
import 'package:justruck/vehicles/vehicle_list_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';


class DashboardScreen extends StatefulWidget
{
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen>
{
  String role = "0";

  final List<Widget> _listDashboardGridWidgets = List.empty(growable: true);
  List<BeanBannerDetails> _listBannerDetails = List.empty(growable: true);

  @override
  void initState()
  {
    _getSharedPreferences();

    _listBannerDetails = BeanBannerDetails.getDefaultBanners();
  }

  _getSharedPreferences() async
  {
    print("preparing list");
    role = await PreferenceHelper.getLoggedInAs();

    _listDashboardGridWidgets.clear();

    if(role == CommonConstants.typeTransporter)
    {
      setState(()
      {
        _listDashboardGridWidgets.add(_widgetParcelBookingOption());
        _listDashboardGridWidgets.add(_widgetParcelListOption());
        _listDashboardGridWidgets.add(_widgetManifestOption());
        _listDashboardGridWidgets.add(_widgetRoutesOption());
        _listDashboardGridWidgets.add(_widgetVehicleOption());
        _listDashboardGridWidgets.add(_widgetDriverOption());
      });
    }
    else if(role == CommonConstants.typeTrucker)
    {
      setState(()
      {
        _listDashboardGridWidgets.add(_widgetManifestOption());
        _listDashboardGridWidgets.add(_widgetRoutesOption());
        _listDashboardGridWidgets.add(_widgetVehicleOption());
        _listDashboardGridWidgets.add(_widgetDriverOption());
      });
    }
    else if(role == CommonConstants.typeDriver)
    {
      setState(()
      {
        _listDashboardGridWidgets.add(_widgetManifestOption());
      });
    }
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
                Container(
                  width: double.infinity,
                  child: Card(
                      elevation: 2,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          aspectRatio: 16/7,
                        ),
                        items: _buildBannerSlider(),
                      )
                  ),
                ),
                Expanded(child: _buildDashboardGrid()),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildDashboardGrid()
  {
    var _dashboardWidgets = GridView.builder(
      itemCount: _listDashboardGridWidgets.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (context, index)
        {
          return _listDashboardGridWidgets[index];
        }
    );

    return _dashboardWidgets;
  }

  List <Widget> _buildBannerSlider()
  {
    List<Widget> listWidgets = List.empty(growable: true);
    for (int i=0; i<_listBannerDetails.length; i++)
    {
      listWidgets.add(Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          child: Image.network(_listBannerDetails[i].imageURL, fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace)
              {
                return CommonWidgets.notFoundPlaceHolder();
              })
          )
      );
    }

    return listWidgets;
  }

  Widget _widgetParcelBookingOption()
  {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                color: Colors.indigo,
                child: Padding(padding: const EdgeInsets.all(7),
                    child: Image.asset('assets/icons/ic_parcel.png',
                      fit: BoxFit.scaleDown,
                      width: Style.dashboardIconSize,
                      height: Style.dashboardIconSize,
                    )
                ),
              ),
              Align(alignment: Alignment.center,
                  child: Text(S.of(context).parcelBooking, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis)
              ),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> BookParcelScreen())),
    );
  }

  Widget _widgetParcelListOption()
  {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                color: Colors.pink,
                child: Padding(padding: const EdgeInsets.all(7),
                    child: Image.asset('assets/icons/ic_list.png',
                      fit: BoxFit.scaleDown,
                      width: Style.dashboardIconSize,
                      height: Style.dashboardIconSize,
                      color: Colors.white,
                    )
                ),
              ),
              Align(alignment: Alignment.center,
                  child: Text(S.of(context).parcelList, textAlign: TextAlign.center)
              ),
            ],
          ),
        ),
      ),
      //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> BookedParcelListScreen())),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ParcelListTabScreen())),
    );
  }

  Widget _widgetManifestOption()
  {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                color: Colors.deepOrange,
                child: Padding(padding: const EdgeInsets.all(7),
                    child: Image.asset('assets/icons/ic_manifest.png',
                      fit: BoxFit.scaleDown,
                      width: Style.dashboardIconSize,
                      height: Style.dashboardIconSize,
                      color: Colors.white,
                    )
                ),
              ),
              Align(alignment: Alignment.center,
                  child: Text(S.of(context).manifest, textAlign: TextAlign.center)
              ),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ManifestListScreen())),
    );
  }

  Widget _widgetRoutesOption()
  {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                color: brown,
                child: Padding(padding: const EdgeInsets.all(7),
                    child: Image.asset('assets/icons/ic_route.png',
                      fit: BoxFit.scaleDown,
                      width: Style.dashboardIconSize,
                      height: Style.dashboardIconSize,
                      color: Colors.white,
                    )
                ),
              ),
              Align(alignment: Alignment.center,
                  child: Text(S.of(context).myRoutes, textAlign: TextAlign.center)
              ),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> RouteListScreen())),
    );
  }

  Widget _widgetVehicleOption()
  {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                color: yellow,
                child: Padding(padding: const EdgeInsets.all(7),
                    child: Image.asset('assets/icons/ic_truck.png',
                      fit: BoxFit.scaleDown,
                      width: Style.dashboardIconSize,
                      height: Style.dashboardIconSize,
                      color: Colors.white,
                    )
                ),
              ),
              Align(alignment: Alignment.center,
                  child: Text(S.of(context).myVehicles, textAlign: TextAlign.center)
              ),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> VehicleListScreen())),
    );
  }

  Widget _widgetDriverOption()
  {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                color: purple,
                child: Padding(padding: const EdgeInsets.all(7),
                    child: Image.asset('assets/icons/ic_driver.png',
                      fit: BoxFit.scaleDown,
                      width: Style.dashboardIconSize,
                      height: Style.dashboardIconSize,
                    )
                ),
              ),
              Align(alignment: Alignment.center,
                  child: Text(S.of(context).drivers, textAlign: TextAlign.center)
              ),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> DriverListScreen())),
    );
  }

  Widget _widgetTempOption()
  {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                color: purple,
                child: Padding(padding: const EdgeInsets.all(7),
                    child: Image.asset('assets/icons/ic_flutter.png',
                      fit: BoxFit.scaleDown,
                      width: Style.dashboardIconSize,
                      height: Style.dashboardIconSize,
                    )
                ),
              ),
              const Align(alignment: Alignment.center,
                  child: Text("Temp", textAlign: TextAlign.center)
              ),
            ],
          ),
        ),
      ),
      onTap: () => {
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyOTPScreen("9028309690")))
      },
    );
  }
}