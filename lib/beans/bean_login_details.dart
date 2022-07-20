class BeanLoginDetails
{
  String _isLoggedIn = "", _jwtToken= "", _loggedInAs= "";

  String _logInUniqueId = ""; // login unique id (universally unique)
  String _userId = ""; // role specific unique id

  String _username = "", _mobileNumber  = "";
  String _addressLine1 = "", _addressLine2 = "";

  String _companyName = "", _companyEmail = "";
  String _isGSTRegistered = "", _isHomeDeliveryProvided = "", _isInsuranceProvided = "";

  String _isOTPVerified = "N"; // checks if is OTP verified or not
  String _isApproved = "N"; // checks if is approved by admin or not

  String get isLoggedIn => _isLoggedIn;

  set isLoggedIn(String value) {
    _isLoggedIn = value;
  }

  get jwtToken => _jwtToken;

  get isInsuranceProvided => _isInsuranceProvided;

  set isInsuranceProvided(value) {
    _isInsuranceProvided = value;
  }

  get isHomeDeliveryProvided => _isHomeDeliveryProvided;

  set isHomeDeliveryProvided(value) {
    _isHomeDeliveryProvided = value;
  }

  String get isGSTRegistered => _isGSTRegistered;

  set isGSTRegistered(String value) {
    _isGSTRegistered = value;
  }

  get companyEmail => _companyEmail;

  set companyEmail(value) {
    _companyEmail = value;
  }

  String get companyName => _companyName;

  set companyName(String value) {
    _companyName = value;
  }

  get addressLine2 => _addressLine2;

  set addressLine2(value) {
    _addressLine2 = value;
  }

  String get addressLine1 => _addressLine1;

  set addressLine1(String value) {
    _addressLine1 = value;
  }

  get mobileNumber => _mobileNumber;

  set mobileNumber(value) {
    _mobileNumber = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  String get logInUniqueId => _logInUniqueId;

  set logInUniqueId(String value) {
    _logInUniqueId = value;
  }

  get loggedInAs => _loggedInAs;

  set loggedInAs(value) {
    _loggedInAs = value;
  }

  set jwtToken(value) {
    _jwtToken = value;
  }

  String get isOTPVerified => _isOTPVerified;

  set isOTPVerified(String value) {
    _isOTPVerified = value;
  }

  get isApproved => _isApproved;

  set isApproved(value) {
    _isApproved = value;
  }
}