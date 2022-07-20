import 'dart:convert';

import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';
import 'package:http/http.dart' as http;

class SendOtpAPI
{
  static Future<BeanResponse> sendUserOtp(String mobileNumber, String emailId) async
  {
    //bool otpSent = false;
    BeanResponse responseBean = BeanResponse(false, "", "");

    String url = URLHelper.wsSendOTP;

    var client = http.Client();

    try
    {
      print("Resending OTP => "+url);

      var uriResponse = await client.post(Uri.parse(url),
          body: {
            'mobile': mobileNumber,
            'email': emailId,
          }
      );

      print('response: ${uriResponse.body}');
      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);

        if(response[CommonConstants.success] == true)
        {
          String message = response['message'];
          responseBean.success = true;
          responseBean.message = message;
          CommonWidgets.showToast(message);
        }
        else
        {
          String message = response['message'];
          //CommonWidgets.showToast(message);
          responseBean.success = false;
          responseBean.message = message;
        }
      }
    }
    finally
    {
      client.close();
    }

    return responseBean;
  }
}