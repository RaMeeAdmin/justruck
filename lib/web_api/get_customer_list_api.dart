import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_customer_details.dart';
import 'package:justruck/beans/bean_login_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';

class GetCustomerDetailsListAPI
{
  static Future<List<BeanCustomerDetails>> getCustomerDetailsList(String offset) async
  {
    List<BeanCustomerDetails> listCustomerDetails = List.empty(growable: true);
    listCustomerDetails.clear();

    String url = URLHelper.wsCustomerList;

    var client = http.Client();

    try
    {
      print("Getting User Details List => "+ url);

      BeanLoginDetails loginDetails = await PreferenceHelper.getLoginDetails();

      print("Transporter Id=> "+loginDetails.userId);

      var uriResponse = await client.post(
          Uri.parse(url),
        body: {
            'offset': offset,
            'transporter_id': loginDetails.userId
        }
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> customersData = response['details'];
          for (int i=0; i<customersData.length; i++)
          {
            BeanCustomerDetails tempDetails = BeanCustomerDetails("0");
            tempDetails.id = customersData[i]['id'] ?? "00";

            tempDetails.customerType = customersData[i]['customer_type'] ?? "";
            tempDetails.firmName = customersData[i]['firm_name'] ?? "";

            tempDetails.firstName = customersData[i]['first_name'] ?? "NA";
            tempDetails.middleName = customersData[i]['middle_name'] ?? "NA";
            tempDetails.lastName = customersData[i]['last_name'] ?? "NA";
            tempDetails.mobileNumber = customersData[i]['mobile_no'] ?? "NA";
            tempDetails.emailAddress = customersData[i]['email_address'] ?? "NA";
            tempDetails.addressLine1 = customersData[i]['address_line_1'] ?? "NA";
            tempDetails.addressLine2 = customersData[i]['address_line_2'] ?? "NA";
            tempDetails.landmark = customersData[i]['nearest_landmark'] ?? "NA";
            tempDetails.pinCode = customersData[i]['pin_code'] ?? "";
            tempDetails.stateCode = customersData[i]['state_id'] ?? "";
            tempDetails.cityId = customersData[i]['city_id'] ?? "0";
            tempDetails.cityName = customersData[i]['city_name'] ?? "NA";
            tempDetails.districtName = customersData[i]['district_name'] ?? "NA";
            tempDetails.stateName = customersData[i]['state_name'] ?? "NA";

            listCustomerDetails.add(tempDetails);
          }
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

    return listCustomerDetails;
  }
}