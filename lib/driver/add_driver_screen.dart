import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:justruck/beans/bean_city.dart';
import 'package:justruck/beans/bean_date_time.dart';
import 'package:justruck/beans/bean_driver_details.dart';
import 'package:justruck/beans/bean_license_type.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/pick_city_screen.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:justruck/web_api/add_driver_api.dart';
import 'package:justruck/web_api/get_license_types_api.dart';

class AddDriverScreen extends StatefulWidget
{
  _AddDriverScreen createState() => _AddDriverScreen();
}

class _AddDriverScreen extends State<AddDriverScreen>
{
  TextEditingController _controllerDriverName = TextEditingController();
  TextEditingController _controllerDriverMobile = TextEditingController();

  TextEditingController _controllerCurrentAddressLine1 = TextEditingController();
  TextEditingController _controllerCurrentAddressLine2 = TextEditingController();
  TextEditingController _controllerCurrentDistrictName = TextEditingController();
  TextEditingController _controllerCurrentStateName = TextEditingController();

  TextEditingController _controllerPermanentAddressLine1 = TextEditingController();
  TextEditingController _controllerPermanentAddressLine2 = TextEditingController();
  TextEditingController _controllerPermanentDistrictName = TextEditingController();
  TextEditingController _controllerPermanentStateName = TextEditingController();

  TextEditingController _controllerAadharNo = TextEditingController();
  TextEditingController _controllerLicesneNo = TextEditingController();

  List<BeanLicenseType> _listLicenseTypes = List.empty(growable: true);
  late BeanLicenseType _selectedLicenseType;

  BeanCity _selectedCurrentCity = BeanCity("0", Strings.currentCity+" *");
  BeanCity _selectedPermanentCity = BeanCity("0", Strings.permanentCity);

  BeanDateTime licenseExpiryDate = BeanDateTime.getBlankDate();
  bool sameAsCurrent = false, _showProgress = false;

  final ImagePicker _picker = ImagePicker();
  XFile? aadharImage, licenseImage, driverImage;

  @override
  void initState()
  {
    _listLicenseTypes = BeanLicenseType.getDefaultTypes();
    _selectedLicenseType = _listLicenseTypes[0];

    _getLicenseTypes();
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
        appBar: AppBar(title: Text(S.of(context).addDriver)),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerDriverName,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                          ],
                          decoration: InputDecoration(
                            labelText: S.of(context).driverName+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerDriverMobile,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: S.of(context).driverMobileNumber+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerCurrentAddressLine1,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: S.of(context).currentAddressLine1+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerCurrentAddressLine2,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: S.of(context).currentAddressLine2,
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),

                      GestureDetector(
                          child: CommonWidgets.pickCityField(_selectedCurrentCity.cityName),
                          onTap: () async
                          {
                            BeanCity cityDetails = await Navigator.push(context, MaterialPageRoute(builder: (context)=> PickCityScreen(S.of(context).currentCity)));
                            setState(()
                            {
                              _selectedCurrentCity = cityDetails;
                              _controllerCurrentDistrictName.text = cityDetails.districtName;
                              _controllerCurrentStateName.text = cityDetails.stateName;
                            });
                          }
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                                  controller: _controllerCurrentDistrictName,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).district,
                                    counterText: "",
                                    contentPadding: Style.getTextFieldContentPadding(),
                                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                  ),
                                )
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: TextFormField(
                                  controller: _controllerCurrentStateName,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).state,
                                    counterText: "",
                                    contentPadding: Style.getTextFieldContentPadding(),
                                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _controllerPermanentAddressLine1,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: S.of(context).permanentAddressLine1,
                                  counterText: "",
                                  contentPadding: Style.getTextFieldContentPadding(),
                                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                ),
                              ),
                            ),
                            Checkbox(
                                value: sameAsCurrent,
                                checkColor: Colors.white,
                                activeColor: logo3,
                                onChanged: (checkStatus)
                                {
                                  setState(()
                                  {
                                    sameAsCurrent = checkStatus!;
                                    if(checkStatus==true)
                                    {
                                      _assignCurrentAddressToPermanentAddress();
                                    }
                                  });
                                }
                            ),
                            CommonWidgets.getH4NormalText(S.of(context).sameAsCurrent, Colors.black)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerPermanentAddressLine2,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          enabled: !sameAsCurrent,
                          decoration: InputDecoration(
                            labelText: S.of(context).permanentAddressLine2,
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      GestureDetector(
                          child: CommonWidgets.pickCityField(_selectedPermanentCity.cityName),
                          onTap: () async
                          {
                            BeanCity cityDetails = await Navigator.push(context, MaterialPageRoute(builder: (context)=> PickCityScreen(S.of(context).currentCity)));
                            setState(()
                            {
                              _selectedPermanentCity = cityDetails;
                              _controllerPermanentDistrictName.text = cityDetails.districtName;
                              _controllerPermanentStateName.text = cityDetails.stateName;
                            });
                          }
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                                  controller: _controllerPermanentDistrictName,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).district,
                                    counterText: "",
                                    contentPadding: Style.getTextFieldContentPadding(),
                                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                  ),
                                )
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: TextFormField(
                                  controller: _controllerPermanentStateName,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).state,
                                    counterText: "",
                                    contentPadding: Style.getTextFieldContentPadding(),
                                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerAadharNo,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          maxLength: 12,
                          decoration: InputDecoration(
                            labelText: S.of(context).aadharNumber+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerLicesneNo,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: S.of(context).drivingLicenseNumber+" *",
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
                            child: DropdownButton<BeanLicenseType>(
                              value: _selectedLicenseType,
                              isExpanded: true,
                              underline: Container(color: Colors.transparent),
                              items: _listLicenseTypes.map((type) =>
                                  DropdownMenuItem(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CommonWidgets.getH3NormalText(type.typeName, Colors.black),
                                          SizedBox(width: 5),
                                          Expanded(child: CommonWidgets.getH4NormalText(type.displayName, gray, maxLines: 1)),
                                        ],
                                      ),
                                      value: type)
                              ).toList(),
                              onChanged: (value)
                              {
                                setState(()
                                {
                                  _selectedLicenseType = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidgets.getH3NormalText(S.of(context).licenseExpiryDate, Colors.black),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget> [
                                  Text(S.of(context).date+" *"),
                                  Container(child: Text(licenseExpiryDate.readableDate, style: TextStyle(fontSize: 14))),
                                  IconButton(
                                      icon: Icon(Icons.date_range, color: primaryColor),
                                      onPressed: () async
                                      {
                                        BeanDateTime? beanDateTime = await CommonWidgets.showDatePickerDialog(
                                            context, DateTime.now(), DateTime(2100));
                                        if(beanDateTime!=null)
                                        {
                                          setState(() {
                                            licenseExpiryDate = beanDateTime;
                                          });
                                        }
                                      }
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidgets.getH3NormalText(S.of(context).driverAadharImage, Colors.black),
                            GestureDetector(
                              child: Container(
                                decoration: Style.getRoundedGreyBorder(),
                                margin: const EdgeInsets.only(top: 2),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:5,top: 0,bottom: 0, right: 5),
                                  child: aadharImage!=null ? Container(
                                    width: double.infinity,
                                    height: 120,
                                    margin: const EdgeInsets.only(left: 5, right: 5),
                                    child: Image.file(File(aadharImage!.path),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ) : CommonWidgets.getJTLogoContainer(),
                                ),
                              ),
                              onTap: () async
                              {
                                XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                setState(() {
                                  aadharImage = image;
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
                            CommonWidgets.getH3NormalText(S.of(context).driverLicenseImage, Colors.black),
                            GestureDetector(
                              child: Container(
                                decoration: Style.getRoundedGreyBorder(),
                                margin: const EdgeInsets.only(top: 2),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:5,top: 0,bottom: 0, right: 5),
                                  child: licenseImage!=null ? Container(
                                    width: double.infinity,
                                    height: 120,
                                    margin: const EdgeInsets.only(left: 5, right: 5),
                                    child: Image.file(File(licenseImage!.path),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ) : CommonWidgets.getJTLogoContainer(),
                                ),
                              ),
                              onTap: () async
                              {
                                XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                setState(() {
                                  licenseImage = image;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidgets.getH3NormalText(S.of(context).driverImage, Colors.black),
                            GestureDetector(
                              child: Container(
                                decoration: Style.getRoundedGreyBorder(),
                                margin: const EdgeInsets.only(top: 2),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:5,top: 0,bottom: 0, right: 5),
                                  child: driverImage!=null ? Container(
                                    width: double.infinity,
                                    height: 120,
                                    margin: const EdgeInsets.only(left: 5, right: 5),
                                    child: Image.file(File(driverImage!.path),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ) : CommonWidgets.getJTLogoContainer(),
                                ),
                              ),
                              onTap: () async
                              {
                                XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                setState(() {
                                  driverImage = image;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top:10.0),
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(S.of(context).addDriver.toUpperCase()),
                          ),
                          onPressed: ()
                          {
                            if(_validate())
                            {
                              _submitDriverDetails();
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

  _assignCurrentAddressToPermanentAddress()
  {
    setState(() {
      _controllerPermanentAddressLine1.text = _controllerCurrentAddressLine1.text;
      _controllerPermanentAddressLine2.text = _controllerCurrentAddressLine2.text;
      _selectedPermanentCity = _selectedCurrentCity;
      _controllerPermanentDistrictName.text = _selectedPermanentCity.districtName;
      _controllerPermanentStateName.text = _selectedPermanentCity.stateName;
    });
  }

  bool _validate()
  {
    bool valid = true;

    if(_controllerDriverName.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterDriverName);
    }
    else if(_controllerDriverMobile.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterDriverMob);
    }
    else if(_controllerDriverMobile.text.toString().trim().length < 10)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).invalidMobile);
    }
    else if(_controllerCurrentAddressLine1.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterCurrentAddressLine1);
    }
    else if(_selectedCurrentCity.cityId=="0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectCurrentCity);
    }
    else if(_controllerAadharNo.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterDriverAadhar);
    }
    else if(_controllerAadharNo.text.toString().trim().isNotEmpty &&
            _controllerAadharNo.text.toString().trim().length !=12 )
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterValidAadharNo);
    }
    else if(_controllerLicesneNo.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterDriverLicenseNo);
    }
    else if(_selectedLicenseType.typeId=="0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectLicenseType);
    }
    else if(licenseExpiryDate.readableDate.trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterLicenseExpDate);
    }

    return valid;
  }

  _getLicenseTypes() async
  {
    setState(() { _showProgress = true; });

    List<BeanLicenseType> tempList = await GetLicenseTypesAPI.retrieveLicenseTypesList();
    if(tempList.isNotEmpty)
    {
      setState(()
      {
        _listLicenseTypes.addAll(tempList);
      });
    }

    setState(() { _showProgress = false; });
  }

  _submitDriverDetails() async
  {
    BeanDriverDetails beanDriverDetails = BeanDriverDetails("",
        _controllerDriverName.text.toString().trim(),
        _controllerDriverMobile.text.toString().trim(),
        _controllerCurrentAddressLine1.text.toString().trim(),
        "", "");

    beanDriverDetails.currentAddressLine2 = _controllerCurrentAddressLine2.text.toString().trim();
    beanDriverDetails.currentCityId = _selectedCurrentCity.cityId;
    beanDriverDetails.currentDistrict = _selectedCurrentCity.districtName;
    beanDriverDetails.currentState = _selectedCurrentCity.stateCode;

    beanDriverDetails.permanentAddressLine1 = _controllerPermanentAddressLine1.text.toString().trim();
    beanDriverDetails.permanentAddressLine2 = _controllerPermanentAddressLine2.text.toString().trim();
    beanDriverDetails.permanentCityId = _selectedPermanentCity.cityId;
    beanDriverDetails.permanentDistrict = _selectedPermanentCity.districtName;
    beanDriverDetails.permanentState = _selectedPermanentCity.stateCode;

    beanDriverDetails.aadharNo = _controllerAadharNo.text.toString().trim();
    beanDriverDetails.drivingLicenseNo = _controllerLicesneNo.text.toString().trim();
    beanDriverDetails.licesneType = _selectedLicenseType.typeId;
    beanDriverDetails.licesneExpiryDate = licenseExpiryDate.date;

    beanDriverDetails.driverImage = driverImage!=null ? driverImage!.path : "";
    beanDriverDetails.aadharImaage = aadharImage!=null ? aadharImage!.path : "";
    beanDriverDetails.driverLicenseImageUrl = licenseImage!=null ? licenseImage!.path : "";

    setState(() { _showProgress = true; });

    bool driverAdded = await AddDriverAPI.submitDriverDetails(beanDriverDetails);

    setState(() { _showProgress = false; });

    if(driverAdded)
    {
      Navigator.of(context).pop(true);
    }
  }
}