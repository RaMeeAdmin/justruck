import 'dart:math';

import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_customer_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/customer/add_customer_screen.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/web_api/get_customer_list_api.dart';

class CustomerListScreen extends StatefulWidget
{
  _CustomerListScreen createState() => _CustomerListScreen();
}

class _CustomerListScreen extends State<CustomerListScreen>
{
  List<BeanCustomerDetails> _listCustomers = List.empty(growable: true);

  bool _showProgress = false, _showNotFound = false;

  @override
  void initState()
  {
    _getCustomerList();
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
        appBar: AppBar(title: Text(S.of(context).customers)),
        body: SafeArea(
          child: Stack(
            children: [
              _buildCustomerList(),
              Center(
                child: Visibility(
                  visible: _showProgress,
                  child: const CircularProgressIndicator(strokeWidth: CommonConstants.progressBarWidth),
                ),
              ),
              Center(
                child: CommonWidgets.getNoDetailsFoundWidget(_showNotFound, S.of(context).customerDetailsNotFound),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          extendedIconLabelSpacing: 5,
          label: Text(
            S.of(context).neww,
            style: TextStyle(fontSize: 12),
          ),
          icon: const Icon(Icons.add, color: Colors.white, size: 13),
          onPressed: ()
          {
            _navigateToAddCustomerScreen();
          },
        )
      ),
    );
  }

  _buildCustomerList()
  {
    var _customerDetailsList = ListView.builder(
        shrinkWrap: true,
        itemCount: _listCustomers.length,
        itemBuilder: (context, index)
        {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 35.0,
                            height: 35.0,
                            decoration: BoxDecoration(color: _getRandomColor(), shape: BoxShape.circle),
                            child: Center(
                              child: CommonWidgets.getH1NormalText(_listCustomers[index].firstName[0].toUpperCase(), Colors.white),
                            ),
                          ),
                          Visibility(
                            visible: _listCustomers[index].customerType.toLowerCase()==CommonConstants.customerTypeFirm.toLowerCase() ? true : false,
                            child: const Icon(Icons.apartment_rounded),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: _listCustomers[index].customerType.toLowerCase()==CommonConstants.customerTypeFirm.toLowerCase() ? true : false,
                                child: Row(
                                  children: [
                                    CommonWidgets.getH2NormalText(_listCustomers[index].firmName, Colors.black)
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _listCustomers[index].customerType.toLowerCase()==CommonConstants.customerTypeFirm.toLowerCase() ? false : true,
                                child: Row(
                                  children: [
                                    CommonWidgets.getH2NormalText(_listCustomers[index].firstName+" "+_listCustomers[index].lastName, Colors.black),
                                  ],
                                ),
                              ),
                              CommonWidgets.getH3NormalText(_listCustomers[index].mobileNumber, gray),
                              CommonWidgets.getH3NormalText(_listCustomers[index].emailAddress, gray),
                            ],
                          )
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
    return _customerDetailsList;
  }

  Color _getRandomColor()
  {
    List<Color> colors = [
      logo1, logo2, logo3, darkBlue, skyBlue, opPrimaryRed,
      darkOrange, darkYellow, darkGreen, brown, yellow, purple ];

    Color randomColor = colors[Random().nextInt(colors.length)];

    return randomColor;
  }

  _navigateToAddCustomerScreen() async
  {
    BeanCustomerDetails tempCustDetails = await Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCustomer()));
    if(tempCustDetails!=null && tempCustDetails.id!="00")
    {
      _getCustomerList();
    }
  }

  _getCustomerList() async
  {
    setState(() {
      _showProgress = true;
      _showNotFound = false;
    });

    List<BeanCustomerDetails> tempList = await GetCustomerDetailsListAPI.getCustomerDetailsList("0");
    if(tempList.isNotEmpty)
    {
      setState(() {
        _showProgress = false;
        _showNotFound = false;
        _listCustomers = tempList;
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