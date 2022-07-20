import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:justruck/beans/bean_date_time.dart';
import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/beans/bean_login_details.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_payment_mode.dart';
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/common_functions.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/parcel/parcel_details_screen.dart';
import 'package:justruck/parcel/qr_printing_screen.dart';
import 'package:justruck/web_api/add_parcel_api.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class ReviewParcelScreen extends StatefulWidget
{
  final BeanParcelDetails beanParcelDetails;
  const ReviewParcelScreen(this.beanParcelDetails);
  _ReviewParcelScreen createState() => _ReviewParcelScreen();
}

class _ReviewParcelScreen extends State<ReviewParcelScreen>
{
  bool _showProgress = false;

  List<BeanPaymentMode> _paymentModes = List.empty(growable: true);

  List<BeanIdValue> _listBookingType = List.empty(growable: true);
  late BeanIdValue _selectedBookingType;

  late BeanParcelDetails parcelDetails;
  late BeanDateTime beanDateTime;
  double _changeReturn = 0;

  @override
  void initState()
  {
    parcelDetails = widget.beanParcelDetails;
    beanDateTime = CommonFunctions.getCurrentDateTime();

    _paymentModes = BeanPaymentMode.getAvailablePaymentModes();

    _listBookingType = BeanIdValue.getBookingTypes();
    _selectedBookingType = _listBookingType[0];
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
          appBar: AppBar(title: Text(S.of(context).reviewBookingDetails)),
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: Style.getSquareBorder(),
                                child: Column(
                                  children: [
                                    CommonWidgets.getH4NormalText(S.of(context).date, gray),
                                    CommonWidgets.getH4NormalText(beanDateTime.readableDate, Colors.black),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: Style.getSquareBorder(),
                                child: Column(
                                  children: [
                                    CommonWidgets.getH4NormalText(S.of(context).from, gray, maxLines: 1),
                                    CommonWidgets.getH4NormalText(parcelDetails.senderCityName, Colors.black, maxLines: 1),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: Style.getSquareBorder(),
                                child: Column(
                                  children: [
                                    CommonWidgets.getH4NormalText(S.of(context).to, gray, maxLines: 1),
                                    CommonWidgets.getH4NormalText(parcelDetails.receiverCityName, Colors.black, maxLines: 1),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(3.0),
                          decoration: Style.getSquareBorder(),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonWidgets.getH4NormalText(S.of(context).senderName+":", gray),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: CommonWidgets.getH4NormalText(parcelDetails.senderName, Colors.black),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonWidgets.getH4NormalText(S.of(context).mobileNumber+":", gray),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: CommonWidgets.getH4NormalText(parcelDetails.senderMobile, Colors.black),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonWidgets.getH4NormalText(S.of(context).address+":", gray),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: CommonWidgets.getH4NormalText(parcelDetails.senderAddress, Colors.black),
                                  )
                                ],
                              ),
                            ],
                          )
                        ),
                        Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: Style.getSquareBorder(),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonWidgets.getH4NormalText(S.of(context).receiverName+":", gray),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: CommonWidgets.getH4NormalText(parcelDetails.receiverName, Colors.black),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonWidgets.getH4NormalText(S.of(context).mobileNumber+":", gray),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: CommonWidgets.getH4NormalText(parcelDetails.receiverMobile, Colors.black),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonWidgets.getH4NormalText(S.of(context).address+":", gray),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: CommonWidgets.getH4NormalText(parcelDetails.receiverAddress, Colors.black),
                                    )
                                  ],
                                ),
                              ],
                            )
                        ),

                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 14,
                                child: Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: Style.getSquareBorder(),
                                  child: CommonWidgets.getH4NormalText(S.of(context).doorStepDeliveryRequired, gray),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: Style.getSquareBorder(),
                                  child: CommonWidgets.getH4NormalText(parcelDetails.homeDeliveryRequired, Colors.black, maxLines: 1, textAlign: TextAlign.right),
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(3.0),
                            decoration: Style.getSquareBorderWithFill(),
                            child: CommonWidgets.getH4NormalText(S.of(context).parcelDetails, Colors.black)
                        ),
                        Column(
                          children: [

                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 14,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(S.of(context).description, gray),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText("-", Colors.black, maxLines: 1, textAlign: TextAlign.right),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 14,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(S.of(context).combinedWeight, gray),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(parcelDetails.totalWeight, Colors.black, maxLines: 1, textAlign: TextAlign.right),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 14,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(S.of(context).combinedDeclaredValue, gray),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(parcelDetails.totalDeclaredValue, Colors.black, maxLines: 1, textAlign: TextAlign.right),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 14,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(S.of(context).parcelCharges, gray),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(parcelDetails.parcelCharges, Colors.black, maxLines: 1, textAlign: TextAlign.right),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 14,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(S.of(context).cgst
                                          +" "+CommonConstants.cgstPercentage.toString()+"% "
                                          +S.of(context).ifApplicable, gray),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(parcelDetails.cgstCharges, Colors.black, maxLines: 1, textAlign: TextAlign.right),
                                    ),
                                  )
                                ],
                              ),
                            ),


                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 14,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(S.of(context).sgst
                                          +" "+CommonConstants.sgstPercentage.toString()+"% "
                                          +S.of(context).ifApplicable, gray),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(parcelDetails.sgstCharges, Colors.black, maxLines: 1, textAlign: TextAlign.right),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 14,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(S.of(context).insuranceCharges, gray),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(parcelDetails.insuranceCharges, Colors.black, maxLines: 1, textAlign: TextAlign.right),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 14,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorder(),
                                      child: CommonWidgets.getH4NormalText(S.of(context).totalPayable, gray),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: Style.getSquareBorderWithFill(fillColor: limeYellow),
                                      child: CommonWidgets.getH4NormalText(parcelDetails.totalAmount, Colors.black, maxLines: 1, textAlign: TextAlign.right),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Container(
                              decoration: Style.getSquareBorder(),
                              child:  Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(3.0),
                                      child: CommonWidgets.getH4NormalText(S.of(context).paymentStatus, gray),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Wrap(
                                          children: _getPayStatusWidget(),
                                        ),
                                      ),
                                    )
                                  ],
                              ),
                            ),

                          ],
                        ),

                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top:10.0),
                          child: ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: _selectedBookingType.id.toLowerCase()==CommonConstants.payStatusPaid.toLowerCase() ?
                              Text(S.of(context).payNow.toUpperCase()) :
                              Text(S.of(context).completeBooking.toUpperCase()),
                            ),
                            onPressed: ()
                            {
                              if(_selectedBookingType.id.toLowerCase()==CommonConstants.payStatusPaid.toLowerCase())
                              {
                                double _temp = calculateBalance(parcelDetails.totalAmount);
                                setState(() {
                                  _changeReturn = _temp;
                                });

                                _showPaymentDetailsPopup();
                              }
                              else
                              {
                                _submitParcelDetails();
                              }
                            },
                          ),
                        )
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

  _showPaymentDetailsPopup()
  {
    showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return StatefulBuilder(
              builder: (context, setState)
              {
                return AlertDialog(
                  titlePadding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
                  contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>
                      [
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: CommonWidgets.getH3NormalText(S.of(context).totalPayable, Colors.black),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                color: limeYellow,
                                padding: const EdgeInsets.only(right: 5, top: 10, bottom: 10, left: 5),
                                child: CommonWidgets.getH3NormalText(parcelDetails.totalAmount, Colors.black, textAlign: TextAlign.right),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Column(
                          children: [
                            for (int i=0; i<_paymentModes.length; i++)
                              GestureDetector(
                                child: Container(
                                  width: double.infinity,
                                  color: _paymentModes[i].selected ? veryVeryLightGray : Colors.white,
                                  padding: const EdgeInsets.all(2.0),
                                  margin: const EdgeInsets.all(1.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: CommonWidgets.getH4NormalText(_paymentModes[i].modeName,
                                                _paymentModes[i].selected ? primaryColor : Colors.black),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Visibility(
                                          visible: _paymentModes[i].selected ? true : false,
                                          maintainSize: true,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          child: TextFormField(
                                            controller: _paymentModes[i].controllerAmountTendered,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                              hintText: S.of(context).amountTendered,
                                              isDense: true,
                                              contentPadding: const EdgeInsets.only(right: 5, top: 10, bottom: 10, left: 5),
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.black, width: 1),
                                                borderRadius: BorderRadius.all(Radius.circular(0)),
                                              ),
                                            ),
                                            style: const TextStyle(fontSize: 12),
                                            onChanged: (String amountTendered)
                                            {
                                              double _temp = calculateBalance(parcelDetails.totalAmount);
                                              setState(() {
                                                _changeReturn = _temp;
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: ()
                                {
                                  setState(()
                                  {
                                    if(_paymentModes[i].selected)
                                    {
                                      _paymentModes[i].selected = false;
                                      _paymentModes[i].controllerAmountTendered.text ="";
                                    }
                                    else
                                    {
                                      _paymentModes[i].selected = true;
                                      double payableAmount = double.parse(parcelDetails.totalAmount);
                                      double tendered = calculateTotalTendered();
                                      double remaining = payableAmount - tendered ;
                                      _paymentModes[i].controllerAmountTendered.text = remaining.toStringAsFixed(2);
                                    }

                                    _changeReturn = calculateBalance(parcelDetails.totalAmount);

                                  });
                                },
                              ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: CommonWidgets.getH3NormalText(S.of(context).balanceAmount, Colors.black),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                color: limeYellow,
                                padding: const EdgeInsets.only(right: 5, top: 10, bottom: 10, left: 5),
                                child: CommonWidgets.getH3NormalText(_changeReturn.toString(), Colors.black, textAlign: TextAlign.right),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top:5.0),
                          child: ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(S.of(context).completeBooking.toUpperCase()),
                            ),
                            onPressed: ()
                            {
                              double balance = calculateBalance(parcelDetails.totalAmount);
                              if(balance != 0)
                              {
                                CommonWidgets.showToast(
                                    CommonFunctions.replacePatternByText("[balance amount]", balance.toString(),
                                    S.of(context).pendingBalanceMessage)
                                );
                              }
                              else
                              {
                                Navigator.of(context).pop();
                                _submitParcelDetails();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
          );
        }
    );
  }

  List<Widget> _getPayStatusWidget()
  {
    List<Widget> _listPayChipsWidgets = List.empty(growable: true);
    _listPayChipsWidgets.clear();

    for (int i=0; i<_listBookingType.length; i++)
    {
      _listPayChipsWidgets.add(
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: GestureDetector(
            child: Chip(
                backgroundColor: _listBookingType[i].checked ? primaryColor : veryLightGray,
                label: CommonWidgets.getH4NormalText(_listBookingType[i].value.toString().trim(),
                    _listBookingType[i].checked ? Colors.white : Colors.black),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.only(left:5, right: 5)
            ),
            onTap: ()
            {
              _setSelectedPayStatus(i);
            },
          )
      ),
      );
    }

    return _listPayChipsWidgets;
  }

  _setSelectedPayStatus(int index)
  {
    for (int i=0; i<_listBookingType.length; i++)
    {
      if(i==index) {
        _listBookingType[index].checked = true;
        _selectedBookingType = _listBookingType[index];
      }
      else {
        _listBookingType[i].checked = false;
      }
    }

    setState(() {

    });
  }

  bool _validate()
  {
    bool valid = true;

    return valid;
  }

  double calculateChangeReturn(String strAmountPayable, String strAmountTendered)
  {
    double _changeToReturn = 0;

    double payableAmount = double.parse(strAmountPayable);
    double amountTendered = double.parse(strAmountTendered);

    _changeToReturn = amountTendered - payableAmount;

    return _changeToReturn;
  }

  double calculateBalance(String strAmountPayable)
  {
    double payableAmount = double.parse(strAmountPayable);
    double amountTendered = 0;
    double _balanceAmount = 0;

    for(int i=0; i<_paymentModes.length; i++)
    {
      if(_paymentModes[i].selected)
      {
        String strTenderedAmount = _paymentModes[i].controllerAmountTendered.text.trim();
        double tempTenderedAmount = double.parse(strTenderedAmount.isEmpty ? "0" : strTenderedAmount);

        amountTendered = amountTendered + tempTenderedAmount;
      }
    }

    _balanceAmount = amountTendered - payableAmount;

    return double.parse(_balanceAmount.toStringAsFixed(2));
  }

  double calculateTotalTendered()
  {
    double amountTendered = 0;

    for(int i=0; i<_paymentModes.length; i++)
    {
      String strTenderedAmount = _paymentModes[i].controllerAmountTendered.text.trim();
      double tempTenderedAmount = double.parse(strTenderedAmount.isEmpty ? "0" : strTenderedAmount);

      amountTendered = amountTendered + tempTenderedAmount;
    }

    return double.parse(amountTendered.toStringAsFixed(2));
  }

  _submitParcelDetails() async
  {
    List<BeanIdValue> listPaymentDetails = List.empty(growable: true);

    for (int i=0; i<_paymentModes.length; i++)
    {
      if(_paymentModes[i].selected)
      {
        listPaymentDetails.add(BeanIdValue(_paymentModes[i].modeId, _paymentModes[i].controllerAmountTendered.text));
      }
    }

    parcelDetails.listPaymentDetails = listPaymentDetails;
    parcelDetails.parcelBookingType = _selectedBookingType.id;
    parcelDetails.parcelBookingDate = beanDateTime.date;
    parcelDetails.tenderedAmount = "";
    parcelDetails.changeReturn = "";

    setState(() { _showProgress = true; });
    BeanResponse bookingResponse = await AddParcelAPI.bookParcelDetails(parcelDetails);
    setState(() { _showProgress = false; });

    if(bookingResponse.success)
    {
      CommonWidgets.showToast(S.of(context).bookedSuccess);

      /*String receiptURL = bookingResponse.value1.trim();
      String qrCodeURL = bookingResponse.value2.trim();
      print("Receipt URL => "+ receiptURL);
      print("QR Code URL => "+ qrCodeURL);

      if(receiptURL.endsWith(".pdf"))
      {
        setState(() { _showProgress = true; });

        var pdfData = await http.get(Uri.parse(receiptURL));

        setState(() { _showProgress = false; });

        if(pdfData.statusCode==404)
        {
          CommonWidgets.showToast("Error 404, "+S.of(context).receiptNotFound);
        }
        else
        {
          await Printing.layoutPdf(onLayout: (_) => pdfData.bodyBytes);
        }
      }
      else
      {
        CommonWidgets.showToast(S.of(context).receiptNotFound);
      }

      if(qrCodeURL.endsWith(".png") || qrCodeURL.endsWith(".jpg") || qrCodeURL.endsWith(".jpeg"))
      {
        BeanLoginDetails loginDetails = await PreferenceHelper.getLoginDetails();
        String parcelId = bookingResponse.data['id'].toString();
        String receiverName = bookingResponse.data['receiver_name'].toString();
        String fromCityName = bookingResponse.data['source_location'].toString();
        String toCityName = bookingResponse.data['destination_location'].toString();
        String bookedBy = loginDetails.companyName.toString().trim();
        await Navigator.push(context, MaterialPageRoute(builder: (context)=> QRPrintingScreen(parcelId, receiverName, fromCityName, toCityName, bookedBy, qrCodeURL)));
      }*/

      String _parcelId = bookingResponse.data['id'].toString();
      await Navigator.push(context, MaterialPageRoute(builder: (context)=> ParcelDetailsScreen(_parcelId)));

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }
}