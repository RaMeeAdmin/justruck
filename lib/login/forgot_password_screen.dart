import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/web_api/forgot_pin_api.dart';

class ForgotPasswordScreen extends StatefulWidget
{
  _ForgotPasswordScreen createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen>
{
  TextEditingController _controllerMobileNo = TextEditingController();

  bool _showProgress = false;

  @override
  void initState()
  {

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
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
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: CommonWidgets.getH2NormalText(S.of(context).forgotPin, skyBlue),
                          ),
                          CommonWidgets.getAppLogo(100,100),
                          Container(
                            margin: const EdgeInsets.only(top:10.0),
                            child: Container(
                              child: TextFormField(
                                controller: _controllerMobileNo,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: InputDecoration(
                                    labelText: S.of(context).mobileNumber+" *",
                                    counterText: "",
                                    contentPadding: Style.getTextFieldContentPadding(),
                                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                    suffixIcon: Icon(Icons.phone_android)
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top:10.0),
                            child: ElevatedButton(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(S.of(context).getPin.toUpperCase()),
                              ),
                              onPressed: ()
                              {
                                if(_validate())
                                {
                                  _sendUserPin();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    )
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
    );
  }

  _validate()
  {
    bool valid = true;

    if(_controllerMobileNo.text.trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterMobileNo);
    }
    else if(_controllerMobileNo.text.trim().length !=10)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).invalidMobile);
    }

    return valid;
  }

  _sendUserPin() async
  {
    setState(() { _showProgress = true; });

    BeanResponse response =  await ForgotPinAPI.getUserPin(_controllerMobileNo.text.trim());

    setState(() { _showProgress = false; });

    if(response.success)
    {
      bool? action = await CommonWidgets.showMessagePopup(context, S.of(context).message, response.message, false);
      if(action==true)
      {
        Navigator.of(context).pop(true);
      }
    }
  }
}