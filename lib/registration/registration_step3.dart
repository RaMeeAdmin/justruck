import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/beans/bean_subscription_type.dart';
import 'package:justruck/beans/bean_registration_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/registration/thank_you_screen.dart';
import 'package:justruck/web_api/get_subscription_types_api.dart';
import 'package:justruck/web_api/registration_api.dart';

class RegistrationStep3 extends StatefulWidget
{
  final BeanRegistrationDetails registrationDetails;
  const RegistrationStep3(this.registrationDetails);

  _RegistrationStep3 createState() => _RegistrationStep3();
}

class _RegistrationStep3 extends State<RegistrationStep3>
{
  TextEditingController _controllerBankName = TextEditingController();
  TextEditingController _controllerBranchName = TextEditingController();
  TextEditingController _controllerAccountNo = TextEditingController();
  TextEditingController _controllerIfscCode = TextEditingController();

  List<BeanSubscriptionType> _listSubscriptionTypes = List.empty(growable: true);
  late BeanSubscriptionType _selectedSubscriptionType;

  bool _showProgress = false;

  late BuildContext mContext;

  @override
  void initState()
  {
    _listSubscriptionTypes = BeanSubscriptionType.getDefaultTypes();
    _selectedSubscriptionType = _listSubscriptionTypes[0];

    _getSubscriptionTypes();
  }

  Future<bool> _onWillPop()
  {
    Navigator.of(context).pop();
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context)
  {
    mContext = context;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: const Text(Strings.transporterRegistrationStep3)),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidgets.getH2NormalText(Strings.bankingDetails, Colors.black),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerBankName,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: Strings.bankName+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerBranchName,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: Strings.branchName+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerAccountNo,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: Strings.accountNumber+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerIfscCode,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: Strings.ifsCode+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:20.0),
                        child: CommonWidgets.getH2NormalText(Strings.subscriptionDetails, Colors.black),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidgets.getH3NormalText(Strings.subscriptionType+" *", Colors.black),
                            Container(
                              decoration: Style.getRoundedGreyBorder(),
                              margin: const EdgeInsets.only(top: 2),
                              child: Padding(
                                padding: const EdgeInsets.only(left:5,top: 0,bottom: 0, right: 5),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 5, right: 5),
                                  child: DropdownButton<BeanSubscriptionType>(
                                    value: _selectedSubscriptionType,
                                    isExpanded: true,
                                    underline: Container(color: Colors.transparent),
                                    items: _listSubscriptionTypes.map((type) =>
                                        DropdownMenuItem(
                                            child: CommonWidgets.getH3NormalText(type.subscriptionTypeName, Colors.black),
                                            value: type)
                                    ).toList(),
                                    onChanged: (value)
                                    {
                                      setState(()
                                      {
                                        _selectedSubscriptionType = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
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
                          },
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

  bool validate()
  {
    bool valid = true;

    if(_controllerBankName.text.trim().isEmpty) {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterBankName);
    }
    else if(_controllerBranchName.text.trim().isEmpty) {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterBranchName);
    }
    else if(_controllerAccountNo.text.trim().isEmpty) {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterAccountNo);
    }
    else if(_controllerIfscCode.text.trim().isEmpty) {
      valid = false;
      CommonWidgets.showToast(Strings.plzEnterIFSCCode);
    }

    return valid;
  }

  _registerTransporter() async
  {
    widget.registrationDetails.subscriptionTypeId = _selectedSubscriptionType.subscriptionTypeId;

    widget.registrationDetails.bankName = _controllerBankName.text;
    widget.registrationDetails.branchName = _controllerBranchName.text;
    widget.registrationDetails.bankAccountNo = _controllerAccountNo.text;
    widget.registrationDetails.bankIfscCode = _controllerIfscCode.text;

    setState(() {_showProgress = true;});

    BeanResponse regResponse  = await RegistrationAPI.registerTransporterOrTrucker(widget.registrationDetails);

    setState(() {_showProgress = false;});

    if(regResponse.success)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ThankYouScreen()));
    }
    else
    {
      _showRegSuccessPopup(mContext, Strings.regFailedMessage);
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
              children: <Widget>[
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
                _onWillPop();
              },
            )
          ],
        );
      },
    );
  }

  _getSubscriptionTypes() async
  {
    setState(() { _showProgress = true; });

    List<BeanSubscriptionType> tempList = await GetSubscriptionTypesAPI.getSubscriptionTypeList();

    setState(() { _showProgress = false; });

    if(tempList.isNotEmpty)
    {
      setState(() {
        _listSubscriptionTypes.addAll(tempList);
      });
    }

  }
}