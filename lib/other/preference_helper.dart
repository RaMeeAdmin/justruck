import 'package:justruck/beans/bean_driver_details.dart';
import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/beans/bean_login_details.dart';
import 'package:justruck/beans/bean_registration_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper
{
  static const String keyIsLoggedIn = "isLoggedIn";
  static const String keyJwtToken = "jwtToken";
  static const String keyLoggedInAs = "loggedInAs";
  static const String keyLogInUniqueId = "loginUniqueId";

  static const String keyUserId = "userId";
  static const String keyUsername = "username";
  static const String keyAddressLine1 = "addressLine1";
  static const String keyAddressLine2 = "addressLine2";

  static const String keyCompanyName = "companyName";
  static const String keyCompanyEmail = "companyEmail";
  static const String keyIsGstRegistered = "isGstRegistered";
  static const String keyIsHomeDeliveryProvided = "isHomeDeliveryProvided";
  static const String keyIsInsuranceProvided = "isInsuranceProvided";

  static const String keyAppLanguage = "appLanguage";

  static const String keyLabelPrinterName = "labelPrinterName";
  static const String keyLabelPrinterDeviceId = "labelPrinterDeviceId";

  static setIsLoggedIn(bool status) async
  {
    var prefs = await  SharedPreferences.getInstance();
    prefs.setBool(keyIsLoggedIn, status);
  }

  static Future<bool> getIsLoggedIn() async
  {
    var prefs = await SharedPreferences.getInstance();
    bool status  = prefs.getBool(keyIsLoggedIn) ?? false;
    return status;
  }

  static setJwtToken(String token) async
  {
    var prefs = await  SharedPreferences.getInstance();
    prefs.setString(keyJwtToken, token);
  }

  static Future<String> getJwtToken() async
  {
    var prefs = await SharedPreferences.getInstance();
    String token  = prefs.getString(keyJwtToken) ?? "";
    return token;
  }

  static setLoggedInAs(String logInAs, String loginUniqueId) async
  {
    var prefs = await  SharedPreferences.getInstance();
    prefs.setString(keyLoggedInAs, logInAs);
    prefs.setString(keyLogInUniqueId, loginUniqueId);
  }

  static Future<String> getLoggedInAs() async
  {
    var prefs = await SharedPreferences.getInstance();
    String logInAs  = prefs.getString(keyLoggedInAs) ?? "";
    return logInAs;
  }

  static clearAllPreferences() async
  {
    var prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static saveLoginDetails(BeanLoginDetails loginDetails) async
  {
    var prefs = await  SharedPreferences.getInstance();
    prefs.setString(keyUserId, loginDetails.userId);
    prefs.setString(keyUsername, loginDetails.username);
    prefs.setString(keyCompanyName, loginDetails.companyName);
    prefs.setString(keyAddressLine1, loginDetails.addressLine1);
    prefs.setString(keyAddressLine2, loginDetails.addressLine2);

    prefs.setString(keyCompanyEmail, loginDetails.companyEmail);
    prefs.setString(keyIsGstRegistered, loginDetails.isGSTRegistered);
    prefs.setString(keyIsHomeDeliveryProvided, loginDetails.isHomeDeliveryProvided);
    prefs.setString(keyIsInsuranceProvided, loginDetails.isInsuranceProvided);
  }

  static Future<BeanLoginDetails> getLoginDetails() async
  {
    var prefs = await SharedPreferences.getInstance();
    String logInUniqueId  = prefs.getString(keyLogInUniqueId) ?? "";
    String userId  = prefs.getString(keyUserId) ?? "";
    String username  = prefs.getString(keyUsername) ?? "";
    String companyName  = prefs.getString(keyCompanyName) ?? "";
    String addressLine1  = prefs.getString(keyAddressLine1) ?? "";
    String addressLine2  = prefs.getString(keyAddressLine2) ?? "";

    String companyEmail  = prefs.getString(keyCompanyEmail) ?? "";
    String isGstRegistered  = prefs.getString(keyIsGstRegistered) ?? "N";
    String isHomeDeliveryProvided  = prefs.getString(keyIsHomeDeliveryProvided) ?? "N";
    String isInsuranceProvided  = prefs.getString(keyIsInsuranceProvided) ?? "N";

    BeanLoginDetails loginDetails = BeanLoginDetails();
    loginDetails.logInUniqueId = logInUniqueId;
    loginDetails.userId = userId;
    loginDetails.username = username;
    loginDetails.mobileNumber = username;
    loginDetails.companyName = companyName;
    loginDetails.addressLine1 = addressLine1;
    loginDetails.addressLine2 = addressLine2;

    loginDetails.companyEmail = companyEmail;
    loginDetails.isGSTRegistered = isGstRegistered;
    loginDetails.isHomeDeliveryProvided = isHomeDeliveryProvided;
    loginDetails.isInsuranceProvided = isInsuranceProvided;

    return loginDetails;
  }

  static setAppLanguage(String localeCode) async
  {
    var prefs = await  SharedPreferences.getInstance();
    prefs.setString(keyAppLanguage, localeCode);
  }

  static Future<String> getAppLanguage() async
  {
    var prefs = await SharedPreferences.getInstance();
    String localeCode  = prefs.getString(keyAppLanguage) ?? "en";
    return localeCode;
  }

  static setLabelPrinterDetails(BeanIdValue labelPrinterDetails) async
  {
    var prefs = await  SharedPreferences.getInstance();
    await prefs.setString(keyLabelPrinterDeviceId, labelPrinterDetails.id);
    await prefs.setString(keyLabelPrinterName, labelPrinterDetails.value);
  }

  static Future<BeanIdValue> getLabelPrinterDetails() async
  {
    var prefs = await SharedPreferences.getInstance();

    String deviceId  = prefs.getString(keyLabelPrinterDeviceId) ?? "";
    String name  = prefs.getString(keyLabelPrinterName) ?? "";

    BeanIdValue beanLabelPrinterDetails = BeanIdValue(deviceId, name);
    return beanLabelPrinterDetails;
  }
}