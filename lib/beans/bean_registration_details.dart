class BeanRegistrationDetails
{
  String _registrationFor = ""; //
  String _transporterOrTruckerId = "";
  String _companyType = "";
  String _companyName = "", _addressLine1 = "", _addressLine2 = "";
  String _companyState = "", _companyCity = "", _districtName = "";
  String _companyEmail = "";
  String _companyPAN = "";
  String _isGSTRegistered = "", _companyGSTIN = "";

  String _contactName = "", _contactEmail = "", _contactMobile = "", _whatsAppMobileNo = "";
  String _contactDesignation = "", _individualAadharNo = "";
  String _pin = "";

  String _bankName = "", _bankAccountNo = "", _bankIfscCode = "", _branchName = "";
  String _subscriptionTypeId = "";

  String _isHomeDeliveryProvided = "", _isInsuranceProvided = "";

  BeanRegistrationDetails();


  String get registrationFor => _registrationFor;

  set registrationFor(String value) {
    _registrationFor = value;
  }


  String get transporterOrTruckerId => _transporterOrTruckerId;

  set transporterOrTruckerId(String value) {
    _transporterOrTruckerId = value;
  }

  get branchName => _branchName;

  set branchName(value) {
    _branchName = value;
  }

  get bankIfscCode => _bankIfscCode;

  set bankIfscCode(value) {
    _bankIfscCode = value;
  }

  get bankAccountNo => _bankAccountNo;

  set bankAccountNo(value) {
    _bankAccountNo = value;
  }

  String get bankName => _bankName;

  set bankName(String value) {
    _bankName = value;
  }


  String get pin => _pin;

  set pin(String value) {
    _pin = value;
  }

  get individualAadharNo => _individualAadharNo;

  set individualAadharNo(value) {
    _individualAadharNo = value;
  }

  String get contactDesignation => _contactDesignation;

  set contactDesignation(String value) {
    _contactDesignation = value;
  }

  get contactMobile => _contactMobile;

  set contactMobile(value) {
    _contactMobile = value;
  }

  get contactEmail => _contactEmail;

  set contactEmail(value) {
    _contactEmail = value;
  }

  String get contactName => _contactName;

  set contactName(String value) {
    _contactName = value;
  }

  get companyGSTIN => _companyGSTIN;

  set companyGSTIN(value) {
    _companyGSTIN = value;
  }

  String get companyPAN => _companyPAN;

  set companyPAN(String value) {
    _companyPAN = value;
  }

  get companyCity => _companyCity;

  set companyCity(value) {
    _companyCity = value;
  }

  String get companyState => _companyState;

  set companyState(String value) {
    _companyState = value;
  }

  get addressLine2 => _addressLine2;

  set addressLine2(value) {
    _addressLine2 = value;
  }

  get addressLine1 => _addressLine1;

  set addressLine1(value) {
    _addressLine1 = value;
  }

  String get companyName => _companyName;

  set companyName(String value) {
    _companyName = value;
  }

  get companyType => _companyType;

  set companyType(value) {
    _companyType = value;
  }

  String get subscriptionTypeId => _subscriptionTypeId;

  set subscriptionTypeId(String value) {
    _subscriptionTypeId = value;
  }

  get isInsuranceProvided => _isInsuranceProvided;

  set isInsuranceProvided(value) {
    _isInsuranceProvided = value;
  }

  String get isHomeDeliveryProvided => _isHomeDeliveryProvided;

  set isHomeDeliveryProvided(String value) {
    _isHomeDeliveryProvided = value;
  }

  get whatsAppMobileNo => _whatsAppMobileNo;

  set whatsAppMobileNo(value) {
    _whatsAppMobileNo = value;
  }

  String get isGSTRegistered => _isGSTRegistered;

  set isGSTRegistered(String value) {
    _isGSTRegistered = value;
  }

  String get companyEmail => _companyEmail;

  set companyEmail(String value) {
    _companyEmail = value;
  }

  get districtName => _districtName;

  set districtName(value) {
    _districtName = value;
  }

  static BeanRegistrationDetails getDefaultDetails()
  {
    BeanRegistrationDetails beanRegistrationDetails = BeanRegistrationDetails();
    beanRegistrationDetails.companyName = "Select";
    beanRegistrationDetails.transporterOrTruckerId = "0";

    return beanRegistrationDetails;
  }
}