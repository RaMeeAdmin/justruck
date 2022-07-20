import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_customer_details.dart';
import 'package:justruck/beans/bean_login_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';

class AddCustomerDetailsAPI
{
  static Future<BeanCustomerDetails> submitCustomerDetails(BeanCustomerDetails customerDetails) async
  {
    BeanCustomerDetails responseDetails = BeanCustomerDetails("0");

    String url = URLHelper.wsAddCustomerDetails;

    var client = http.Client();

    try
    {
      print("Adding Customer Details => "+ url);

      String jwtToken = await PreferenceHelper.getJwtToken();
      BeanLoginDetails loginDetails = await PreferenceHelper.getLoginDetails();

      Map<String, String> header = {
        "Authorization":"Bearer "+jwtToken
      };

      print("Login Id "+loginDetails.logInUniqueId);
      print("Transporter Id "+loginDetails.userId);

      var uriResponse = await client.post(Uri.parse(url),
        headers: header,
        body: {
            'customer_type': customerDetails.customerType,
            'firm_name': customerDetails.firmName,
            'first_name': customerDetails.firstName,
            'middle_name': customerDetails.middleName,
            'last_name': customerDetails.lastName,
            'mobile_no': customerDetails.mobileNumber,
            'email_address': customerDetails.emailAddress,
            'address_line_1': customerDetails.addressLine1,
            'address_line_2': customerDetails.addressLine2,
            'nearest_landmark': customerDetails.landmark,
            'pin_code': customerDetails.pinCode,
            'state_id': "0",
            'dist_id': "0",
            'city_id': customerDetails.cityId,
            'added_by': loginDetails.logInUniqueId,
            'transporter_id': loginDetails.userId,
        }
      );

      print('response: ${uriResponse.body}');
      Map response = jsonDecode(uriResponse.body);

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        if(response[CommonConstants.success] == true)
        {
          Map details = response['details'];
          responseDetails.id = details['id'] ?? "00";
          responseDetails.firstName = details['first_name'] ?? "NA";
          responseDetails.middleName = details['middle_name'] ?? "NA";
          responseDetails.lastName = details['last_name'] ?? "NA";
          responseDetails.mobileNumber = details['mobile_no'] ?? "NA";
          responseDetails.emailAddress = details['email_address'] ?? "NA";
          responseDetails.addressLine1 = details['address_line_1'] ?? "NA";
          responseDetails.addressLine2 = details['address_line_2'] ?? "NA";
          responseDetails.landmark = details['nearest_landmark'] ?? "NA";
          responseDetails.pinCode = details['pin_code'] ?? "NA";
          responseDetails.stateCode = details['state_id'] ?? "NA";
          //responseDetails = details['dist_id'] ?? "NA";
          responseDetails.cityId = details['city_id'] ?? "NA";
          responseDetails.cityName = details['city_name'] ?? "NA";
          responseDetails.districtName = details['district_name'] ?? "NA";
          responseDetails.stateName = details['state_name'] ?? "NA";
        }
        else
        {
          String message = response[CommonConstants.message];
          CommonWidgets.showToast(message);
        }
      }
    }
    finally
    {
      client.close();
    }

    return responseDetails;
  }
}