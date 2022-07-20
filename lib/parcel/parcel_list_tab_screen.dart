import 'package:flutter/material.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/parcel/book_parcel_list_screen.dart';

class ParcelListTabScreen extends StatefulWidget
{
  _ParcelListTabScreen createState() => _ParcelListTabScreen();
}

class _ParcelListTabScreen extends State<ParcelListTabScreen>
{
  int initialIndex = 0;

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
        appBar: AppBar(
          title: Text(S.of(context).parcelList),
          elevation: 0,
        ),
        body: SafeArea(
            child: DefaultTabController(
              length: 2,
              initialIndex: initialIndex,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    color: primaryColor,
                    child: TabBar(
                      indicatorColor: Colors.white,
                      indicatorWeight: 5,
                      labelColor: Colors.white,
                      tabs: [
                        Tab(text: S.of(context).bookedParcels),
                        Tab(text: S.of(context).receivingParcels),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                          color: primaryColor,
                          child:TabBarView(
                            children: [
                              BookedParcelListScreen(CommonConstants.bookedParcelList),
                              BookedParcelListScreen(CommonConstants.receivingParcelList),
                            ],
                          )
                      )
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }
}