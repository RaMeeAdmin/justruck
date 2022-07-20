import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_city.dart';
import 'package:justruck/beans/bean_company_type.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:justruck/beans/bean_registration_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/pick_city_screen.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/other/validations.dart';
import 'package:justruck/registration/registration_step2.dart';
import 'package:justruck/web_api/get_company_types_api.dart';

class RegistrationStep1 extends StatefulWidget
{
  final BeanRegistrationDetails registrationDetails;
  const RegistrationStep1(this.registrationDetails);
  _RegistrationStep1 createState() => _RegistrationStep1();
}

class _RegistrationStep1 extends State<RegistrationStep1>
{
  TextEditingController _controllerCompanyName = TextEditingController();
  TextEditingController _controllerAddressLine1 = TextEditingController();
  TextEditingController _controllerAddressLine2 = TextEditingController();
  TextEditingController _controllerDistrictName = TextEditingController();
  TextEditingController _controllerStateName = TextEditingController();
  TextEditingController _controllerCompanyEmailId = TextEditingController();
  TextEditingController _controllerCompanyPan = TextEditingController();
  TextEditingController _controllerCompanyGstin = TextEditingController();

  List<BeanCompanyType> _listCompanyTypes = List.empty(growable: true);
  late BeanCompanyType _selectedCompanyType;

  String appBarTitle = "";
  bool _showProgress = false, _isGSTRegistered = false;
  BeanCity _selectedCompanyCity = BeanCity("0", Strings.city);

  String panHint = Strings.companyPan;
  String emailHint = Strings.companyEmailId;
  String addressLine1Hint = Strings.companyAddressLine1;
  String addressLine2Hint = Strings.companyAddressLine2;
  String gstHint = Strings.companyGstin;

  @override
  void initState()
  {
    _listCompanyTypes = BeanCompanyType.getDefaultTypes();
    _selectedCompanyType = _listCompanyTypes[0];

    _controllerCompanyName.text = widget.registrationDetails.companyName;
    _controllerAddressLine1.text = widget.registrationDetails.addressLine1;
    _controllerAddressLine2.text = widget.registrationDetails.addressLine2;
    _controllerDistrictName.text = widget.registrationDetails.districtName;
    _controllerCompanyEmailId.text = widget.registrationDetails.companyEmail;
    _controllerCompanyPan.text = widget.registrationDetails.companyPAN;
    _controllerCompanyGstin.text = widget.registrationDetails.companyGSTIN;

    if(widget.registrationDetails.registrationFor==CommonConstants.typeTransporter)
    {
      appBarTitle = Strings.transporterRegistrationStep1;
    }
    else if(widget.registrationDetails.registrationFor==CommonConstants.typeTrucker)
    {
      appBarTitle = Strings.truckerRegistrationStep1;
    }

    _makeServerCalls();
  }

  _makeServerCalls() async
  {
    _getCompanyTypes();
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
            title: Text(appBarTitle)
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top:0.0),
                        child: TextFormField(
                          controller: _controllerCompanyName,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          decoration: InputDecoration(
                            labelText: Strings.companyOrIndividualName+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        decoration: Style.getRoundedGreyBorder(),
                        margin: const EdgeInsets.only(top: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(left:5,top: 0,bottom: 0, right: 5),
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: DropdownButton<BeanCompanyType>(
                              value: _selectedCompanyType,
                              isExpanded: true,
                              underline: Container(color: Colors.transparent),
                              items: _listCompanyTypes.map((type) =>
                                  DropdownMenuItem(
                                      child: CommonWidgets.getH3NormalText(type.companyTypeName, Colors.black),
                                      value: type)
                              ).toList(),
                              onChanged: (value)
                              {
                                _selectedCompanyType = value!;

                                if(_selectedCompanyType.companyTypeId==CommonConstants.companyTypeIndividual)
                                {
                                  setState(() {
                                    panHint = Strings.pan;
                                    emailHint = Strings.emailAddress;
                                    addressLine1Hint = Strings.addressLine1;
                                    addressLine2Hint = Strings.addressLine2;
                                    gstHint = Strings.gstin;
                                  });
                                }
                                else
                                {
                                  setState(() {
                                    panHint = Strings.companyPan;
                                    emailHint = Strings.companyEmailId;
                                    addressLine1Hint = Strings.companyAddressLine1;
                                    addressLine2Hint = Strings.companyAddressLine2;
                                    gstHint = Strings.companyGstin;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerAddressLine1,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: addressLine1Hint+" *",
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
                          decoration: InputDecoration(
                            labelText: addressLine2Hint,
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      GestureDetector(
                          child: CommonWidgets.pickCityField(_selectedCompanyCity.cityName),
                          onTap: () async
                          {
                            BeanCity cityDetails = await Navigator.push(context, MaterialPageRoute(builder: (context)=> const PickCityScreen(Strings.companyCity)));
                            setState(()
                            {
                              _selectedCompanyCity = cityDetails;
                              _controllerDistrictName.text = cityDetails.districtName;
                              _controllerStateName.text = cityDetails.stateName;
                            });
                          }
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerDistrictName,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: Strings.district,
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerStateName,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: Strings.state,
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerCompanyEmailId,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          maxLength: 60,
                          decoration: InputDecoration(
                            labelText: emailHint,
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerCompanyPan,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.characters,
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: panHint+" *",
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
                            Expanded(child: CommonWidgets.getH3NormalText(Strings.isGSTRegistered, Colors.black)),
                            FlutterSwitch(
                                showOnOff: true,
                                value: _isGSTRegistered,
                                valueFontSize: 12,
                                height: 28,
                                width: 64,
                                activeText: Strings.yes,
                                inactiveText: Strings.no,
                                activeTextColor: Colors.white,
                                inactiveTextColor: Colors.white,
                                onToggle: (val)
                                {
                                  setState(() {
                                    _isGSTRegistered = val;
                                  });
                                })
                          ],
                        ),
                      ),
                      Visibility(
                          visible: _isGSTRegistered,
                          child: Container(
                            margin: const EdgeInsets.only(top:10.0),
                            child: TextFormField(
                              controller: _controllerCompanyGstin,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.characters,
                              maxLength: 15,
                              decoration: InputDecoration(
                                labelText: gstHint+" *",
                                counterText: "",
                                contentPadding: Style.getTextFieldContentPadding(),
                                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                              ),
                            ),
                          )
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top:10.0),
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(Strings.saveAndContinue.toUpperCase()),
                          ),
                          onPressed: ()
                          {
                            if(validate())
                            {
                              _jumpToRegStep2();
                            }
                            //_jumpToRegStep2();
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

  bool validate()
  {
    bool valid = true;

    if(_selectedCompanyType.companyTypeId == "0")
    {
      valid = false;
      CommonWidgets.showToast(Strings.plzSelectCompanyType);
    }
    else if(_controllerCompanyName.text.trim().isEmpty) {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterName);
    }
    else if(_controllerAddressLine1.text.trim().isEmpty) {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterAddress);
    }
    else if(_selectedCompanyCity.cityId=="0")
    {
      valid = false;
      CommonWidgets.showToast(Strings.plzSelectCity);
    }
    else if(_controllerCompanyPan.text.trim().isEmpty) {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterPAN);
    }
    else if(! Validations.isValidPanNo(_controllerCompanyPan.text.trim()))
    {
      valid = false;
      CommonWidgets.showToast(Strings.invalidPanNo);
    }
    else if(_isGSTRegistered)
    {
      if(_controllerCompanyGstin.text.trim().isEmpty)
      {
        valid = false;
        CommonWidgets.showToast(Strings.plzEnterGSTIN);
      }
      else if(! Validations.isValidGstNo(_controllerCompanyGstin.text.trim()))
      {
        valid = false;
        CommonWidgets.showToast(Strings.invalidGstNo);
      }
    }

    return valid;
  }

  _jumpToRegStep2()
  {
    widget.registrationDetails.companyType = _selectedCompanyType.companyTypeId;
    widget.registrationDetails.companyState = _selectedCompanyCity.stateCode;
    widget.registrationDetails.companyCity = _selectedCompanyCity.cityId;
    widget.registrationDetails.districtName = _selectedCompanyCity.districtName;
    widget.registrationDetails.companyEmail = _controllerCompanyEmailId.text;

    widget.registrationDetails.companyName = _controllerCompanyName.text;
    widget.registrationDetails.addressLine1 = _controllerAddressLine1.text;
    widget.registrationDetails.addressLine2 = _controllerAddressLine2.text;
    widget.registrationDetails.companyPAN = _controllerCompanyPan.text;
    widget.registrationDetails.isGSTRegistered = _isGSTRegistered ? "Y" : "N";
    widget.registrationDetails.companyGSTIN = _controllerCompanyGstin.text;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> RegistrationStep2(widget.registrationDetails)));
  }

  _getCompanyTypes() async
  {
    setState(() { _showProgress = true; });

    List<BeanCompanyType> tempList = await GetCompanyTypesAPI.getCompanyTypeList();

    setState(() { _showProgress = false; });

    if(tempList.isNotEmpty)
    {
      setState(() {
        _listCompanyTypes.addAll(tempList);
      });
    }
  }
}