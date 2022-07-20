import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_login_details.dart';
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';

class LoginAPI
{
  static Future<BeanResponse> performLogin(String mobileNo, String password) async
  {
    BeanResponse loginResponse = BeanResponse(false, "", "");

    String url = URLHelper.wsLogin;
    print("Performing Login => "+url);

    var client = http.Client();

    try
    {
      var uriResponse = await client.post(Uri.parse(url),
        body: {
        'username': mobileNo,
        'password': password,
        }
      );

      print(uriResponse.body.toString());

      int statusCode = uriResponse.statusCode;

      Map response = jsonDecode(uriResponse.body);
      if(response[CommonConstants.success]== true)
      {
        loginResponse.success = true;

        String jwtToken = response['token'] ?? "";
        await PreferenceHelper.setJwtToken(jwtToken);

        var data = response['data'];

        loginResponse.data = response['data'];

        String userType = data['user_type'];
        if(userType==CommonConstants.typeTrucker)
        {
          String loginUniqueId = data['id'] ?? "";
          String userId = data['user_id'] ?? "";
          String mobileNo = data['username'] ?? "";
          String companyName = data['company_name'] ?? "";
          String addressLine1 = data['address_1']?? "";
          String addressLine2 = data['address_2'] ?? "";
          String isOTPVerified = data['isVerified'] ?? "";
          String isGstRegistered = data['is_gst_registered'] ?? "";

          BeanLoginDetails loginDetails = BeanLoginDetails();
          loginDetails.userId = userId;
          loginDetails.username = mobileNo;
          loginDetails.mobileNumber = mobileNo;
          loginDetails.companyName = companyName;
          loginDetails.addressLine1 = addressLine1;
          loginDetails.addressLine2 = addressLine2;
          loginDetails.isOTPVerified = isOTPVerified;
          loginDetails.isGSTRegistered = isGstRegistered;

          await PreferenceHelper.saveLoginDetails(loginDetails);
          await PreferenceHelper.setLoggedInAs(CommonConstants.typeTrucker, loginUniqueId);
        }
        else if(userType==CommonConstants.typeTransporter)
        {
          String loginUniqueId = data['id'] ?? "";
          String userId = data['user_id'] ?? "";
          String mobileNo = data['username'] ?? "";
          String companyName = data['company_name'] ?? "";
          String addressLine1 = data['address_1']?? "";
          String addressLine2 = data['address_2'] ?? "";

          String companyEmail = data['comapny_email'] ?? "";
          String isGstRegistered = data['is_gst_registered'] ?? "";
          String isHomeDeliveryProvided = data['isHomeDeliveryProvided'] ?? "";
          String isInsuranceProvided = data['isInsuranceProvided'] ?? "";

          BeanLoginDetails loginDetails = BeanLoginDetails();
          loginDetails.userId = userId;
          loginDetails.username = mobileNo;
          loginDetails.mobileNumber = mobileNo;
          loginDetails.companyName = companyName;
          loginDetails.addressLine1 = addressLine1;
          loginDetails.addressLine2 = addressLine2;

          loginDetails.companyEmail = companyEmail;
          loginDetails.isGSTRegistered = isGstRegistered;
          loginDetails.isHomeDeliveryProvided = isHomeDeliveryProvided;
          loginDetails.isInsuranceProvided = isInsuranceProvided;

          await PreferenceHelper.saveLoginDetails(loginDetails);
          await PreferenceHelper.setLoggedInAs(CommonConstants.typeTransporter, loginUniqueId);
        }
        else if(userType==CommonConstants.typeDriver)
        {
          String loginUniqueId = data['id'] ?? "";
          String userId = data['user_id'] ?? "";
          String driverName = data['name'] ?? "";
          String mobileNumber = data['mobile'] ?? "";
          String currentAddressLine1 = data['current_address_line_1'] ?? "";
          String assignedVehicle = "";
          String driverImage = "";

          BeanLoginDetails loginDetails = BeanLoginDetails();
          loginDetails.userId = userId;
          loginDetails.username = mobileNumber;
          loginDetails.mobileNumber = mobileNumber;
          loginDetails.addressLine1 = currentAddressLine1;
          loginDetails.companyName = driverName;

          await PreferenceHelper.saveLoginDetails(loginDetails);
          await PreferenceHelper.setLoggedInAs(CommonConstants.typeDriver, loginUniqueId);
        }
      }
      else
      {
        loginResponse.success = false;
        CommonWidgets.showToast(response[CommonConstants.message]);
      }
    }
    finally
    {
      client.close();
    }

    return loginResponse;
  }
}