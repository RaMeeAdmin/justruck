import 'package:justruck/other/strings.dart';

class BeanDriverDetails
{
  String _id = "", _driverName = "";
  String _mobileNumber = "";
  String _currentAddressLine1 = "", _currentAddressLine2 = "", _currentCityId = "", _currentDistrict = "", _currentState = "";
  String _permanentAddressLine1 = "", _permanentAddressLine2 = "", _permanentCityId = "", _permanentDistrict = "", _permanentState = "";
  String _aadharNo = "", _drivingLicenseNo = "", _licesneType = "";
  String _licesneExpiryDate = "";
  String _driverImage = "", _driverLicenseImageUrl = "", _aadharImaage = "";
  String _assignedVehicle = "";

  BeanDriverDetails(this._id, this._driverName, this._mobileNumber, this._currentAddressLine1, this._assignedVehicle, this._driverImage);


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  get driverName => _driverName;

  set driverName(value) {
    _driverName = value;
  }

  String get mobileNumber => _mobileNumber;

  set mobileNumber(String value) {
    _mobileNumber = value;
  }

  String get currentAddressLine1 => _currentAddressLine1;

  set currentAddressLine1(String value) {
    _currentAddressLine1 = value;
  }

  get currentAddressLine2 => _currentAddressLine2;

  set currentAddressLine2(value) {
    _currentAddressLine2 = value;
  }

  get currentCityId => _currentCityId;

  set currentCityId(value) {
    _currentCityId = value;
  }

  get currentDistrict => _currentDistrict;

  set currentDistrict(value) {
    _currentDistrict = value;
  }

  get currentState => _currentState;

  set currentState(value) {
    _currentState = value;
  }

  String get permanentAddressLine1 => _permanentAddressLine1;

  set permanentAddressLine1(String value) {
    _permanentAddressLine1 = value;
  }

  get permanentAddressLine2 => _permanentAddressLine2;

  set permanentAddressLine2(value) {
    _permanentAddressLine2 = value;
  }

  get permanentCityId => _permanentCityId;

  set permanentCityId(value) {
    _permanentCityId = value;
  }

  get permanentDistrict => _permanentDistrict;

  set permanentDistrict(value) {
    _permanentDistrict = value;
  }

  get permanentState => _permanentState;

  set permanentState(value) {
    _permanentState = value;
  }

  String get aadharNo => _aadharNo;

  set aadharNo(String value) {
    _aadharNo = value;
  }

  get drivingLicenseNo => _drivingLicenseNo;

  set drivingLicenseNo(value) {
    _drivingLicenseNo = value;
  }

  get licesneType => _licesneType;

  set licesneType(value) {
    _licesneType = value;
  }

  String get licesneExpiryDate => _licesneExpiryDate;

  set licesneExpiryDate(String value) {
    _licesneExpiryDate = value;
  }

  String get driverImage => _driverImage;

  set driverImage(String value) {
    _driverImage = value;
  }

  get driverLicenseImageUrl => _driverLicenseImageUrl;

  set driverLicenseImageUrl(value) {
    _driverLicenseImageUrl = value;
  }

  get aadharImaage => _aadharImaage;

  set aadharImaage(value) {
    _aadharImaage = value;
  }

  String get assignedVehicle => _assignedVehicle;

  set assignedVehicle(String value) {
    _assignedVehicle = value;
  }

  static List<BeanDriverDetails> getDefaultDriverList()
  {
    List<BeanDriverDetails> _listDriverDetails = List.empty(growable: true);

    _listDriverDetails.add(BeanDriverDetails("0", Strings.selectDriver, "", "", "", ""));
    /*_listDriverDetails.add(BeanDriverDetails("1", "Ravi Humbad", "7218322323", Strings.sampleAddress, "MH 12 AB 1234", "https://www.safetyandhealthmagazine.com/ext/resources/images/news/transportation/semi-trucks/truck-driver2.jpg?1485370910"));
    _listDriverDetails.add(BeanDriverDetails("1", "Suraj B", "7276618383", Strings.sampleAddress, "MH 12 AB 1235", "https://www.explosion.com/wp-content/uploads/2019/06/truck.jpg"));
    _listDriverDetails.add(BeanDriverDetails("1", "Nikhil S", "8745563222", Strings.sampleAddress, "MH 12 AB 1236", "https://assets.website-files.com/5876c7374691a7d805ce8d19/5bbe0f2af2fd2f0e0d51faa1_shutterstock_567354313%20(1).jpg"));*/

    return _listDriverDetails;
  }
}