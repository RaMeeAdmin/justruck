import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';

class ChangePinAPI
{
  static Future<bool> changeUserPin(String userId, String oldPIN, String newPIN, String confirmedPIN) async
  {
    bool pinChanged = false;

    var client = http.Client();

    try
    {
      String url = URLHelper.wsChangePin;

      String jwtToken = await PreferenceHelper.getJwtToken();
      Map<String, String> header = {"Authorization":"Bearer "+jwtToken};

      print("Changing User Pin => "+url);

      var uriResponse = await client.post(Uri.parse(url),
          headers: header,
          body: {
            'old_pin': oldPIN,
            'new_pin': newPIN,
            'confirm_new_pin': confirmedPIN,
            'user_id': userId,
          }
      );

      print('response: ${uriResponse.body}');
      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          pinChanged = true;
          String message = response['message'];
          CommonWidgets.showToast(message);
        }
        else
        {
          pinChanged = false;
          String message = response['message'];
          CommonWidgets.showToast(message);
        }
      }
    }
    finally
    {
      client.close();
    }

    return pinChanged;
  }
}