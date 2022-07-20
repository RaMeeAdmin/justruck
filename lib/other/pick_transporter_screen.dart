import 'dart:math';

import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_registration_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/customer/add_customer_screen.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/web_api/get_transporter_details_api.dart';

class PickTransporterScreen extends StatefulWidget
{
  final String title, cityId, isHomeDeliveryProvided;
  const PickTransporterScreen(this.title, this.cityId, this.isHomeDeliveryProvided);

  _PickTransporterScreen createState() => _PickTransporterScreen();
}

class _PickTransporterScreen extends State<PickTransporterScreen>
{
  List<BeanRegistrationDetails> _listTransporters = List.empty(growable: true);

  bool _showProgress = false, _showNotFound = false;

  @override
  void initState()
  {
    _getTransporterDetails();
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
          child: Stack(
            children: [
              _buildTransporterList(),
              Center(
                child: Visibility(
                  visible: _showProgress,
                  child: const CircularProgressIndicator(strokeWidth: CommonConstants.progressBarWidth),
                ),
              ),
              Center(
                child: CommonWidgets.getNoDetailsFoundWidget(_showNotFound, Strings.transporterDetailsNotFound),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildTransporterList()
  {
    var _transporterDetailsList = ListView.builder(
        shrinkWrap: true,
        itemCount: _listTransporters.length,
        itemBuilder: (context, index)
        {
          return GestureDetector(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(color: _getRandomColor(), shape: BoxShape.circle),
                          child: Center(
                            child: CommonWidgets.getH1NormalText(_listTransporters[index].companyName[0].toUpperCase(), Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonWidgets.getH2NormalText(_listTransporters[index].companyName, Colors.black),
                                CommonWidgets.getH4NormalText(_listTransporters[index].addressLine1+", "+_listTransporters[index].addressLine2, gray),
                                _listTransporters[index].isHomeDeliveryProvided=="Y" ?
                                CommonWidgets.getH4NormalText(S.of(context).providesDoorStepDelivery, darkGreen) :
                                CommonWidgets.getH4NormalText(S.of(context).doorStepDeliveryUnavailable, Colors.red),
                              ],
                            )
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context, _listTransporters[index]);
            },
          );
        }
    );
    return _transporterDetailsList;
  }

  Color _getRandomColor()
  {
    List<Color> colors = [ logo1, logo2, logo3, darkBlue, skyBlue, opPrimaryRed,
      darkOrange, darkYellow, darkGreen, brown, yellow, purple ];

    Color randomColor = colors[Random().nextInt(colors.length)];

    return randomColor;
  }

  _getTransporterDetails() async
  {
    setState(() {
      _showProgress = true;
      _showNotFound = false;
    });

    List<BeanRegistrationDetails> tempList = await GetTransporterDetailsAPI.getTransporterDetailsFor(widget.cityId, widget.isHomeDeliveryProvided);
    if(tempList.isNotEmpty)
    {
      setState(() {
        _showProgress = false;
        _showNotFound = false;
        _listTransporters = tempList;
      });
    }
    else
    {
      setState(() {
        _showProgress = false;
        _showNotFound = true;
      });
    }
  }
}