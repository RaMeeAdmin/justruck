import 'dart:io';

import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_body_types.dart';
import 'package:justruck/beans/bean_date_time.dart';
import 'package:justruck/beans/bean_driver_details.dart';
import 'package:justruck/beans/bean_insurance_provider.dart';
import 'package:justruck/beans/bean_max_load.dart';
import 'package:justruck/beans/bean_route_details.dart';
import 'package:justruck/beans/bean_rto_details.dart';
import 'package:justruck/beans/bean_vehicle_brand.dart';
import 'package:justruck/beans/bean_vehicle_details.dart';
import 'package:justruck/beans/bean_vehicle_model.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/driver/add_driver_screen.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/common_functions.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/web_api/add_vehicle_api.dart';
import 'package:justruck/web_api/get_driver_list_api.dart';
import 'package:justruck/web_api/get_insurance_providers_api.dart';
import 'package:justruck/web_api/get_rto_list_api.dart';
import 'package:justruck/web_api/get_vehicle_brands_api.dart';
import 'package:justruck/web_api/get_vehicle_models_api.dart';
import 'package:image_picker/image_picker.dart';


class AddVehicleScreen extends StatefulWidget
{
  _AddVehicleScreen createState() => _AddVehicleScreen();
}

class _AddVehicleScreen extends State<AddVehicleScreen>
{
  TextEditingController _controllerPart2 = TextEditingController();
  TextEditingController _controllerPart3 = TextEditingController();
  TextEditingController _controllerChassisNo = TextEditingController();
  TextEditingController _controllerInsuranceNo = TextEditingController();

  TextEditingController _controllerLength = TextEditingController();
  TextEditingController _controllerBreadth = TextEditingController();
  TextEditingController _controllerHeight = TextEditingController();

  TextEditingController _controllerNoOfTyres = TextEditingController();

  List<BeanRtoDetails> _listRtoDetails = List.empty(growable: true);
  late BeanRtoDetails _selectedRtoDetails;

  List<BeanInsuranceProvider> _listInsuranceProvider = List.empty(growable: true);
  late BeanInsuranceProvider _selectedInsProvider;

  List<BeanVehicleBrand> _listVehicleBrand = List.empty(growable: true);
  late BeanVehicleBrand _selectedVehicleBrand;

  List<BeanVehicleModel> _listVehicleModel = List.empty(growable: true);
  late BeanVehicleModel _selectedVehicleModel;

  List<BeanMaxLoad> _listMaxLoad = List.empty(growable: true);
  late BeanMaxLoad _selectedMaxLoad;

  List<BeanBodyTypes> _listBodyTypes = List.empty(growable: true);
  late BeanBodyTypes _selectedBodyType;

  List<BeanDriverDetails> _listDrivers = List.empty(growable: true);
  late BeanDriverDetails _selectedDriver;

  String _volume = "0.0", _vehicleNumber = "";
  bool _showProgress = false;
  BeanDateTime _insuranceValidFromDate = BeanDateTime.getBlankDate();
  BeanDateTime _insuranceValidTillDate = BeanDateTime.getBlankDate();
  final ImagePicker _picker = ImagePicker();
  XFile? insuranceImage;
  XFile? vehicleImage;

  @override
  void initState()
  {
    _listRtoDetails = BeanRtoDetails.getDefaultRtoList();
    _selectedRtoDetails = _listRtoDetails[0];

    _listInsuranceProvider = BeanInsuranceProvider.getDefaultInsuranceProviders();
    _selectedInsProvider = _listInsuranceProvider[0];

    _listVehicleBrand = BeanVehicleBrand.getDefaultBrands();
    _selectedVehicleBrand = _listVehicleBrand[0];

    _listVehicleModel = BeanVehicleModel.getDefaultModels();
    _selectedVehicleModel = _listVehicleModel[0];

    _listMaxLoad = BeanMaxLoad.getDefaultLoads();
    _selectedMaxLoad = _listMaxLoad[0];

    _listBodyTypes = BeanBodyTypes.getDefaultBodyTypes();
    _selectedBodyType = _listBodyTypes[0];

    _listDrivers = BeanDriverDetails.getDefaultDriverList();
    _selectedDriver = _listDrivers[0];

    _getDataFromAPIs();
  }

  _getDataFromAPIs() async
  {
    await _getRTOList();
    await _getInsuranceProvidersList();
    await _getVehicleBrandsList();
    await _getDriverList();
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
        appBar: AppBar(title: Text(S.of(context).addVehicle)),
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
                          child: Row(
                            children: [
                              CommonWidgets.getH3NormalText(S.of(context).vehicleNumber+" - ", Colors.black),
                              CommonWidgets.getH3NormalText(_vehicleNumber, Colors.black)
                            ],
                          )
                      ),
                      Container(
                          margin: const EdgeInsets.only(top:5.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  decoration: Style.getRoundedGreyBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:2,top: 0,bottom: 0, right: 2),
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5, right: 5),
                                      child: DropdownButton<BeanRtoDetails>(
                                        value: _selectedRtoDetails,
                                        isExpanded: true,
                                        underline: Container(color: Colors.transparent),
                                        items: _listRtoDetails.map((type) =>
                                            DropdownMenuItem(
                                                child: CommonWidgets.getH4NormalText(type.displayName, Colors.black),
                                                value: type)
                                        ).toList(),
                                        onChanged: (value)
                                        {
                                          setState(()
                                          {
                                            _selectedRtoDetails = value!;
                                            String strVehicleNo = _appendVehicleNumbers();
                                            _vehicleNumber = strVehicleNo;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: _controllerPart2,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 5,
                                  onChanged: (String value)
                                  {
                                    setState(()
                                    {
                                      String strVehicleNo = _appendVehicleNumbers();
                                      _vehicleNumber = strVehicleNo;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: S.of(context).part2+" *",
                                    hintText: S.of(context).part2eg,
                                    counterText: "",
                                    contentPadding: Style.getTextFieldContentPadding(),
                                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                flex: 4,
                                child: TextFormField(
                                  controller: _controllerPart3,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 5,
                                  onChanged: (String value)
                                  {
                                    setState(()
                                    {
                                      String strVehicleNo = _appendVehicleNumbers();
                                      _vehicleNumber = strVehicleNo;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: S.of(context).part3+" *",
                                    hintText: S.of(context).part3eg,
                                    counterText: "",
                                    contentPadding: Style.getTextFieldContentPadding(),
                                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerChassisNo,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: S.of(context).chassisNumber+" *",
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
                            child: DropdownButton<BeanInsuranceProvider>(
                              value: _selectedInsProvider,
                              isExpanded: true,
                              underline: Container(color: Colors.transparent),
                              items: _listInsuranceProvider.map((type) =>
                                  DropdownMenuItem(
                                      child: CommonWidgets.getH3NormalText(type.providerName, Colors.black),
                                      value: type)
                              ).toList(),
                              onChanged: (value)
                              {
                                setState(()
                                {
                                  _selectedInsProvider = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerInsuranceNo,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: S.of(context).insuranceNumber,
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidgets.getH3NormalText(S.of(context).insuranceValidFrom, Colors.black),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(S.of(context).pickDate),
                                  Container(child: Text(_insuranceValidFromDate.readableDate, style: TextStyle(fontSize: 14))),
                                  IconButton(
                                      icon: Icon(Icons.date_range, color: primaryColor),
                                      onPressed: () async
                                      {
                                        BeanDateTime? beanDateTime = await CommonWidgets.showDatePickerDialog(context,
                                            DateTime.now(), DateTime.now().add(const Duration(days: 366)));
                                        if(beanDateTime!=null)
                                        {
                                          setState(() {
                                            _insuranceValidFromDate = beanDateTime;
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
                        margin: const EdgeInsets.only(top:10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidgets.getH3NormalText(S.of(context).insuranceValidTill, Colors.black),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(S.of(context).pickDate),
                                  Container(child: Text(_insuranceValidTillDate.readableDate, style: TextStyle(fontSize: 14))),
                                  IconButton(
                                      icon: Icon(Icons.date_range, color: primaryColor),
                                      onPressed: () async
                                      {
                                        BeanDateTime? beanDateTime = await CommonWidgets.showDatePickerDialog(context,
                                            DateTime.now(), DateTime.now().add(const Duration(days: 366)));
                                        if(beanDateTime!=null)
                                        {
                                          setState(() {
                                            _insuranceValidTillDate = beanDateTime;
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
                            CommonWidgets.getH3NormalText(S.of(context).insuranceCopy, Colors.black),
                            GestureDetector(
                              child: Container(
                                decoration: Style.getRoundedGreyBorder(),
                                margin: const EdgeInsets.only(top: 2),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:5,top: 0,bottom: 0, right: 5),
                                  child: insuranceImage!=null ? Container(
                                    width: double.infinity,
                                    height: 120,
                                    margin: const EdgeInsets.only(left: 5, right: 5),
                                    child: Image.file(File(insuranceImage!.path),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ) : Container(
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
                                  insuranceImage = image;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: Style.getRoundedGreyBorder(),
                        margin: const EdgeInsets.only(top: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(left:5,top: 0,bottom: 0, right: 5),
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: DropdownButton<BeanVehicleBrand>(
                              value: _selectedVehicleBrand,
                              isExpanded: true,
                              underline: Container(color: Colors.transparent),
                              items: _listVehicleBrand.map((type) =>
                                  DropdownMenuItem(
                                      child: CommonWidgets.getH3NormalText(type.brandName, Colors.black),
                                      value: type)
                              ).toList(),
                              onChanged: (value)
                              {
                                setState(()
                                {
                                  _selectedVehicleBrand = value!;
                                });

                                _getVehicleModelsFor(_selectedVehicleBrand.brandId);
                              },
                            ),
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
                            child: DropdownButton<BeanVehicleModel>(
                              value: _selectedVehicleModel,
                              isExpanded: true,
                              underline: Container(color: Colors.transparent),
                              items: _listVehicleModel.map((type) =>
                                  DropdownMenuItem(
                                      child: CommonWidgets.getH3NormalText(type.modelName, Colors.black),
                                      value: type)
                              ).toList(),
                              onChanged: (value)
                              {
                                setState(()
                                {
                                  _selectedVehicleModel = value!;
                                });
                              },
                            ),
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
                            child: DropdownButton<BeanMaxLoad>(
                              value: _selectedMaxLoad,
                              isExpanded: true,
                              underline: Container(color: Colors.transparent),
                              items: _listMaxLoad.map((type) =>
                                  DropdownMenuItem(
                                      child: CommonWidgets.getH3NormalText(type.maxLoadValue, Colors.black),
                                      value: type)
                              ).toList(),
                              onChanged: (value)
                              {
                                setState(()
                                {
                                  _selectedMaxLoad = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: Row(
                          children: [
                            CommonWidgets.getH3NormalText(S.of(context).volume+" - ", Colors.black),
                            CommonWidgets.getH3NormalText(_volume, Colors.black),
                            CommonWidgets.getH3NormalText(" "+S.of(context).cubicMetre, Colors.black),
                          ],
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _controllerLength,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (String value)
                                {
                                  String vol = _calculateVolume();
                                  setState(() {
                                    _volume = vol.toString();
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: S.of(context).length+" "+S.of(context).inMeter+" *",
                                  counterText: "",
                                  contentPadding: Style.getTextFieldContentPadding(),
                                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: TextFormField(
                                controller: _controllerBreadth,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (String value)
                                {
                                  String vol = _calculateVolume();
                                  setState(() {
                                    _volume = vol.toString();
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: S.of(context).breadth+" "+S.of(context).inMeter+" *",
                                  counterText: "",
                                  contentPadding: Style.getTextFieldContentPadding(),
                                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: TextFormField(
                                controller: _controllerHeight,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (String value)
                                {
                                  String vol = _calculateVolume();
                                  setState(() {
                                    _volume = vol.toString();
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: S.of(context).height+" "+S.of(context).inMeter+" *",
                                  counterText: "",
                                  contentPadding: Style.getTextFieldContentPadding(),
                                  border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: Style.getRoundedGreyBorder(),
                        margin: const EdgeInsets.only(top: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(left:5,top: 0,bottom: 0, right: 5),
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: DropdownButton<BeanBodyTypes>(
                              value: _selectedBodyType,
                              isExpanded: true,
                              underline: Container(color: Colors.transparent),
                              items: _listBodyTypes.map((type) =>
                                  DropdownMenuItem(
                                      child: CommonWidgets.getH3NormalText(type.typeName, Colors.black),
                                      value: type)
                              ).toList(),
                              onChanged: (value)
                              {
                                setState(()
                                {
                                  _selectedBodyType = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top:10.0),
                        child: TextFormField(
                          controller: _controllerNoOfTyres,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          maxLength: 3,
                          decoration: InputDecoration(
                            labelText: S.of(context).numberOfTyres+" *",
                            counterText: "",
                            contentPadding: Style.getTextFieldContentPadding(),
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidgets.getH3NormalText(S.of(context).vehicleImage, Colors.black),
                            GestureDetector(
                              child: Container(
                                decoration: Style.getRoundedGreyBorder(),
                                margin: const EdgeInsets.only(top: 2),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:5,top: 0,bottom: 0, right: 5),
                                  child: vehicleImage!=null ? Container(
                                    width: double.infinity,
                                    height: 120,
                                    margin: const EdgeInsets.only(left: 5, right: 5),
                                    child: Image.file(File(vehicleImage!.path),
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
                                  vehicleImage = image;
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
                            CommonWidgets.getH3NormalText(S.of(context).assignDriver+" *", Colors.black),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: Style.getRoundedGreyBorder(),
                                    margin: const EdgeInsets.only(top: 2),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:5,top: 0,bottom: 0, right: 5),
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 5, right: 5),
                                        child: DropdownButton<BeanDriverDetails>(
                                          value: _selectedDriver,
                                          isExpanded: true,
                                          underline: Container(color: Colors.transparent),
                                          items: _listDrivers.map((type) =>
                                              DropdownMenuItem(
                                                  child: CommonWidgets.getH3NormalText(type.driverName, Colors.black),
                                                  value: type)
                                          ).toList(),
                                          onChanged: (value)
                                          {
                                            setState(()
                                            {
                                              _selectedDriver = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  decoration: Style.getIconButtonStyle(),
                                  child: IconButton(
                                    icon: const Icon(Icons.add, color: Colors.white,),
                                    onPressed :()
                                    {
                                      _navigateToAddDriverScreen();
                                    },
                                  ),
                                )
                              ],
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
                            child: Text(S.of(context).addVehicle.toUpperCase()),
                          ),
                          onPressed: ()
                          {
                            if(_validate())
                            {
                              _submitVehicleDetails();
                            }
                          },
                        ),
                      )
                    ],
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
      ),
    );
  }

  String _appendVehicleNumbers()
  {
    String vehicleNumber = "";
    String part1 = _selectedRtoDetails.displayName;
    String part2 = _controllerPart2.text.toString().trim();
    String part3 = _controllerPart3.text.toString().trim();

    vehicleNumber = part1 + part2 + part3;
    return vehicleNumber;
  }

  String _calculateVolume()
  {
    double volume = 0;

    String strLen = _controllerLength.text.trim();
    String strBreadth = _controllerBreadth.text.trim();
    String strHeigth = _controllerHeight.text.trim();

    double l = double.parse(strLen.isEmpty ? "0" : strLen).toDouble();
    double b = double.parse(strBreadth.isEmpty ? "0" : strBreadth).toDouble();
    double h = double.parse(strHeigth.isEmpty ? "0" : strHeigth).toDouble();

    volume = l * b * h;

    //print(volume.toString());

    return volume.toString();
  }

  _navigateToAddDriverScreen() async
  {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> AddDriverScreen()));
    if(result==true)
    {
      _getDriverList();
    }
  }

  _validate()
  {
    bool valid = true;

    if(_selectedRtoDetails.id=="0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectRTO);
    }
    else if(_controllerPart2.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterVehicleNo);
    }
    else if(_controllerPart3.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterVehicleNo);
    }
    else if(_controllerChassisNo.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterChassisNo);
    }
    else if(_selectedVehicleBrand.brandId=="0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectVehicleBrand);
    }
    else if(_selectedVehicleModel.modelId=="0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectVehicleModel);
    }
    else if(_selectedMaxLoad.maxLoadId=="0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectMaxLoadValue);
    }

    else if(_controllerLength.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterLength);
    }
    else if(_controllerBreadth.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterBreadth);
    }
    else if(_controllerHeight.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterHeight);
    }

    else if(_selectedBodyType.typeId=="0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectBodyType);
    }
    else if(_controllerNoOfTyres.text.toString().trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterNoOfTyres);
    }
    else if(_selectedDriver.id=="0")
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzSelectDriverToAssign);
    }

    return valid;
  }

  _getInsuranceProvidersList() async
  {
    setState(() { _showProgress = true; });

    List<BeanInsuranceProvider> tempList = await GetInsuranceProvidersAPI.getProvidersList();
    if(tempList.length > 0)
    {
      setState(() {
        _listInsuranceProvider.addAll(tempList);
      });
    }

    setState(() { _showProgress = false; });
  }

  _getRTOList() async
  {
    setState(() { _showProgress = true; });

    List<BeanRtoDetails> tempList = await GetRTOListAPI.getRtoDetailsList();
    if(tempList.isNotEmpty)
    {
      setState(() {
        _listRtoDetails.addAll(tempList);
      });
    }

    setState(() { _showProgress = false; });
  }

  _getVehicleBrandsList() async
  {
    setState(() { _showProgress = true; });

    List<BeanVehicleBrand> tempList = await GetVehicleBrandsAPI.retrieveVehicleBrandsList();
    if(tempList.length > 0)
    {
      setState(() {
        _listVehicleBrand.addAll(tempList);
      });
    }

    setState(() { _showProgress = false; });
  }

  _getVehicleModelsFor(String brandId) async
  {
    _listVehicleModel.clear();
    _listVehicleModel = BeanVehicleModel.getDefaultModels();
    _selectedVehicleModel = _listVehicleModel[0];

    setState(() { _showProgress = true; });

    List<BeanVehicleModel> tempList = await GetVehicleModelsAPI.retrieveVehicleModelsList(brandId);
    if(tempList.length > 0)
    {
      setState(() {
        _listVehicleModel.addAll(tempList);
      });
    }

    setState(() { _showProgress = false; });
  }

  _getDriverList() async
  {
    _listDrivers.clear();
    _listDrivers = BeanDriverDetails.getDefaultDriverList();
    _selectedDriver = _listDrivers[0];

    setState(() { _showProgress = true; });

    List<BeanDriverDetails> tempList = await GetDriverListAPI.getDriverDetailsList();

    setState(() { _showProgress = false; });

    if(tempList.isNotEmpty)
    {
      setState(() {
        _listDrivers.addAll(tempList);
      });
    }
  }

  _submitVehicleDetails() async
  {
    BeanVehicleDetails vehicleDetails = BeanVehicleDetails("0", "");

    vehicleDetails.vehicleNumber = _vehicleNumber;

    vehicleDetails.rtoId = _selectedRtoDetails.id;
    vehicleDetails.part2 = _controllerPart2.text.toString().trim();
    vehicleDetails.part3 = _controllerPart3.text.toString().trim();

    vehicleDetails.chassisNumber = _controllerChassisNo.text.toString().trim();
    vehicleDetails.insuranceProviderId = _selectedInsProvider.providerId;
    vehicleDetails.insuranceNumber = _controllerInsuranceNo.text.toString().trim();
    vehicleDetails.insuranceValidFrom = _insuranceValidFromDate.date;
    vehicleDetails.insuranceValidTill = _insuranceValidTillDate.date;

    vehicleDetails.vehicleBrandId = _selectedVehicleBrand.brandId;
    vehicleDetails.vehicleModelId = _selectedVehicleModel.modelId;
    vehicleDetails.loadCapacity = _selectedMaxLoad.maxLoadValue;

    vehicleDetails.volume = _volume;
    vehicleDetails.length = _controllerLength.text.toString().trim();
    vehicleDetails.breadth = _controllerBreadth.text.toString().trim();
    vehicleDetails.height = _controllerHeight.text.toString().trim();

    vehicleDetails.bodyType = _selectedBodyType.typeName;
    vehicleDetails.numberOfTyres = _controllerNoOfTyres.text.toString().trim();
    vehicleDetails.assignedDriver = _selectedDriver.id;

    vehicleDetails.insuranceImage = insuranceImage!=null ? insuranceImage!.path : "";
    vehicleDetails.vehicleImage = vehicleImage!=null ? vehicleImage!.path : "";

    setState(() { _showProgress = true; });

    bool vehicleAdded = await AddVehicleAPI.submitVehicleDetails(vehicleDetails);

    setState(() { _showProgress = false; });

    if(vehicleAdded)
    {
      Navigator.of(context).pop(true);
    }
  }
}