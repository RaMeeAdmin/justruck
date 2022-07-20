import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:justruck/beans/bean_designation_details.dart';
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/beans/bean_registration_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/other/validations.dart';
import 'package:justruck/registration/registration_step1.dart';
import 'package:justruck/registration/thank_you_screen.dart';
import 'package:justruck/registration/verify_otp_screen.dart';
import 'package:justruck/web_api/get_designation_list_api.dart';
import 'package:justruck/web_api/registration_api.dart';

import '../generated/l10n.dart';

class RegistrationStep2 extends StatefulWidget
{
  final BeanRegistrationDetails registrationDetails;
  const RegistrationStep2(this.registrationDetails);

  _RegistrationStep2 createState() => _RegistrationStep2();
}

class _RegistrationStep2 extends State<RegistrationStep2>
{
  TextEditingController _controllerContactName = TextEditingController();
  TextEditingController _controllerContactEmail = TextEditingController();
  TextEditingController _controllerContactMobile = TextEditingController();
  TextEditingController _controllerWhatsAppMobile = TextEditingController();
  TextEditingController _controllerIndividualAadhar = TextEditingController();
  TextEditingController _controllerPIN = TextEditingController();

  bool doesProvideHomeDelivery = false;
  bool doesProvideInsurance = false;
  String appBarTitle = "";
  bool _showProgress = false, _showInsuranceSwitch = true;
  late BuildContext mContext;

  String aadharHint = Strings.individualAadhar;

  List<BeanDesignationDetails> _listDesignations = List.empty(growable: true);
  late BeanDesignationDetails _selectedDesignation;

  @override
  void initState()
  {
    _controllerContactMobile.text = widget.registrationDetails.contactMobile;
    _controllerContactEmail.text = widget.registrationDetails.contactEmail;

    if(widget.registrationDetails.registrationFor==CommonConstants.typeTransporter)
    {
      aadharHint = Strings.individualAadhar;
      _showInsuranceSwitch = true;
    }
    else if(widget.registrationDetails.registrationFor==CommonConstants.typeTrucker)
    {
      aadharHint = Strings.individualAadhar+" *";
      _showInsuranceSwitch = false;
    }

    if(widget.registrationDetails.registrationFor==CommonConstants.typeTransporter)
    {
      appBarTitle = Strings.transporterRegistrationStep2;
    }
    else if(widget.registrationDetails.registrationFor==CommonConstants.typeTrucker)
    {
      appBarTitle = Strings.truckerRegistrationStep2;
    }

    _listDesignations = BeanDesignationDetails.getDefaultDesignation();
    _selectedDesignation = _listDesignations[0];

    _getDesignationDetailsList();
  }

  Future<bool> _onWillPop()
  {
    //Navigator.of(context).pop();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
        RegistrationStep1(widget.registrationDetails))
    );

    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context)
  {
    mContext = context;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: Text(appBarTitle)),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidgets.getH2NormalText(Strings.primaryContactDetails, Colors.black),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top:0.0),
                              child: TextFormField(
                                controller: _controllerContactName,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                maxLength: 30,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                                ],
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
                                controller: _controllerContactEmail,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                readOnly: true,
                                enabled: false,
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
                                controller: _controllerContactMobile,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                textInputAction: TextInputAction.next,
                                readOnly: true,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: Strings.primaryMobileNo+" *",
                                  counterText: "",
                                  contentPadding: Style.getTextFieldContentPadding(),
                                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top:10.0),
                              child: TextFormField(
                                controller: _controllerWhatsAppMobile,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: Strings.whatsAppMobileNo+" *",
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
                                  child: DropdownButton<BeanDesignationDetails>(
                                    value: _selectedDesignation,
                                    isExpanded: true,
                                    underline: Container(color: Colors.transparent),
                                    items: _listDesignations.map((type) =>
                                        DropdownMenuItem(
                                            child: CommonWidgets.getH3NormalText(type.designationName, Colors.black),
                                            value: type)
                                    ).toList(),
                                    onChanged: (value)
                                    {
                                      setState(() {
                                        _selectedDesignation = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.only(top:10.0),
                              child: TextFormField(
                                controller: _controllerIndividualAadhar,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                maxLength: 12,
                                decoration: InputDecoration(
                                  labelText: aadharHint,
                                  counterText: "",
                                  contentPadding: Style.getTextFieldContentPadding(),
                                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top:10.0),
                              child: TextFormField(
                                controller: _controllerPIN,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                maxLength: 4,
                                decoration: InputDecoration(
                                  labelText: Strings.setPIN+" *",
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: CommonWidgets.getH3NormalText(Strings.doYouProvideHomeDelivery, Colors.black)),
                            FlutterSwitch(
                                showOnOff: true,
                                value: doesProvideHomeDelivery,
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
                                    doesProvideHomeDelivery = val;
                                  });
                                })
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _showInsuranceSwitch,
                        child: Container(
                          margin: const EdgeInsets.only(top:10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: CommonWidgets.getH3NormalText(Strings.doYouProvideInsurance, Colors.black)),
                              FlutterSwitch(
                                  showOnOff: true,
                                  value: doesProvideInsurance,
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
                                      doesProvideInsurance = val;
                                    });
                                  })
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top:10.0),
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(Strings.submitDetails.toUpperCase()),
                          ),
                          onPressed: ()
                          {
                            if(validate())
                            {
                              _registerTransporter();
                            }
                            //_registerTransporter();
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

    if(_controllerContactName.text.trim().isEmpty) {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterContactName);
    }
    else if(_controllerContactEmail.text.trim().isEmpty) {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterEmail);
    }
    else if(! Validations.isValidEmailId(_controllerContactEmail.text.trim())) {
      valid = false;
      CommonWidgets.showToast(Strings.invalidEmailId);
    }
    else if(_controllerContactMobile.text.trim().isEmpty) {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterMobileNo);
    }
    else if(_controllerContactMobile.text.trim().isNotEmpty && _controllerContactMobile.text.trim().length < 10) {
      valid = false;
      CommonWidgets.showToast(Strings.invalidMobile);
    }
    else if(_selectedDesignation.designationId=="0") {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterDesignation);
    }
    else if(_controllerIndividualAadhar.text.trim().isNotEmpty && _controllerIndividualAadhar.text.trim().length < 12) {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterValidAadharNo);
    }
    else if(_controllerPIN.text.trim().isEmpty) {
      valid = false;
      CommonWidgets.showToast(Strings.plzSetPin);
    }
    else if(_controllerPIN.text.trim().isNotEmpty && _controllerPIN.text.trim().length != 4) {
      valid = false;
      CommonWidgets.showToast(S.of(context).pinMustBeFourDigit);
    }

    if(widget.registrationDetails.registrationFor==CommonConstants.typeTrucker &&
        _controllerIndividualAadhar.text.trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterAadharNo);
    }

    return valid;
  }

  _registerTransporter() async
  {
    widget.registrationDetails.contactName = _controllerContactName.text;
    widget.registrationDetails.contactEmail = _controllerContactEmail.text;
    widget.registrationDetails.contactMobile = _controllerContactMobile.text;
    widget.registrationDetails.whatsAppMobileNo = _controllerWhatsAppMobile.text;
    widget.registrationDetails.contactDesignation = _selectedDesignation.designationId;
    widget.registrationDetails.individualAadharNo = _controllerIndividualAadhar.text;
    widget.registrationDetails.pin = _controllerPIN.text;

    widget.registrationDetails.isHomeDeliveryProvided = doesProvideHomeDelivery ? "Y" : "N";
    widget.registrationDetails.isInsuranceProvided = doesProvideInsurance ? "Y" : "N";

    setState(() {_showProgress = true;});

    BeanResponse regResponse = await RegistrationAPI.registerTransporterOrTrucker(widget.registrationDetails);

    setState(() {_showProgress = false;});

    if(regResponse.success)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ThankYouScreen()));
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> VerifyOTPScreen(regId, widget.registrationDetails.contactMobile)));
    }
    else
    {
      _showRegSuccessPopup(mContext, regResponse.message);
    }
  }

  _showRegSuccessPopup(BuildContext context, String displayMessage)
  {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: const Text(Strings.message),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget> [
                Text(displayMessage)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Strings.okay.toUpperCase()),
              onPressed: ()
              {
                Navigator.of(context).pop();
                //_onWillPop();
              },
            )
          ],
        );
      },
    );
  }

  _getDesignationDetailsList() async
  {
    setState(()
    {
      _showProgress = true;
    });

    List<BeanDesignationDetails> _tempList = await GetDesignationListAPI.getDesignationDetailsList();

    if(_tempList.length > 0)
    {
      setState(() {
        _listDesignations.addAll(_tempList);
        _showProgress = false;
      });
    }
  }
}