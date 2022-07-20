import 'dart:convert';

import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';
import 'package:http/http.dart' as http;

class ResendOtpAPI
{
  static Future<bool> resendUserOtp(String mobileNumber) async
  {
    bool otpResend = false;

    String url = URLHelper.wsResendOTP;

    var client = http.Client();

    try
    {
      print("Resending OTP => "+url);

      var uriResponse = await client.post(Uri.parse(url),
          body: {
            'mobile_number': mobileNumber
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
          CommonWidgets.showToast(message);
          otpResend = true;
        }
        else
        {
          String message = response['message'];
          CommonWidgets.showToast(message);
          otpResend = false;
        }
      }
    }
    finally
    {
      client.close();
    }

    return otpResend;
  }
}