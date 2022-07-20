import 'dart:io';

import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_login_details.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/customWidgets/widget_parcel_details.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/parcel/qr_printing_screen.dart';
import 'package:justruck/web_api/get_parcel_details_api.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';

class ParcelDetailsScreen extends StatefulWidget
{
  final String parcelId;
  const ParcelDetailsScreen(this.parcelId);
  _ParcelDetailsScreen createState() => _ParcelDetailsScreen();
}

class _ParcelDetailsScreen extends State<ParcelDetailsScreen>
{
  bool _showProgress = false, _showDetailsLayout = false;

  late BeanParcelDetails parcelDetails;

  @override
  void initState()
  {
    parcelDetails = BeanParcelDetails(widget.parcelId, "", "-", "-", "-", "-", "-");

    _getParcelDetails();
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
          appBar: AppBar(title: Text(S.of(context).parcelDetails)),
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Visibility(
                    visible: _showDetailsLayout,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                              child: WidgetParcelDetails.getParcelDetailsLayout(context, parcelDetails),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(right: 5),
                                  child: ElevatedButton.icon(
                                      icon: const Icon(Icons.print),
                                      label: Text(S.of(context).viewPrintReceipt, textAlign: TextAlign.center),
                                      style: ElevatedButton.styleFrom(primary: primaryColor),
                                      onPressed: ()
                                      {
                                        _printPDF();
                                      }
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(left: 5),
                                    child: ElevatedButton.icon(
                                        icon: const Icon(Icons.qr_code),
                                        label: Text(S.of(context).viewPrintQR, textAlign: TextAlign.center),
                                        style: ElevatedButton.styleFrom(primary: primaryColor),
                                        onPressed: ()
                                        {
                                          _printQR();
                                        }
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Visibility(
                    visible: _showProgress,
                    child: const CircularProgressIndicator(strokeWidth: CommonConstants.progressBarWidth),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  _getParcelDetails() async
  {
    setState(() {
    _showProgress = true;
    _showDetailsLayout = false;
    });

    BeanParcelDetails tempDetails = await GetParcelDetailsAPI.getParcelDetailsFor(widget.parcelId);

    if(tempDetails.listParcelItems.isNotEmpty)
    {
      setState(()
      {
        _showDetailsLayout = true;
        parcelDetails = tempDetails;
        _showProgress = false;
      });
    }
  }

  _printPDF() async
  {
    String receiptURL = parcelDetails.receiptURL.trim();
    print("Receipt URL => "+ receiptURL );

    if(receiptURL.endsWith(".pdf"))
    {
      setState(() { _showProgress = true; });

      var data = await http.get(Uri.parse(receiptURL));

      setState(() { _showProgress = false; });

      if(data.statusCode==404)
      {
        CommonWidgets.showToast("Error 404, "+S.of(context).receiptNotFound);
      }
      else
      {
        await Printing.layoutPdf(onLayout: (_) => data.bodyBytes);
      }
    }
    else
    {
      CommonWidgets.showToast(S.of(context).receiptNotFound);
    }
  }

  _printQR() async
  {
    BeanLoginDetails loginDetails = await PreferenceHelper.getLoginDetails();

    Navigator.push(context, MaterialPageRoute(builder: (context)=> QRPrintingScreen(
        parcelDetails.parcelId, parcelDetails.receiverName,
        parcelDetails.senderCityName, parcelDetails.receiverCityName,
        loginDetails.companyName, parcelDetails.qrCodeURL))
    );
  }
}