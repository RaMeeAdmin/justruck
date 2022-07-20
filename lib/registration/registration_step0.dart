import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_registration_details.dart';
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justruck/other/validations.dart';
import 'package:justruck/registration/verify_otp_screen.dart';
import 'package:justruck/web_api/send_otp_api.dart';

class RegistrationStep0 extends StatefulWidget
{
  final BeanRegistrationDetails registrationDetails;
  const RegistrationStep0(this.registrationDetails);
  _RegistrationStep0 createState() => _RegistrationStep0();
}

class _RegistrationStep0 extends State<RegistrationStep0>
{

  TextEditingController _controllerContactEmail = TextEditingController();
  TextEditingController _controllerContactMobile = TextEditingController();

  String appBarTitle = "";
  bool _showProgress = false;

  @override
  void initState()
  {
    if(widget.registrationDetails.registrationFor==CommonConstants.typeTransporter)
    {
      appBarTitle = Strings.transporterRegistration;
    }
    else if(widget.registrationDetails.registrationFor==CommonConstants.typeTrucker)
    {
      appBarTitle = Strings.truckerRegistration;
    }
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
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: Image.asset('assets/backgrounds/loginBg.png', fit: BoxFit.cover)
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: ()
                      {
                        _onWillPop();
                      }
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidgets.getH2NormalText(S.of(context).helloThere+",", Colors.black),
                            Text(S.of(context).welcome,
                                style: GoogleFonts.permanentMarker(fontSize: 25, letterSpacing: 2.0, color: logo3)
                            ),
                            Container(
                              margin: const EdgeInsets.only(top:25.0),
                              child: Center(
                                child: Text(
                                    appBarTitle,
                                    style: Style.boldTextStyle(size: 18, letterSpacing: 0.0, wordSpacing:0.0, textColor: Colors.black)
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top:15.0),
                              child: TextFormField(
                                controller: _controllerContactMobile,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
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
                                controller: _controllerContactEmail,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: Strings.emailAddress+" *",
                                  counterText: "",
                                  contentPadding: Style.getTextFieldContentPadding(),
                                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top:10.0),
                              child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(Strings.proceed.toUpperCase()),
                                ),
                                onPressed: ()
                                {
                                  if(_validate())
                                  {
                                    _sentOTP();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
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

  bool _validate()
  {
    bool valid = true;

    if(_controllerContactMobile.text.trim().isEmpty) {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterMobileNo);
    }
    else if(_controllerContactMobile.text.trim().isNotEmpty && _controllerContactMobile.text.trim().length < 10) {
      valid = false;
      CommonWidgets.showToast(Strings.invalidMobile);
    }
    else if(_controllerContactEmail.text.trim().isEmpty) {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterEmail);
    }
    else if(! Validations.isValidEmailId(_controllerContactEmail.text.trim())) {
      valid = false;
      CommonWidgets.showToast(Strings.invalidEmailId);
    }

    return valid;
  }

  _sentOTP() async
  {
    String mobileNo = _controllerContactMobile.text.toString().trim();
    String emailId = _controllerContactEmail.text.toString().trim();

    setState(() {
      _showProgress = true;
    });

    BeanResponse response = await SendOtpAPI.sendUserOtp(mobileNo, emailId);

    setState(() {
      _showProgress = false;
    });

    if(response.success)
    {
      _jumpToOTPScreen();
    }
    else
    {
      CommonWidgets.showMessagePopup(context, S.of(context).message, response.message, false);
    }

  }

  _jumpToOTPScreen()
  {
    widget.registrationDetails.contactEmail = _controllerContactEmail.text;
    widget.registrationDetails.contactMobile = _controllerContactMobile.text;

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> VerifyOTPScreen(widget.registrationDetails)));
  }
}