import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_city.dart';
import 'package:justruck/beans/bean_customer_details.dart';
import 'package:justruck/beans/bean_item_type.dart';
import 'package:justruck/beans/bean_login_details.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_parcel_item_details.dart';
import 'package:justruck/beans/bean_registration_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/customWidgets/widget_material_info.dart';
import 'package:justruck/customer/add_customer_screen.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/pick_city_screen.dart';
import 'package:justruck/other/pick_transporter_screen.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/parcel/review_parcel_screen.dart';
import 'package:justruck/web_api/get_parcel_item_types_api.dart';
import 'package:justruck/web_api/search_cust_details_api.dart';
import 'package:flutter_switch/flutter_switch.dart';

class BookParcelScreen extends StatefulWidget
{
  _BookParcelScreen createState() => _BookParcelScreen();
}

class _BookParcelScreen extends State<BookParcelScreen>
{
  TextEditingController _controllerSenderSearch = TextEditingController();
  TextEditingController _controllerSenderName = TextEditingController();
  TextEditingController _controllerSenderMobile = TextEditingController();
  TextEditingController _controllerSenderAddress = TextEditingController();

  TextEditingController _controllerReceiverSearch = TextEditingController();
  TextEditingController _controllerReceiverName = TextEditingController();
  TextEditingController _controllerReceiverMobile = TextEditingController();
  TextEditingController _controllerReceiverAddress = TextEditingController();

  int _index = 0;

  BeanCity _selectedSenderCity = BeanCity("0", Strings.selectCity);
  BeanCity _selectedReceiverCity = BeanCity("0", Strings.selectCity);

  List<WidgetMaterialInfo> listWidgetMaterialInfo = List.empty(growable: true);
  List<BeanItemType> listItemTypes = List.empty(growable: true);

  bool _showSenderDetailsForm = false, _showReceiverDetailsForm = false;
  bool _showProgress = false, _deliveredToHome = false;

  BeanCustomerDetails _senderCustDetails = BeanCustomerDetails("0");
  BeanCustomerDetails _receiverCustDetails = BeanCustomerDetails("0");

  BeanRegistrationDetails _selectedTransporterDetails = BeanRegistrationDetails();
  late BeanLoginDetails _loginDetails;

  @override
  void initState()
  {
    listItemTypes = BeanItemType.getDefaultItemList();
    _selectedTransporterDetails = BeanRegistrationDetails.getDefaultDetails();
    _getParcelItemTypes();
    _getLoginPreferences();
  }

  _getLoginPreferences() async
  {
    _loginDetails = await PreferenceHelper.getLoginDetails();
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
        appBar: AppBar(title: Text(S.of(context).parcelBooking)),
        body: SafeArea(
          child: Stack(
            children: [
              Stepper(
                  currentStep: _index,
                  onStepCancel: ()
                  {
                    if (_index > 0) {
                      setState(() {
                        _index -= 1;
                      });
                    }
                  },
                  onStepContinue: ()
                  {
                    print("continue clicked at index "+_index.toString());
                    if (_index <= 1) {
                      setState(() {
                        _index += 1;
                      });
                    }
                    else
                    {
                      if(_validate())
                      {
                        _openReviewParcelBookingForm();
                      }
                    }
                  },
                  onStepTapped: (int index)
                  {
                    setState(() {
                      _index = index;
                    });
                  },
                  steps: <Step>
                  [
                    Step(
                      title: Row(
                        children: [
                          Expanded(
                            child: CommonWidgets.getH3NormalText(S.of(context).senderDetails, Colors.black),
                          ),
                          GestureDetector(
                              child: Column(
                                children: [
                                  const Icon(Icons.person_add, color: logo3),
                                  CommonWidgets.getH4NormalText(S.of(context).addNewCustomer, Colors.black38)
                                ],
                              ),
                              onTap: ()
                              {
                                _openAddCustomerForm(true);
                              }
                          )
                        ],
                      ),
                      content: Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top:10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        child: TextFormField(
                                          controller: _controllerSenderSearch,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          maxLength: 30,
                                          decoration: InputDecoration(
                                            labelText: S.of(context).searchByNameMobile+" *",
                                            counterText: "",
                                            contentPadding: Style.getTextFieldContentPadding(),
                                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                          ),
                                        ),
                                      )
                                  ),
                                  Container(
                                    decoration: Style.getIconButtonStyle(),
                                    child: IconButton(
                                      icon: const Icon(Icons.search, color: Colors.white,),
                                      onPressed :()
                                      {
                                        _searchCustomerByPattern(true);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                  visible: _showSenderDetailsForm,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top:10.0),
                                        child: TextFormField(
                                          controller: _controllerSenderName,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          maxLength: 30,
                                          decoration: InputDecoration(
                                            labelText: S.of(context).senderName+" *",
                                            counterText: "",
                                            contentPadding: Style.getTextFieldContentPadding(),
                                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top:10.0),
                                        child: TextFormField(
                                          controller: _controllerSenderMobile,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          maxLength: 10,
                                          decoration: InputDecoration(
                                            labelText: S.of(context).mobileNumber+" *",
                                            counterText: "",
                                            contentPadding: Style.getTextFieldContentPadding(),
                                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                          child: CommonWidgets.pickCityField(_selectedSenderCity.cityName),
                                          onTap: () async
                                          {
                                            BeanCity cityDetails = await Navigator.push(context, MaterialPageRoute(builder: (context)=> PickCityScreen(S.of(context).senderCity)));
                                            setState(() {
                                              _selectedSenderCity = cityDetails;
                                            });
                                          }
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top:10.0),
                                        child: TextFormField(
                                          controller: _controllerSenderAddress,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            labelText: S.of(context).address+" *",
                                            counterText: "",
                                            contentPadding: Style.getTextFieldContentPadding(),
                                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          )
                      ),
                    ),
                    Step(
                        title: Row(
                          children: [
                            Expanded(
                              child: CommonWidgets.getH3NormalText(S.of(context).receiverDetails, Colors.black),
                            ),
                            GestureDetector(
                                child: Column(
                                  children: [
                                    const Icon(Icons.person_add, color: logo3),
                                    CommonWidgets.getH4NormalText(S.of(context).addNewCustomer, Colors.black38)
                                  ],
                                ),
                                onTap: ()
                                {
                                  _openAddCustomerForm(false);
                                }
                            )
                          ],
                        ),
                        content: Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top:10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(right: 10),
                                          child: TextFormField(
                                            controller: _controllerReceiverSearch,
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.next,
                                            maxLength: 30,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).searchByNameMobile+" *",
                                              counterText: "",
                                              contentPadding: Style.getTextFieldContentPadding(),
                                              border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                            ),
                                          ),
                                        )
                                    ),
                                    Container(
                                      decoration: Style.getIconButtonStyle(),
                                      child: IconButton(
                                        icon: const Icon(Icons.search, color: Colors.white,),
                                        onPressed :()
                                        {
                                          _searchCustomerByPattern(false);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                    visible: _showReceiverDetailsForm,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top:10.0),
                                          child: TextFormField(
                                            controller: _controllerReceiverName,
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.next,
                                            maxLength: 30,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).receiverName+" *",
                                              counterText: "",
                                              contentPadding: Style.getTextFieldContentPadding(),
                                              border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top:10.0),
                                          child: TextFormField(
                                            controller: _controllerReceiverMobile,
                                            keyboardType: TextInputType.number,
                                            textInputAction: TextInputAction.next,
                                            maxLength: 10,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).mobileNumber+" *",
                                              counterText: "",
                                              contentPadding: Style.getTextFieldContentPadding(),
                                              border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                            child: CommonWidgets.pickCityField(_selectedReceiverCity.cityName),
                                            onTap: () async
                                            {
                                              BeanCity cityDetails = await Navigator.push(context, MaterialPageRoute(builder: (context)=> PickCityScreen(S.of(context).receiverCity)));
                                              setState(() {
                                                _selectedReceiverCity = cityDetails;
                                                _selectedTransporterDetails = BeanRegistrationDetails.getDefaultDetails();
                                              });
                                            }
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top:10.0),
                                          child: TextFormField(
                                            controller: _controllerReceiverAddress,
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.next,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).address+" *",
                                              counterText: "",
                                              contentPadding: Style.getTextFieldContentPadding(),
                                              border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(top:10.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(child: CommonWidgets.getH3NormalText(S.of(context).doorStepDeliveryRequired, Colors.black)),
                                                FlutterSwitch(
                                                    showOnOff: true,
                                                    value: _deliveredToHome,
                                                    valueFontSize: 12,
                                                    height: 28,
                                                    width: 64,
                                                    activeText: S.of(context).yes,
                                                    inactiveText: S.of(context).no,
                                                    activeTextColor: Colors.white,
                                                    inactiveTextColor: Colors.white,
                                                    onToggle: (val)
                                                    {
                                                      setState(() {
                                                        _deliveredToHome = val;
                                                      });
                                                    })
                                              ],
                                            )
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top:10.0),
                                          child: Column(
                                            children: [
                                              CommonWidgets.getH3NormalText(S.of(context).pickReceiverTransporter, Colors.black)
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            child: Container(
                                              decoration: Style.getRoundedGreyBorder(),
                                              margin: const EdgeInsets.only(top:2.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left:5, top: 5, bottom: 5, right: 5),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            CommonWidgets.getH3NormalText(_selectedTransporterDetails.companyName, Colors.black),
                                                            (_deliveredToHome &&  (_selectedTransporterDetails.transporterOrTruckerId!="0"
                                                                && _selectedTransporterDetails.isHomeDeliveryProvided=="N")) ?
                                                            CommonWidgets.getH5NormalText(S.of(context).doorStepDeliveryUnavailable, Colors.red) : const SizedBox(width: 1),
                                                          ],
                                                        )
                                                    ),
                                                    const Icon(Icons.arrow_right, color: Colors.grey, size: 32)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap: () async
                                            {
                                              if(_selectedReceiverCity.cityId=="0")
                                              {
                                                CommonWidgets.showToast(S.of(context).plzSelectReceiverCity);
                                              }
                                              else
                                              {
                                                String strCityId = _selectedReceiverCity.cityId;
                                                String isHomeDeliveryProvided = _deliveredToHome ? "Y" : "N";

                                                BeanRegistrationDetails tempDetails = await Navigator.push(context,
                                                    MaterialPageRoute(builder: (context)=> PickTransporterScreen(S.of(context).pickReceiverTransporter,
                                                        strCityId, isHomeDeliveryProvided)));
                                                setState(()
                                                {
                                                  _selectedTransporterDetails = tempDetails;
                                                });
                                              }
                                            }
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            )
                        )
                    ),
                    Step(
                        title: CommonWidgets.getH3NormalText(S.of(context).materialInformation, Colors.black),
                        content: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: _buildParcelItemList(),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: ElevatedButton.icon(
                                        icon: const Icon(Icons.add, size: 16),
                                        label: CommonWidgets.getH4NormalText(S.of(context).addAnother, Colors.white),
                                        style: ElevatedButton.styleFrom(primary: logo3),
                                        onPressed: ()
                                        {
                                          _addNewParcelItem();
                                        }
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                  ]
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

  _buildParcelItemList()
  {
    var _parcelItemsList = ListView.builder(
        shrinkWrap: true,
        itemCount: listWidgetMaterialInfo.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index)
        {
          return Card(
            margin: const EdgeInsets.only(left: 1.0, right: 1.0, top: 5.0, bottom: 5.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: Style.getRoundedGreyBorder(),
                          child: Padding(
                            padding: const EdgeInsets.only(left:0,top: 0,bottom: 0, right: 0),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: DropdownButton<BeanItemType>(
                                value: listWidgetMaterialInfo[index].selectedItem,
                                isExpanded: true,
                                underline: Container(color: Colors.transparent),
                                items: listItemTypes.map((type) =>
                                    DropdownMenuItem(
                                        child: CommonWidgets.getH4NormalText(type.typeName, Colors.black),
                                        value: type)
                                ).toList(),
                                onChanged: (value)
                                {
                                  setState(()
                                  {
                                    listWidgetMaterialInfo[index].selectedItem = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_sharp, color: Colors.grey,),
                        onPressed :() => _removeParcelItem(index),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top:10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: listWidgetMaterialInfo[index].controllerDescription,
                      maxLength: 30,
                      decoration: InputDecoration(
                        labelText: S.of(context).description+" *",
                        counterText: "",
                        contentPadding: Style.getTextFieldContentPadding(),
                        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top:10.0),
                    child: TextFormField(
                      controller: listWidgetMaterialInfo[index].controllerDeclaredValue,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      maxLength: 10,
                      decoration: InputDecoration(
                        labelText: S.of(context).declaredValue+" *",
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
                        Expanded(
                          child: TextFormField(
                            controller: listWidgetMaterialInfo[index].controllerWeight,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            maxLength: 10,
                            decoration: InputDecoration(
                              labelText: S.of(context).weight+" *",
                              counterText: "",
                              contentPadding: Style.getTextFieldContentPadding(),
                              border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: TextFormField(
                            controller: listWidgetMaterialInfo[index].controllerQuantity,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            maxLength: 5,
                            decoration: InputDecoration(
                              labelText: S.of(context).quantity+" *",
                              counterText: "",
                              contentPadding: Style.getTextFieldContentPadding(),
                              border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top:10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: listWidgetMaterialInfo[index].controllerLength,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                maxLength: 10,
                                onChanged: (String value)
                                {
                                  String vol = _calculateVolume(index);
                                  setState(() {
                                    listWidgetMaterialInfo[index].volume = vol;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: S.of(context).length,
                                  counterText: "",
                                  contentPadding: Style.getTextFieldContentPadding(),
                                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                controller: listWidgetMaterialInfo[index].controllerBreadth,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                maxLength: 10,
                                onChanged: (String value)
                                {
                                  String vol = _calculateVolume(index);
                                  setState(() {
                                    listWidgetMaterialInfo[index].volume = vol;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: S.of(context).breadth,
                                  counterText: "",
                                  contentPadding: Style.getTextFieldContentPadding(),
                                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                controller: listWidgetMaterialInfo[index].controllerHeight,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                maxLength: 10,
                                onChanged: (String value)
                                {
                                  String vol = _calculateVolume(index);
                                  setState(() {
                                    listWidgetMaterialInfo[index].volume = vol;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: S.of(context).height,
                                  counterText: "",
                                  contentPadding: Style.getTextFieldContentPadding(),
                                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            CommonWidgets.getH3NormalText(S.of(context).volume+" - ", Colors.black),
                            CommonWidgets.getH3NormalText(listWidgetMaterialInfo[index].volume, Colors.black)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top:10.0),
                    child: TextFormField(
                      controller: listWidgetMaterialInfo[index].controllerAmount,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      maxLength: 10,
                      decoration: InputDecoration(
                        labelText: S.of(context).amount+" *",
                        counterText: "",
                        contentPadding: Style.getTextFieldContentPadding(),
                        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
    return _parcelItemsList;
  }

  _buildCustomerDetailsList(List<BeanCustomerDetails> tempList, bool isSender)
  {
    var _driverDetailsList = ListView.separated(
        shrinkWrap: true,
        itemCount: tempList.length,
        itemBuilder: (context, index)
        {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                children: <Widget>
                [
                  CommonWidgets.getH3NormalText(tempList[index].firstName+" "+tempList[index].lastName, Colors.black),
                  CommonWidgets.getH3NormalText(tempList[index].mobileNumber, Colors.grey),
                ],
              ),
            ),
            onTap: ()
            {
              Navigator.of(context).pop();
              if(isSender)
              {
                _senderCustDetails = tempList[index];
                _setSenderDetailsValues();
              }
              else
              {
                _receiverCustDetails = tempList[index];
                _setReceiverDetailsValues();
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index)
        {
          return Container(height: 0.5, color: lightGray);
        }

    );
    return _driverDetailsList;
  }

  Future<void> _showCustomerDetailsPopup(List<BeanCustomerDetails> tempList, bool isSender) async
  {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text(tempList.length.toString()+" "+S.of(context).resultsFound),
          content: Container(
            width: 300,
            child: _buildCustomerDetailsList(tempList, isSender),
          ),
          actions: <Widget> [
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).searchAgain),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _addNewParcelItem()
  {
    setState(()
    {
      WidgetMaterialInfo info = WidgetMaterialInfo();
      info.selectedItem = listItemTypes[0];
      listWidgetMaterialInfo.add(info);
    });
  }

  _removeParcelItem(int index)
  {
    if(listWidgetMaterialInfo.length > 1)
    {
      setState(() {
        listWidgetMaterialInfo.removeAt(index);
      });
    }
    else
    {
      CommonWidgets.showToast(S.of(context).mustHaveAtLeastOneItem);
    }
  }

  _setSenderDetailsValues()
  {
    setState(() {
      _showSenderDetailsForm = true;
      _controllerSenderName.text = _senderCustDetails.firstName+" "+_senderCustDetails.lastName;
      _controllerSenderMobile.text = _senderCustDetails.mobileNumber;
      _controllerSenderAddress.text = _senderCustDetails.addressLine1+" "+_senderCustDetails.addressLine2;
    });
  }

  _setReceiverDetailsValues()
  {
    setState(() {
      _showReceiverDetailsForm = true;
      _controllerReceiverName.text = _receiverCustDetails.firstName+" "+_receiverCustDetails.lastName;
      _controllerReceiverMobile.text = _receiverCustDetails.mobileNumber;
      _controllerReceiverAddress.text = _receiverCustDetails.addressLine1+" "+_receiverCustDetails.addressLine2;
    });
  }

  String _calculateVolume(int index)
  {
    double volume = 0;

    String strLen = listWidgetMaterialInfo[index].controllerLength.text.trim();
    String strBreadth = listWidgetMaterialInfo[index].controllerBreadth.text.trim();
    String strHeigth = listWidgetMaterialInfo[index].controllerHeight.text.trim();

    double l = double.parse(strLen.isEmpty ? "0" : strLen).toDouble();
    double b = double.parse(strBreadth.isEmpty ? "0" : strBreadth).toDouble();
    double h = double.parse(strHeigth.isEmpty ? "0" : strHeigth).toDouble();

    volume = l * b * h;

    return volume.toStringAsFixed(3);
  }

  _openAddCustomerForm(bool isSender) async
  {
    BeanCustomerDetails custDetails = await Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCustomer()));
    if(isSender)
    {
      _senderCustDetails = custDetails;
      _setSenderDetailsValues();
    }
    else
    {
      _receiverCustDetails = custDetails;
      _setReceiverDetailsValues();
    }
  }

  _openReviewParcelBookingForm()
  {
    BeanParcelDetails parcelDetails = BeanParcelDetails.empty();

    parcelDetails.senderName = _controllerSenderName.text.toString().trim();
    parcelDetails.senderMobile = _controllerSenderMobile.text.toString().trim();
    parcelDetails.senderAddress = _controllerSenderAddress.text.toString().trim();
    parcelDetails.senderCityId = _selectedSenderCity.cityId;
    parcelDetails.senderCityName = _selectedSenderCity.cityName;

    parcelDetails.receiverName = _controllerReceiverName.text.toString().trim();
    parcelDetails.receiverMobile = _controllerReceiverMobile.text.toString().trim();
    parcelDetails.receiverAddress = _controllerReceiverAddress.text.toString().trim();
    parcelDetails.receiverCityId = _selectedReceiverCity.cityId;
    parcelDetails.receiverCityName = _selectedReceiverCity.cityName;

    List<BeanParcelItemDetails> listParcelItems = List.empty(growable: true);
    double totalWeight = 0.0, totalDeclaredValue = 0.0, parcelCharges = 0.0;
    double totalVolume = 0;

    for(int i=0; i < listWidgetMaterialInfo.length; i++)
    {
      String itemType = listWidgetMaterialInfo[i].selectedItem.typeId;
      String description = listWidgetMaterialInfo[i].controllerDescription.text.toString().trim();
      String weight = listWidgetMaterialInfo[i].controllerWeight.text.toString().trim();
      String declaredValue = listWidgetMaterialInfo[i].controllerDeclaredValue.text.toString().trim();
      String quantity = listWidgetMaterialInfo[i].controllerQuantity.text.toString().trim();
      String strLen =  listWidgetMaterialInfo[i].controllerLength.text.toString().trim();
      String strBreadth =  listWidgetMaterialInfo[i].controllerBreadth.text.toString().trim();
      String strHeight =  listWidgetMaterialInfo[i].controllerHeight.text.toString().trim();
      String volume = listWidgetMaterialInfo[i].volume;
      String amount = listWidgetMaterialInfo[i].controllerAmount.text.toString().trim();


      //totalWeight = totalWeight + (int.parse(weight));
      totalWeight = totalWeight + double.parse(weight.isEmpty ? "0.0" : weight).toDouble();

      totalVolume = totalVolume + (double.parse(volume));
      totalDeclaredValue = totalDeclaredValue + (double.parse(declaredValue));

      //parcelCharges = parcelCharges + (int.parse(amount));
      parcelCharges = parcelCharges + double.parse(amount.isEmpty ? "0.0" : amount).toDouble();

      listParcelItems.add(BeanParcelItemDetails(itemType,
          description, weight, declaredValue, quantity, volume,
          strLen, strBreadth, strHeight, amount)
      );
    }

    int insuranceCharges = 0;
    double cgstCharges = 0, sgstCharges = 0;

    //calculate gst amount if applicable
    if(_loginDetails.isGSTRegistered.trim().toUpperCase()=="Y")
    {
      cgstCharges = (parcelCharges * CommonConstants.cgstPercentage) / 100;
      sgstCharges = (parcelCharges * CommonConstants.sgstPercentage) / 100;
    }

    parcelDetails.totalWeight = totalWeight.toStringAsFixed(2);
    parcelDetails.totalVolume = totalVolume.toStringAsFixed(2);
    parcelDetails.totalDeclaredValue = totalDeclaredValue.toStringAsFixed(2);
    parcelDetails.parcelCharges = parcelCharges.toStringAsFixed(2);
    parcelDetails.insuranceCharges = insuranceCharges.toString();
    parcelDetails.cgstCharges = cgstCharges.toStringAsFixed(2);
    parcelDetails.sgstCharges = sgstCharges.toStringAsFixed(2);
    parcelDetails.totalGSTCharges = (cgstCharges + sgstCharges).toString();
    parcelDetails.totalAmount = (parcelCharges + insuranceCharges + cgstCharges+ sgstCharges).toStringAsFixed(2);
    parcelDetails.listParcelItems = listParcelItems;

    parcelDetails.homeDeliveryRequired = _deliveredToHome ? "Y" : "N";
    parcelDetails.receivingTransporterId = _selectedTransporterDetails.transporterOrTruckerId;

    Navigator.push(context, MaterialPageRoute(builder: (context)=> ReviewParcelScreen(parcelDetails)));
  }

  _validate()
  {
    bool valid = true;

    if(_controllerSenderName.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzAddSenderName);
    }
    else if(_controllerSenderMobile.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzAddSenderMobile);
    }
    else if(_selectedSenderCity.cityId == "0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectSenderCity);
    }
    else if(_controllerSenderAddress.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzAddSenderAddress);
    }


    else if(_controllerReceiverName.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzAddReceiverName);
    }
    else if(_controllerReceiverMobile.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzAddReceiverMobile);
    }
    else if(_selectedReceiverCity.cityId == "0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectReceiverCity);
    }
    else if(_controllerReceiverAddress.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzAddReceiverAddress);
    }

    else
    {
      for (int i=0; i<listWidgetMaterialInfo.length; i++)
      {
        if(listWidgetMaterialInfo[i].selectedItem.typeId=="0")
        {
          valid = false;
          CommonWidgets.showToast(S.of(context).plzSelectParcelItemType);
          break;
        }
        else if(listWidgetMaterialInfo[i].controllerDescription.text.toString().trim().isEmpty)
        {
          valid = false;
          CommonWidgets.showToast(S.of(context).plzEnterParcelDescription);
          break;
        }
        else if(listWidgetMaterialInfo[i].controllerDeclaredValue.text.toString().trim().isEmpty)
        {
          valid = false;
          CommonWidgets.showToast(S.of(context).plzEnterDeclaredValue);
          break;
        }
        else if(listWidgetMaterialInfo[i].controllerWeight.text.toString().trim().isEmpty)
        {
          valid = false;
          CommonWidgets.showToast(S.of(context).plzEnterWeight);
          break;
        }
        else if(listWidgetMaterialInfo[i].controllerQuantity.text.toString().trim().isEmpty)
        {
          valid = false;
          CommonWidgets.showToast(S.of(context).plzEnterQuantity);
          break;
        }
        else if(listWidgetMaterialInfo[i].controllerAmount.text.toString().trim().isEmpty)
        {
          valid = false;
          CommonWidgets.showToast(S.of(context).plzEnterAmount);
          break;
        }
      }
    }

    return valid;
  }

  _searchCustomerByPattern(bool isSender) async
  {
    List<BeanCustomerDetails> tempList = List.empty(growable: true);
    setState(() { _showProgress = true; });
    if(isSender)
    {
      tempList = await SearchCustomerDetailsAPI.searchForCustomer(_controllerSenderSearch.text);
    }
    else
    {
      tempList = await SearchCustomerDetailsAPI.searchForCustomer(_controllerReceiverSearch.text);
    }

    setState(() { _showProgress = false; });

    if(tempList.isNotEmpty)
    {
      _showCustomerDetailsPopup(tempList, isSender);
    }
    else
    {
      CommonWidgets.showToast("Found "+tempList.length.toString());
    }
  }

  _getParcelItemTypes() async
  {
    setState(() { _showProgress = true; });
    List<BeanItemType> tempList = await GetParcelItemTypesAPI.getParcelItemTypes();
    setState(() { _showProgress = false; });
    if(tempList.isNotEmpty)
    {
      listItemTypes.addAll(tempList);
    }

    _addNewParcelItem();
  }
}