import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';

class GetParcelListAPI
{
  static Future<List<BeanParcelDetails>> retrieveParcelList(String strStatus) async
  {
    List<BeanParcelDetails> listParcel = List.empty(growable: true);
    listParcel.clear();

    String url = URLHelper.wsListParcel;

    var client = http.Client();

    try
    {
      print("Getting Parcel List => "+ url);

      String jwtToken = await PreferenceHelper.getJwtToken();

      Map<String, String> header = {
        "Authorization":"Bearer "+jwtToken
      };

      var uriResponse = await client.post(Uri.parse(url),
          body: {
              'status':strStatus
          },
          headers: header
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> parcelDetails = response['data'];
          for (int i=0; i<parcelDetails.length; i++)
          {
            String _parcelId = parcelDetails[i]['id'] ?? "NA";
            String _parcelBookingDate = parcelDetails[i]['created_at'] ?? "NA";
            String _senderName = parcelDetails[i]['sender_name'] ?? "NA";
            String _receiverName = parcelDetails[i]['receiver_name'] ?? "NA";
            String _senderCityName = parcelDetails[i]['senderCityName'] ?? "NA";
            String _receiverCityName = parcelDetails[i]['receiverCityName'] ?? "NA";
            String _parcelStatus = parcelDetails[i]['parcelStatus'] ?? "NA";
            String _bookingDate = parcelDetails[i]['booking_date'] ?? "NA";

            BeanParcelDetails pd = BeanParcelDetails(_parcelId.toString(), _parcelBookingDate,
                _senderName, _receiverName, _senderCityName, _receiverCityName, _parcelStatus);
            pd.parcelBookingDate = _bookingDate;

            listParcel.add(pd);
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listParcel;
  }
}