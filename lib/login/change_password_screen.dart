import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_login_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/web_api/change_pin_api.dart';

class ChangePasswordScreen extends StatefulWidget
{
  _ChangePasswordScreen createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen>
{
  TextEditingController _controllerOldPassword = TextEditingController();
  TextEditingController _controllerNewPassword = TextEditingController();
  TextEditingController _controllerConfirmPassword = TextEditingController();

  bool _showProgress = false;

  @override
  void initState()
  {

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
        appBar: AppBar(title: Text(S.of(context).changePin)),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          controller: _controllerOldPassword,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: S.of(context).oldPin,
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: _controllerNewPassword,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: S.of(context).newPin,
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: _controllerConfirmPassword,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: S.of(context).confirmPin,
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
                            child: Text(S.of(context).changePin.toUpperCase()),
                          ),
                          onPressed: ()
                          {
                            if(_validate())
                            {
                              _changeUserPin();
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

  _validate()
  {
    bool valid = true;

    if(_controllerOldPassword.text.trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).enterOldPin);
    }
    else if(_controllerNewPassword.text.trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).enterNewPin);
    }
    else if(_controllerConfirmPassword.text.trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).enterConfirmPin);
    }
    else if( _controllerNewPassword.text.trim() != _controllerConfirmPassword.text.trim())
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).confirmPINDoesNotMatch);
    }

    return valid;
  }


  _changeUserPin() async
  {
    setState(() { _showProgress = true; });

    BeanLoginDetails profDetails = await PreferenceHelper.getLoginDetails();

    bool pinChanged = await ChangePinAPI.changeUserPin(profDetails.logInUniqueId,
        _controllerOldPassword.text.trim(), _controllerNewPassword.text.trim(),
        _controllerConfirmPassword.text.trim()
    );

    setState(() { _showProgress = false; });

    if(pinChanged)
    {
      _onWillPop();
    }
  }
}