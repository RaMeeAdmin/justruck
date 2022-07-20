import 'dart:convert';
import 'package:justruck/beans/bean_location_details.dart';
import 'package:justruck/beans/bean_login_details.dart';
import 'package:justruck/beans/bean_manifest_details.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_registration_details.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';
import 'package:http/http.dart' as http;

class SaveParcelTrackAPI
{
  static Future<bool> updateParcelTrack(List<BeanParcelDetails> listManifestParcels, BeanLocationDetails locationDetails) async
  {
    bool manifestAdded = false;

    String url = URLHelper.wsSaveParcelTrack;
    print("Saving Parcel Status => "+url);

    var client = http.Client();

    try
    {
      List<Map> _manifestParcels = List.empty(growable: true);

      for (int i=0; i<listManifestParcels.length; i++)
      {
        String locationDetails = jsonEncode({
          "parcelId": listManifestParcels[i].parcelId,
          "status": listManifestParcels[i].parcelStatus,
          "is_scanned": listManifestParcels[i].isScanned,
          "description": listManifestParcels[i].trackDescription
        });

        Map decoded = jsonDecode(locationDetails);
        _manifestParcels.add(decoded);
      }

      BeanLoginDetails loginDetails = await PreferenceHelper.getLoginDetails();

      String outerJson = jsonEncode({
        "user_id": loginDetails.logInUniqueId,
        "latitude": locationDetails.latitude,
        "longitude": locationDetails.longitude,
        "address": locationDetails.address,
        "parcel_list": _manifestParcels,
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
        manifestAdded = true;
      }
      else
      {
        manifestAdded = false;
      }
    }
    finally
    {
      client.close();
    }

    return manifestAdded;
  }
}