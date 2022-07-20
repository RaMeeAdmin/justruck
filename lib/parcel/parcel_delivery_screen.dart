import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_delivery_details.dart';
import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/beans/bean_location_details.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_payment_mode.dart';
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/location_helper.dart';
import 'package:justruck/other/permission_helper.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:justruck/web_api/parcel_delivery_api.dart';
import 'package:justruck/web_api/update_parcel_pay_details_api.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';

class ParcelDeliveryScreen extends StatefulWidget
{
  final BeanParcelDetails parcelDetails;
  const ParcelDeliveryScreen(this.parcelDetails);
  _ParcelDeliveryScreen createState() => _ParcelDeliveryScreen();
}

class _ParcelDeliveryScreen extends State<ParcelDeliveryScreen>
{
  TextEditingController _controllerReceiverName = TextEditingController();
  TextEditingController _controllerReceiverMobile = TextEditingController();

  XFile? podImage;
  XFile? receiverImage;

  final ImagePicker _picker = ImagePicker();
  BeanLocationDetails beanLocationDetails = BeanLocationDetails("0.0", "0.0", "");

  bool _showProgress = false;

  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.blue,
    exportBackgroundColor: Colors.white
  );

  @override
  void initState()
  {
    _checkLocationPermission();
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
        appBar: AppBar(title: Text(S.of(context).parcelDelivery)),
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
                          CommonWidgets.getH3NormalText(S.of(context).parcelNumber+" - ", Colors.black),
                          CommonWidgets.getH3NormalText(widget.parcelDetails.parcelId, Colors.black)
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidgets.getH3NormalText(S.of(context).proofOfDelivery, Colors.black),
                            GestureDetector(
                              child: Container(
                                decoration: Style.getRoundedGreyBorder(),
                                margin: const EdgeInsets.only(top: 2),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:5,top: 0,bottom: 0, right: 5),
                                  child: podImage!=null ? Container(
                                    width: double.infinity,
                                    height: 120,
                                    margin: const EdgeInsets.only(left: 5, right: 5),
                                    child: Image.file(File(podImage!.path),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ): Container(
                                    width: double.infinity,
                                    height: 120,
                                    margin: const EdgeInsets.only(left: 5, right: 5),
                                    child: Image.asset('assets/logo/jtlogo.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () async
                              {
                                XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                setState(() {
                                  podImage = image;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonWidgets.getH3NormalText(S.of(context).receiverSignature+" *", Colors.black),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      children: [
                                        GestureDetector(
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Icon(Icons.undo),
                                          ),
                                          onTap: ()
                                          {
                                            _signatureController.undo();
                                          },
                                        ),
                                        const SizedBox(width: 3),
                                        GestureDetector(
                                          child:Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Icon(Icons.redo),
                                          ),
                                          onTap: ()
                                          {
                                            _signatureController.redo();
                                          },
                                        ),
                                        const SizedBox(width: 3),
                                        GestureDetector(
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Icon(Icons.clear),
                                          ),
                                          onTap: ()
                                          {
                                            _signatureController.clear();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              padding: const EdgeInsets.only(left:5,top: 0,bottom: 0, right: 5),
                              decoration: Style.getRoundedGreyBorder(),
                              child: Signature(
                                controller: _signatureController,
                                width: double.infinity,
                                height: 140,
                                backgroundColor: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidgets.getH3NormalText(S.of(context).receiverPhoto, Colors.black),
                            GestureDetector(
                              child: Container(
                                decoration: Style.getRoundedGreyBorder(),
                                margin: const EdgeInsets.only(top: 2),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:5,top: 0,bottom: 0, right: 5),
                                  child: receiverImage!=null ? Container(
                                    width: double.infinity,
                                    height: 120,
                                    margin: const EdgeInsets.only(left: 5, right: 5),
                                    child: Image.file(File(receiverImage!.path),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ): Container(
                                    width: double.infinity,
                                    height: 120,
                                    margin: const EdgeInsets.only(left: 5, right: 5),
                                    child: Image.asset('assets/logo/jtlogo.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () async
                              {
                                XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                setState(() {
                                  receiverImage = image;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerReceiverName,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
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
                          maxLength: 10,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: S.of(context).mobileNumber,
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
                            child: Text(S.of(context).markDelivered.toUpperCase()),
                          ),
                          style: ElevatedButton.styleFrom(primary: darkGreen),
                          onPressed: ()
                          {
                            if(_validate())
                            {
                              _askForConfirmation();
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

  Future<String> _saveSignature(Uint8List? pngBytes) async
  {
    String singFilePath = "";
    if(Platform.isAndroid)
    {
      Directory? dir = await getExternalStorageDirectory();
      String filePath = dir!.path+"/"+"tempSign.png";
      print("File Path => "+filePath);

      File signFile = File(filePath);
      signFile = await signFile.writeAsBytes(pngBytes!);
      singFilePath = signFile.path;

      print("Sign File Path => "+singFilePath);
    }
    else if(Platform.isIOS)
    {
      Directory? dir = await getApplicationDocumentsDirectory();
      String filePath = dir.path+"/"+"tempSign.png";
      print("File Path => "+filePath);

      File signFile = File(filePath);
      signFile = await signFile.writeAsBytes(pngBytes!);
      singFilePath = signFile.path;

      print("Sign File Path => "+singFilePath);
    }

    return singFilePath;
  }

  _validate()
  {
    bool valid = true;

    if(_signatureController.isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzAddSignature);
    }
    else if(_controllerReceiverName.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterName);
    }

    return valid;
  }

  _askForConfirmation() async
  {
    bool? confirmation = await CommonWidgets.showMessagePopup(context, S.of(context).confirmation,
        S.of(context).deliveryConfirmationMessage, true,
      positiveButtonText: S.of(context).yes,
      negativeButtonText: S.of(context).no);
    if(confirmation==true)
    {
      if(widget.parcelDetails.parcelBookingType.toLowerCase() == CommonConstants.payStatusPaid.toLowerCase() ||
         widget.parcelDetails.parcelBookingType.trim().isEmpty)
      {
        _submitDeliveryDetails();
      }
      else if(widget.parcelDetails.parcelBookingType.toLowerCase() == CommonConstants.payStatusToPay.toLowerCase())
      {
        CommonWidgets commonWidgets = CommonWidgets();
        List<BeanPaymentMode>? _paymentModes = await commonWidgets.showPaymentModesPopup(context, widget.parcelDetails);

        List<BeanIdValue> listPaymentDetails = List.empty(growable: true);

        for (int i=0; i<_paymentModes!.length; i++)
        {
          if(_paymentModes[i].selected)
          {
            listPaymentDetails.add(BeanIdValue(_paymentModes[i].modeId, _paymentModes[i].controllerAmountTendered.text));
          }
        }

        widget.parcelDetails.listPaymentDetails = listPaymentDetails;

        setState(() {
          _showProgress = true;
        });

        BeanResponse _updateResponse = await UpdateParcelPayDetailsAPI.updateParcelPaymentDetails(widget.parcelDetails, Strings.paidAtDelivery);

        setState(() {
          _showProgress = false;
        });

        if(_updateResponse.success)
        {
          CommonWidgets.showToast(_updateResponse.message);
          _submitDeliveryDetails();
        }
      }
    }
  }

  _checkLocationPermission() async
  {
    bool granted = await PermissionHelper.checkLocationPermission();
    if(!granted)
    {
      await PermissionHelper.requestLocationPermission();
    }
    else
    {
      beanLocationDetails = await LocationHelper.getDeviceLocation();
    }
  }

  _submitDeliveryDetails() async
  {
    Uint8List? bytes = await _signatureController.toPngBytes();
    String signFilePath = await _saveSignature(bytes);

    String _receiverName = _controllerReceiverName.text.toString().trim();
    String _receiverMobile = _controllerReceiverMobile.text.toString().trim();

    BeanDeliveryDetails beanDeliveryDetails = BeanDeliveryDetails(widget.parcelDetails.parcelId, _receiverName);
    beanDeliveryDetails.podImage = podImage!=null ? podImage!.path : "";
    beanDeliveryDetails.receiverImage = receiverImage!=null ? receiverImage!.path : "";
    beanDeliveryDetails.signatureImage = signFilePath;

    beanDeliveryDetails.latitude = beanLocationDetails.latitude;
    beanDeliveryDetails.longitude = beanLocationDetails.longitude;
    beanDeliveryDetails.address = beanLocationDetails.address;

    beanDeliveryDetails.receiverMobileNo = _receiverMobile;
    beanDeliveryDetails.trackStatus = CommonConstants.statusDelivered;

    setState(() { _showProgress = true; });

    bool delivered = await ParcelDeliveryAPI.submitParcelDeliveryDetails(beanDeliveryDetails);

    setState(() { _showProgress = false; });

    if(delivered)
    {
      Navigator.of(context).pop(true);
    }
  }

  @override
  void dispose()
  {
    _signatureController.dispose();
    super.dispose();
  }
}