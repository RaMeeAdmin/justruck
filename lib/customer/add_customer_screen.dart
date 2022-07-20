import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:justruck/beans/bean_city.dart';
import 'package:justruck/beans/bean_customer_details.dart';
import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/pick_city_screen.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/other/validations.dart';
import 'package:justruck/web_api/add_customer_details_api.dart';

class AddCustomer extends StatefulWidget
{
  _AddCustomer createState() => _AddCustomer();
}

class _AddCustomer extends State<AddCustomer>
{
  TextEditingController _controllerFirmName = TextEditingController();
  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerMiddleName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerMobileNumber = TextEditingController();
  TextEditingController _controllerEmailAddress = TextEditingController();
  TextEditingController _controllerAddressLine1 = TextEditingController();
  TextEditingController _controllerAddressLine2 = TextEditingController();
  TextEditingController _controllerLandmark = TextEditingController();

  TextEditingController _controllerPinCode = TextEditingController();

  BeanCity _selectedCity = BeanCity("0", Strings.city+" *");
  bool _showProgress = false;

  List<BeanIdValue> _listCustomerTypes = List.empty(growable: true);
  late BeanIdValue _selectedCustomerType;

  @override
  void initState()
  {
    _listCustomerTypes = BeanIdValue.getCustomerTypeList();
    _selectedCustomerType = _listCustomerTypes[0];
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
        appBar: AppBar(title: Text(S.of(context).addCustomer)),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CommonWidgets.getH3NormalText(S.of(context).customerType+" *", Colors.black),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Wrap(
                                children:_getCustomerTypeWidget(),
                              ),
                            ),
                          )
                        ],
                      ),

                      Visibility(
                        visible: _selectedCustomerType.id.toLowerCase()==CommonConstants.customerTypeFirm.toLowerCase() ? true : false,
                        child: Container(
                          margin: const EdgeInsets.only(top:10.0),
                          child: TextFormField(
                            controller: _controllerFirmName,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            maxLength: 40,
                            decoration: InputDecoration(
                              labelText: S.of(context).firmName+" *",
                              counterText: "",
                              contentPadding: Style.getTextFieldContentPadding(),
                              border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerFirstName,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                          ],
                          decoration: InputDecoration(
                            labelText: _selectedCustomerType.id.toLowerCase()==CommonConstants.customerTypeIndividual.toLowerCase()
                                ? S.of(context).firstName+" *" : S.of(context).contactPersonFirstName+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),

                      Visibility(
                        visible: _selectedCustomerType.id.toLowerCase()==CommonConstants.customerTypeIndividual.toLowerCase() ? true : false,
                        child: Container(
                          margin: const EdgeInsets.only(top:10.0),
                          child: TextFormField(
                            controller: _controllerMiddleName,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            maxLength: 30,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                            ],
                            decoration: InputDecoration(
                              labelText: S.of(context).middleName,
                              counterText: "",
                              contentPadding: Style.getTextFieldContentPadding(),
                              border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerLastName,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                          ],
                          decoration: InputDecoration(
                            labelText: _selectedCustomerType.id.toLowerCase()==CommonConstants.customerTypeIndividual.toLowerCase()
                                ? S.of(context).lastName+" *" : S.of(context).contactPersonLastName+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerMobileNumber,
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

                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerEmailAddress,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          maxLength: 60,
                          decoration: InputDecoration(
                            labelText: S.of(context).emailAddress,
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerAddressLine1,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLength: 50,
                          decoration: InputDecoration(
                            labelText: S.of(context).addressLine1+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerAddressLine2,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLength: 50,
                          decoration: InputDecoration(
                            labelText: S.of(context).addressLine2,
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerLandmark,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          decoration: InputDecoration(
                            labelText: S.of(context).nearbyLandmark,
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerPinCode,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          maxLength: 6,
                          decoration: InputDecoration(
                            labelText: S.of(context).pinCode,
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),

                      GestureDetector(
                          child: CommonWidgets.pickCityField(_selectedCity.cityName),
                          onTap: () async
                          {
                            BeanCity cityDetails = await Navigator.push(context, MaterialPageRoute(builder: (context)=> const PickCityScreen(Strings.city)));
                            setState(()
                            {
                              _selectedCity = cityDetails;
                              _controllerPinCode.text = cityDetails.pinCode;
                            });
                          }
                      ),

                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: Row(
                          children: [
                            CommonWidgets.getH3NormalText(_selectedCity.districtName, Colors.black),
                            const SizedBox(width: 3),
                            CommonWidgets.getH3NormalText(_selectedCity.stateName, Colors.black),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top:10.0),
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(S.of(context).save.toUpperCase()),
                          ),
                          onPressed: ()
                          {
                            if(_validate())
                            {
                              _submitCustomerDetails();
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

  List<Widget> _getCustomerTypeWidget()
  {
    List<Widget> _listTypeChipsWidgets = List.empty(growable: true);
    _listTypeChipsWidgets.clear();

    for (int i=0; i<_listCustomerTypes.length; i++)
    {
      _listTypeChipsWidgets.add(Padding(
          padding: const EdgeInsets.all(1.0),
          child: GestureDetector(
            child: Chip(
                backgroundColor: _listCustomerTypes[i].checked ? primaryColor : veryLightGray,
                label: CommonWidgets.getH4NormalText(_listCustomerTypes[i].value.toString().trim(),
                    _listCustomerTypes[i].checked ? Colors.white : Colors.black),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.only(left:5, right: 5)
            ),
            onTap: ()
            {
              _setSelectedType(i);
            },
          )
      ),
      );
    }

    return _listTypeChipsWidgets;
  }

  _setSelectedType(int index)
  {
    for (int i=0; i<_listCustomerTypes.length; i++)
    {
      if(i==index)
      {
        _listCustomerTypes[index].checked = true;
        _selectedCustomerType = _listCustomerTypes[index];
      }
      else
      {
        _listCustomerTypes[i].checked = false;
      }
    }

    setState(() {

    });
  }

  bool _validate()
  {
    bool _valid = true;

    if(_controllerFirstName.text.toString().trim().isEmpty)
    {
      _valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterFirstName);
    }
    else if(_controllerLastName.text.toString().trim().isEmpty)
    {
      _valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterLastName);
    }
    else if(_controllerMobileNumber.text.toString().trim().isEmpty)
    {
      _valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterMobileNo);
    }
    else if(_controllerMobileNumber.text.toString().trim().length!=10)
    {
      _valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterValidMobileNo);
    }
    else if(_controllerEmailAddress.text.toString().trim().isNotEmpty &&
        !Validations.isValidEmailId(_controllerEmailAddress.text.toString().trim()))
    {
      _valid = false;
      CommonWidgets.showToast(S.of(context).invalidEmailId);
    }
    else if(_controllerAddressLine1.text.toString().trim().isEmpty)
    {
      _valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterCurrentAddressLine1);
    }
    else if(_selectedCity.cityId=="0")
    {
      _valid = false;
      CommonWidgets.showToast(S.of(context).selectCity);
    }

    return _valid;
  }

  _submitCustomerDetails() async
  {
    String customerType = _selectedCustomerType.value;
    String firmName = _controllerFirmName.text.toString().trim();
    String firstName = _controllerFirstName.text.toString().trim();
    String middleName = _controllerMiddleName.text.toString().trim();
    String lastName = _controllerLastName.text.toString().trim();
    String mobileNumber = _controllerMobileNumber.text.toString().trim();
    String emailAddress = _controllerEmailAddress.text.toString().trim();
    String addressLine1 = _controllerAddressLine1.text.toString().trim();
    String addressLine2 = _controllerAddressLine2.text.toString().trim();
    String landmark = _controllerLandmark.text.toString().trim();
    String pinCode = _controllerPinCode.text.toString().trim();
    String districtName = _selectedCity.districtName.trim();
    String stateName = _selectedCity.stateName.trim();

    if(_selectedCustomerType.value.toString().toLowerCase()==CommonConstants.customerTypeIndividual)
    {
      firmName = "";
    }
    else if(_selectedCustomerType.value.toString().toLowerCase()==CommonConstants.customerTypeFirm)
    {
      middleName = "";
    }

    BeanCustomerDetails customerDetails = BeanCustomerDetails("0");
    customerDetails.customerType = customerType;
    customerDetails.firmName = firmName;

    customerDetails.firstName = firstName;
    customerDetails.middleName = middleName;
    customerDetails.lastName = lastName;
    customerDetails.mobileNumber = mobileNumber;
    customerDetails.emailAddress = emailAddress;
    customerDetails.addressLine1 = addressLine1;
    customerDetails.addressLine2 = addressLine2;
    customerDetails.landmark = landmark;
    customerDetails.pinCode = pinCode;

    customerDetails.cityId = _selectedCity.cityId;
    customerDetails.cityName = _selectedCity.cityName;

    customerDetails.stateCode = _selectedCity.stateCode;
    customerDetails.stateName = stateName;

    customerDetails.districtName = districtName;

    setState(() { _showProgress = true; });

    BeanCustomerDetails tempCustDetails = await AddCustomerDetailsAPI.submitCustomerDetails(customerDetails);

    setState(() { _showProgress = false; });

    if(tempCustDetails.id == "0" || tempCustDetails.id == "" || tempCustDetails.id == "NA")
    {
      //CommonWidgets.showToast("Unable to add customer details");
    }
    else
    {
      CommonWidgets.showToast("Customer details added successfully");
      Navigator.of(context).pop(tempCustDetails);
    }
  }
}