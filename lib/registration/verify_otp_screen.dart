import 'dart:async';

import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_registration_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/common_functions.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/registration/registration_step1.dart';
import 'package:justruck/registration/thank_you_screen.dart';
import 'package:justruck/web_api/resend_otp_api.dart';
import 'package:justruck/web_api/verify_otp_api.dart';

class VerifyOTPScreen extends StatefulWidget
{
  final BeanRegistrationDetails registrationDetails;
  const VerifyOTPScreen(this.registrationDetails);
  _VerifyOTPScreen createState() => _VerifyOTPScreen();
}

class _VerifyOTPScreen extends State<VerifyOTPScreen>
{
  TextEditingController _controllerDigit1 = TextEditingController();
  TextEditingController _controllerDigit2 = TextEditingController();
  TextEditingController _controllerDigit3 = TextEditingController();
  TextEditingController _controllerDigit4 = TextEditingController();

  bool _showProgress = false;

  late Timer _countDownTimer;
  int _secRemain = 30;

  @override
  void initState()
  {
    _startTimer();
  }

  Future<bool> _onWillPop() async
  {
    bool? canExit = await _confirmExitAlert();
    if(canExit!)
    {
        Navigator.of(context).pop(true);
        return Future<bool>.value(true);
    }
    else
    {
        return Future<bool>.value(false);
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.verifyOTP),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Stack(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidgets.getH3NormalText(
                          CommonFunctions.replacePatternByText("[mobile_number]", widget.registrationDetails.contactMobile,
                              Strings.enterVerificationCode), Colors.black
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(right: 5),
                                child: TextFormField(
                                  controller: _controllerDigit1,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  onChanged: (text) {
                                    if(text.length==1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                    counterText: "",
                                    contentPadding: EdgeInsets.all(1),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(left: 5, right: 5),
                                child: TextFormField(
                                  controller: _controllerDigit2,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  onChanged: (text) {
                                    if(text.length==1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                    else if(text.length==0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                    counterText: "",
                                    contentPadding: EdgeInsets.all(1),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(left: 5, right: 5),
                                child: TextFormField(
                                  controller: _controllerDigit3,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  onChanged: (text) {
                                    if(text.length==1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                    else if(text.length==0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                    counterText: "",
                                    contentPadding: EdgeInsets.all(1),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: TextFormField(
                                  controller: _controllerDigit4,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  onChanged: (text)
                                  {
                                    if(text.length==0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                    counterText: "",
                                    contentPadding: EdgeInsets.all(1),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top:20.0),
                        child: ElevatedButton(
                          child: Padding(padding: const EdgeInsets.all(15.0),
                            child: Text(Strings.confirmOTP.toUpperCase()),
                          ),
                          onPressed: ()
                          {
                            if(_validate())
                            {
                              _verifyUserOtp();
                            }
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top:20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: (_secRemain > 0 ? true : false),
                              child: CommonWidgets.getH3NormalText(_convertSecondsToMinutes(_secRemain), gray),
                            ),
                            Visibility(
                                visible: (_secRemain > 0 ? false : true),
                                child: GestureDetector(
                                  child: CommonWidgets.getH3NormalText(S.of(context).resendOTP, Colors.blue),
                                  onTap: ()
                                  {
                                    _resendUserOtp();
                                  },
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

  Future<bool?> _confirmExitAlert() async
  {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: const Text(Strings.confirmation),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(Strings.regExitMessage),
              ],
            ),
          ),
          actions: <Widget> [
            TextButton(
              child: const Text(Strings.okay),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text(Strings.exitAnyway),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  _startTimer()
  {
    const oneSec = const Duration(seconds: 1);
    _countDownTimer = Timer.periodic(oneSec, (Timer timer)
    {
      if(_secRemain==0)
      {
        timer.cancel();
      }
      else
      {
        setState(()
        {
          _secRemain --;
        });

        print("Time Remain => "+_secRemain.toString());
      }
    });
  }

  String _convertSecondsToMinutes(int timeInSeconds)
  {
    String strMin = "";
    String strSec = "";

    int min = (_secRemain ~/ 60);

    strMin = min.toString();

    if(min<10)
    {
      strMin = "0" + min.toString();
    }

    int sec = (_secRemain % 60);
    strSec = sec.toString();
    if(sec<10)
    {
      strSec = "0" + sec.toString();
    }

    return strMin+":"+strSec;
  }

  _validate()
  {
    bool valid = true;

    if( _controllerDigit1.text.toString().trim().isEmpty ||
        _controllerDigit2.text.toString().trim().isEmpty ||
        _controllerDigit3.text.toString().trim().isEmpty ||
        _controllerDigit4.text.toString().trim().isEmpty )
    {
      valid = false;
      CommonWidgets.showToast(Strings.enterCompleteOTP);
    }

    return valid;
  }

  _verifyUserOtp() async
  {
    String otp = _controllerDigit1.text.toString() + _controllerDigit2.text.toString() +
        _controllerDigit3.text.toString() + _controllerDigit4.text.toString();

    setState(() {
      _showProgress = true;
    });

    bool verified = await VerifyOtpAPI.verifyUserOtp(widget.registrationDetails.contactMobile, otp);

    setState(() {
      _showProgress = false;
    });

    if(verified)
    {
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ThankYouScreen()));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> RegistrationStep1(widget.registrationDetails)));
    }
  }

  _resendUserOtp() async
  {
    setState(() {
      _showProgress = true;
    });

    bool resend = await ResendOtpAPI.resendUserOtp(widget.registrationDetails.contactMobile);

    if(resend)
    {
      setState(() {
        _secRemain = 30;
        _showProgress = false;
      });

      _startTimer();
    }
    else
    {
      setState(() {
        _showProgress = false;
      });
    }
  }

  @override
  void dispose()
  {
    print("Disposing");
    _countDownTimer.cancel();
    super.dispose();
  }

}