class BeanCustomerDetails
{
  String _id = "";
  String _customerType = "";
  String _firmName = "";
  String _firstName = "", _middleName = "", _lastName = "";
  String _mobileNumber = "", _emailAddress = "", _addressLine1 = "", _addressLine2 = "";
  String _landmark = "", _pinCode = "";
  String _cityId = "", _stateCode = "";
  String _cityName = "", _districtName = "", _stateName = "";


  BeanCustomerDetails(this._id);

  String get id => _id;

  set id(String value) {
    _id = value;
  }


  String get customerType => _customerType;

  set customerType(String value) {
    _customerType = value;
  }

  String get firstName => _firstName;

  get stateName => _stateName;

  set stateName(value) {
    _stateName = value;
  }

  get districtName => _districtName;

  set districtName(value) {
    _districtName = value;
  }

  String get cityName => _cityName;

  set cityName(String value) {
    _cityName = value;
  }

  get stateCode => _stateCode;

  set stateCode(value) {
    _stateCode = value;
  }

  String get cityId => _cityId;

  set cityId(String value) {
    _cityId = value;
  }

  get pinCode => _pinCode;

  set pinCode(value) {
    _pinCode = value;
  }

  String get landmark => _landmark;

  set landmark(String value) {
    _landmark = value;
  }

  get addressLine2 => _addressLine2;

  set addressLine2(value) {
    _addressLine2 = value;
  }

  get addressLine1 => _addressLine1;

  set addressLine1(value) {
    _addressLine1 = value;
  }

  get emailAddress => _emailAddress;

  set emailAddress(value) {
    _emailAddress = value;
  }

  String get mobileNumber => _mobileNumber;

  set mobileNumber(String value) {
    _mobileNumber = value;
  }

  get lastName => _lastName;

  set lastName(value) {
    _lastName = value;
  }

  get middleName => _middleName;

  set middleName(value) {
    _middleName = value;
  }

  set firstName(String value) {
    _firstName = value;
  }

  String get firmName => _firmName;

  set firmName(String value) {
    _firmName = value;
  }
}