import 'dart:convert';
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';
import 'package:http/http.dart' as http;

class RemoveParcelFromManifestAPI
{
  static Future<BeanResponse> removeParcelFromManifestList(String strManifestId, String strParcelId) async
  {
    BeanResponse beanResponse = BeanResponse(false, "", "");

    String url = URLHelper.wsRemoveParcelFromManifest;

    var client = http.Client();

    try
    {
      print("Removing Parcel "+strParcelId+" from manifest "+strManifestId+" list => "+url);

      var uriResponse = await client.post(Uri.parse(url),
          body: {
            'manifest_id': strManifestId,
            'parcel_id': strParcelId,
          }
      );

      print('response: ${uriResponse.body}');
      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          beanResponse.success = true;
          beanResponse.message = response['message'];
        }
        else
        {
          String message = response['message'];
          CommonWidgets.showToast(message);
          beanResponse.success = false;
        }
      }

    }
    finally
    {
      client.close();
    }

    return beanResponse;
  }
}