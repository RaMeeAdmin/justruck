import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_registration_details.dart';
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/home/bottom_navigation_screen.dart';
import 'package:justruck/login/forgot_password_screen.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/registration/registration_step0.dart';
import 'package:justruck/registration/registration_step1.dart';
import 'package:justruck/registration/thank_you_screen.dart';
import 'package:justruck/registration/verify_otp_screen.dart';
import 'package:justruck/web_api/login_api.dart';

class LoginScreen extends StatefulWidget
{
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen>
{
  TextEditingController _controllerMobileNo = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  bool _passwordVisible = false, _showProgress = false;

  @override
  void initState()
  {

  }

  Future<bool> _onWillPop() async
  {
    return await showDialog(context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: Text(S.of(context).confirmation),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(S.of(context).wantToExitApp)
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(S.of(context).no),
                onPressed: ()
                {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(S.of(context).yesExit),
                onPressed: ()
                {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Image.asset('assets/backgrounds/loginBg.png', fit: BoxFit.cover)
                )
              ],
            ),
            Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top : 20),
                            child: Text(
                                Strings.login.toUpperCase(),
                                style: Style.boldTextStyle(size: 30, letterSpacing: 5.0, textColor: skyBlue)
                            ),
                          ),
                          CommonWidgets.getAppLogo(100,100),
                          Container(
                            margin: const EdgeInsets.only(top:10.0),
                            child: Container(
                              margin: const EdgeInsets.only(left: 10.0, right: 10, top: 5, bottom: 5),
                              child: TextFormField(
                                controller: _controllerMobileNo,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                maxLength: 10,
                                decoration: InputDecoration(
                                    labelText: S.of(context).mobileNumber+" *",
                                    counterText: "",
                                    contentPadding: Style.getTextFieldContentPadding(),
                                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                    suffixIcon: const Icon(Icons.phone_android)
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 10, top: 5, bottom: 5),
                            child: TextFormField(
                              controller: _controllerPassword,
                              obscureText: !_passwordVisible,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              maxLength: 4,
                              decoration: InputDecoration(
                                  labelText: S.of(context).pin+" *",
                                  counterText: "",
                                  contentPadding: Style.getTextFieldContentPadding(),
                                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                  suffixIcon: IconButton(icon: Icon(_passwordVisible ? Icons.visibility: Icons.visibility_off),
                                    onPressed: ()
                                    {
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      setState(()
                                      {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },)
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(S.of(context).login.toUpperCase()),
                                ),
                                onPressed: ()
                                {
                                  if(_validate())
                                  {
                                    _performLogin();
                                  }
                                }
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: GestureDetector(
                                child: CommonWidgets.getH2NormalText(S.of(context).forgotPin, skyBlue),
                                onTap: ()  {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));
                                }
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
                            child: Column(
                              children: [
                                CommonWidgets.getH3NormalText(S.of(context).dontHaveAccount, Colors.black),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: GestureDetector(
                                          child: CommonWidgets.getH3NormalText(S.of(context).registerAsTransporter, skyBlue, textAlign: TextAlign.center),
                                          onTap: () {
                                            _jumpToRegistration(CommonConstants.typeTransporter);
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 10,
                                            width: 1,
                                            color: gray,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(top: 2, bottom: 2),
                                            child: CommonWidgets.getH5NormalText(S.of(context).or, Colors.black, textAlign: TextAlign.center),
                                          ),
                                          Container(
                                            height: 10,
                                            width: 1,
                                            color: gray,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: GestureDetector(
                                          child: CommonWidgets.getH3NormalText(S.of(context).registerAsTrucker, skyBlue, textAlign: TextAlign.center),
                                          onTap: () {
                                            _jumpToRegistration(CommonConstants.typeTrucker);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
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
    );
  }

  bool _validate()
  {
    bool valid = true;
    if(_controllerMobileNo.text.trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterMobileNo);
    }
    else if(_controllerPassword.text.trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterPin);
    }
    else if(_controllerMobileNo.text.trim().length < 10)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).invalidMobile);
    }

    return valid;
  }

  _performLogin() async
  {
    setState(() { _showProgress = true; });

    String _userName = _controllerMobileNo.text.trim();

    BeanResponse loginResponse = await LoginAPI.performLogin(_userName , _controllerPassword.text);

    setState(() { _showProgress = false; });

    if(loginResponse.success)
    {
      String isOTPVerified = loginResponse.data['isVerified'];
      String loginUniqueId = loginResponse.data['id'];
      String regMobile = loginResponse.data['username'];
      String userType = loginResponse.data['user_type'];

      String isApproved = loginResponse.data['isActive'] ?? "N";

      if(isApproved.toUpperCase()=='Y')
      {
        if(userType==CommonConstants.typeTrucker)
        {
          await PreferenceHelper.setLoggedInAs(CommonConstants.typeTrucker, loginUniqueId);
        }
        else if(userType==CommonConstants.typeTransporter)
        {
          await PreferenceHelper.setLoggedInAs(CommonConstants.typeTransporter, loginUniqueId);
        }
        else if(userType==CommonConstants.typeDriver)
        {
          await PreferenceHelper.setLoggedInAs(CommonConstants.typeDriver, loginUniqueId);
        }

        await PreferenceHelper.setIsLoggedIn(true);

        _openHomeScreen();
      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ThankYouScreen()));
      }
    }
    else
    {
      //_openHomeScreen();
    }
  }

  _openHomeScreen() async
  {
    _controllerMobileNo.text = "";
    _controllerPassword.text = "";

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNavigationScreen()));
  }

  _jumpToRegistration(String registrationFor)
  {
    BeanRegistrationDetails registrationDetails = BeanRegistrationDetails();
    registrationDetails.registrationFor = registrationFor;
    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistrationStep0(registrationDetails)));
  }
}