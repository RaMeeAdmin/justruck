import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_track_details.dart';
import 'package:justruck/beans/bean_track_response.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/url_helper.dart';

class GetParcelTrackAPI
{
  static Future<BeanTrackResponse> getTrackingDetailsFor(String strParcelId) async
  {
    BeanTrackResponse trackResponse = BeanTrackResponse(false, "");

    List<BeanTrackDetails> _listTrackDetails = List.empty(growable: true);
    _listTrackDetails.clear();

    String url = URLHelper.wsGetParcelTrack;

    var client = http.Client();

    try
    {
      print("Getting Parcel Tracking Details => "+ url);

      String jwtToken = await PreferenceHelper.getJwtToken();

      Map<String, String> header = {
        "Content-Type":"application/json",
        "Authorization":"Bearer "+jwtToken
      };

      var uriResponse = await client.post(Uri.parse(url),
          body: {
            'parcel_id': strParcelId
          }
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          trackResponse.success = true;

          List<dynamic> trackingData = response['data'];
          for (int i=0; i<trackingData.length; i++)
          {
            String id = trackingData[i]['id'] ?? "0";
            String parcelId = trackingData[i]['parcel_id'] ?? "NA";
            String date = trackingData[i]['date'] ?? "NA";
            String time = trackingData[i]['time'] ?? "NA";
            String status = trackingData[i]['status'] ?? "NA";
            String description = trackingData[i]['description'] ?? "NA";
            String address = trackingData[i]['last_location'] ?? "NA";

            BeanTrackDetails trackDetails = BeanTrackDetails(id, parcelId, date, time, status, description);
            trackDetails.address = address;

            _listTrackDetails.add(trackDetails);
          }

          trackResponse.listTrackDetails = _listTrackDetails;

          Map parcelData = response['parcel_data'];

          BeanParcelDetails parcelDetails = BeanParcelDetails.empty();
          parcelDetails.parcelId = strParcelId;
          parcelDetails.senderName = parcelData['sender_name'];
          parcelDetails.senderMobile = parcelData['sender_mobile'];
          parcelDetails.receiverName = parcelData['receiver_name'];
          parcelDetails.receiverMobile = parcelData['receiver_mobile'];

          trackResponse.parcelDetails = parcelDetails;
        }
        else
        {
          trackResponse.success = false;
          trackResponse.message = response[CommonConstants.message];
        }
      }
    }
    finally
    {
      client.close();
    }

    return trackResponse;
  }
}