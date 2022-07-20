import 'dart:convert';

import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';
import 'package:http/http.dart' as http;

class UpdateParcelPayDetailsAPI
{
  static Future<BeanResponse> updateParcelPaymentDetails(BeanParcelDetails parcelDetails, String notes) async
  {
    BeanResponse _updateResponse = BeanResponse(false, "", "");

    String url = URLHelper.wsUpdatePayDetails;
    print("Updating Parcel Payment Information => "+url);

    var client = http.Client();

    try
    {
      List<Map> _paymentInformation  = List.empty(growable: true);
      for (int i=0; i<parcelDetails.listPaymentDetails.length; i++)
      {
        String payDetails = jsonEncode({
          "mode": parcelDetails.listPaymentDetails[i].id,
          "amount": parcelDetails.listPaymentDetails[i].value,
        });

        Map decoded = jsonDecode(payDetails);
        _paymentInformation.add(decoded);
      }

      String outerJson = jsonEncode({
        "parcel_id": parcelDetails.parcelId,
        "note": notes,
        "paymentDetails": _paymentInformation,
      });

      print(outerJson);

      String jwtToken = await PreferenceHelper.getJwtToken();
      Map<String, String> header = {
        "Content-Type":"application/json",
        "Authorization":"Bearer "+jwtToken
      };

      var uriResponse = await client.post(Uri.parse(url),
          headers: header,
          body: outerJson
      );

      print(uriResponse.body.toString());

      Map response = jsonDecode(uriResponse.body);
      if(response[CommonConstants.success]== true)
      {
        _updateResponse.success = true;
        _updateResponse.message = response[CommonConstants.message];
      }
      else
      {
        _updateResponse.success = false;
        _updateResponse.message = response[CommonConstants.message];
      }
    }
    finally
    {
      client.close();
    }

    return _updateResponse;
  }
}