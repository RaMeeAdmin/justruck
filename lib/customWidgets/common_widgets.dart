import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:justruck/beans/bean_date_time.dart';
import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_payment_mode.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/common_functions.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';

class CommonWidgets
{
  static Widget getAppLogo(double width, double height)
  {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset('assets/logo/jtlogo.png',
        fit: BoxFit.scaleDown,
      ),
    );
  }

  static Widget getFlutterIcon(double width, double height)
  {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset('assets/icons/ic_flutter.png',
        fit: BoxFit.scaleDown,
      ),
    );
  }

  static showToast(String message)
  {
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_SHORT,
        msg: message,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: darkBlue,
        fontSize: 14);
  }

  static Widget notFoundPlaceHolder()
  {
    return Container(
      height: 80,
      width: 80,
      padding: const EdgeInsets.only(top:20),
      child: Image.asset('assets/images/image_unavailable.png',
        fit: BoxFit.scaleDown,
      ),
    );
  }

  static Visibility getNoDetailsFoundWidget(bool visibility, String text)
  {
    return Visibility(
      visible: visibility,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            color: primaryColor,
            size: 34,
          ),
          Align(
              alignment: Alignment.center,
              child: Text(text,
                  textAlign: TextAlign.center,
                  style: Style.dashboardTextStyle()))
        ],
      ),
    );
  }

  static Widget getH1NormalText(String text, Color color)
  {
    return Text(text, style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.normal,
        color: color)
    );
  }

  static Widget getH2NormalText(String text, Color color,
  {
    fontWeight : FontWeight.normal,
  })
  {
    return Text(text, style: TextStyle(
        fontSize: 18,
        fontWeight: fontWeight,
        color: color)
    );
  }

  static Widget getH3NormalText(String text, Color color,
  {
    TextAlign textAlign = TextAlign.left,
  })
  {
    return Text(text,
        textAlign: textAlign,
        style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: color)
    );
  }

  static Widget getH4NormalText(String text, Color color,
  {
    TextAlign textAlign = TextAlign.left,
    int maxLines = 5
  })
  {
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: color,)
    );
  }

  static Widget getH5NormalText(String text, Color color,
  {
    TextAlign textAlign = TextAlign.left,
    int maxLines = 5
  })
  {
    return Text(text, textAlign: textAlign, style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: color)
    );
  }

  static Container getContactDetailsWidget()
  {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top:0.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: Strings.contactName+" *",
                counterText: "",
                contentPadding: Style.getTextFieldContentPadding(),
                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top:10.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: Strings.contactEmail+" *",
                counterText: "",
                contentPadding: Style.getTextFieldContentPadding(),
                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top:10.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: Strings.mobileNumber+" *",
                counterText: "",
                contentPadding: Style.getTextFieldContentPadding(),
                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top:10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: Strings.contactDesignation+" *",
                counterText: "",
                contentPadding: Style.getTextFieldContentPadding(),
                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top:10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: Strings.individualAadhar+" *",
                counterText: "",
                contentPadding: Style.getTextFieldContentPadding(),
                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top:10.0),
            child: Row(
              children: [
                CommonWidgets.getH2NormalText(Strings.isPrimaryContact, Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Container pickCityField(String fieldName)
  {
    return Container(
      decoration: Style.getRoundedGreyBorder(),
      margin: const EdgeInsets.only(top:10.0),
      child: Padding(
        padding: const EdgeInsets.only(left:10, top: 5, bottom: 5, right: 5),
        child: Row(
          children: [
            Expanded(child: CommonWidgets.getH3NormalText(fieldName, Colors.black)),
            const Icon(Icons.arrow_right, color: Colors.grey, size: 32,)
          ],
        ),
      ),
    );
  }

  static Container getJTLogoContainer()
  {
    return  Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Image.asset('assets/logo/jtlogo.png',
        fit: BoxFit.scaleDown,
      ),
    );
  }

  static Container getSettingsNavigationContainer(IconData icon, String label, String value)
  {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
      child: Row(
        children:
        [
          Icon(icon, color: gray, size: 18),
          const SizedBox(width: 5),
          Expanded(
              flex: 12,
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black)
              )
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 8,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(value,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey)
              ),
            ),
          ),
          const SizedBox(width: 3),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 12),
        ],
      ),
    );
  }

  static Container getDividerLine()
  {
    return Container(
      height: 0.5,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
      color: lightGray,
    );
  }

  static Future<BeanDateTime?> showDatePickerDialog(BuildContext context, DateTime initialDate, DateTime lastDate) async
  {
    BeanDateTime dateTimeBean;

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime.now().subtract(const Duration(days: 36500)),
        lastDate: lastDate
    );

    if(pickedDate==null)
    {
      return null;
    }
    else
    {
      dateTimeBean = CommonFunctions.getFormattedDateTime(pickedDate);
      return dateTimeBean;
    }
  }

  static Future<bool?> showMessagePopup(BuildContext context, String title, String message, bool showNegativeActionButton,
      {
        String positiveButtonText = Strings.okay,
        String negativeButtonText = Strings.cancel,
      }) async
  {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget> [
                Text(message),
              ],
            ),
          ),
          actions: <Widget>
          [
            Visibility(
              visible: showNegativeActionButton,
              child: TextButton(
                child: Text(negativeButtonText),
                onPressed: ()
                {
                  Navigator.of(context).pop(false);
                },
              ),
            ),
            TextButton(
              child: Text(positiveButtonText),
              onPressed: ()
              {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<BeanIdValue?> showIdValueListPopup(BuildContext context, List<BeanIdValue> _listIdValues, String title,
  {
    String notFoundMessage = "No details available",
  }
  ) async
  {
    return await showDialog<BeanIdValue>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context)
      {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          titlePadding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
          title: Text(title),
          content: _listIdValues.isEmpty
              ? CommonWidgets.getH4NormalText(notFoundMessage, Colors.grey)
              : ListView.separated(
            shrinkWrap: true,
            itemCount: _listIdValues.length,
            itemBuilder: (context, index)
            {
              return Container(
                margin: const EdgeInsets.only(left: 2.0, right: 2.0, top: 1.0, bottom: 2.0),
                child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children:
                        [
                          CommonWidgets.getH3NormalText(_listIdValues[index].value, Colors.black),
                          CommonWidgets.getH3NormalText(_listIdValues[index].id, Colors.grey),
                        ],
                      ),
                    ),
                    onTap: () {
                      return Navigator.of(context).pop(_listIdValues[index]);
                    }
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index)
            {
              return Container(
                width: double.infinity,
                height: 0.5,
                margin: const EdgeInsets.only(left: 15, right: 15),
                color: lightGray,
              );
            },
          ),
        );
      }
    );
  }



  Future<List<BeanPaymentMode>?> showPaymentModesPopup(BuildContext context, BeanParcelDetails parcelDetails) async
  {
    List<BeanPaymentMode> _paymentModes = List.empty(growable: true);
    _paymentModes = BeanPaymentMode.getAvailablePaymentModes();
    double _changeReturn = double.parse(parcelDetails.totalAmount);

    return await showDialog<List<BeanPaymentMode>>(
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
                                              double _temp = calculateBalance(parcelDetails.totalAmount, _paymentModes);
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
                                      double tendered = calculateTotalTendered(_paymentModes);
                                      double remaining = payableAmount - tendered ;
                                      _paymentModes[i].controllerAmountTendered.text = remaining.toStringAsFixed(2);
                                    }

                                    _changeReturn = calculateBalance(parcelDetails.totalAmount, _paymentModes);

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
                              double balance = calculateBalance(parcelDetails.totalAmount, _paymentModes);
                              if(balance != 0)
                              {
                                CommonWidgets.showToast(
                                    CommonFunctions.replacePatternByText("[balance amount]", balance.toString(),
                                        S.of(context).pendingBalanceMessage)
                                );
                              }
                              else
                              {
                                Navigator.of(context).pop(_paymentModes);
                                //_submitParcelDetails();
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

  double calculateBalance(String strAmountPayable, List<BeanPaymentMode> _paymentModes)
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

    //_balanceAmount = amountTendered - payableAmount;
    _balanceAmount = payableAmount - amountTendered;

    return double.parse(_balanceAmount.toStringAsFixed(2));
  }

  double calculateTotalTendered(List<BeanPaymentMode> _paymentModes)
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
}