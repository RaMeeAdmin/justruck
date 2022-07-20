import 'dart:convert';

import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';
import 'package:http/http.dart' as http;

class VerifyOtpAPI
{
  static Future<bool> verifyUserOtp(String mobileNo, String otp) async
  {
    bool otpVerified = false;

    String url = URLHelper.wsVerifyOTP;

    var client = http.Client();

    try
    {
      print("Verifying OTP => "+url);

      var uriResponse = await client.post(Uri.parse(url),
          body: {
            'mobile_no': mobileNo,
            'otp': otp,
          }
      );

      print('response: ${uriResponse.body}');
      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          otpVerified = true;
        }
        else
        {
          String message = response['message'];
          CommonWidgets.showToast(message);
          otpVerified = false;
        }
      }
    }
    finally
    {
      client.close();
    }

    return otpVerified;
  }
}