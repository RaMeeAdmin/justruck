import 'dart:convert';
import 'package:justruck/beans/bean_login_details.dart';
import 'package:justruck/beans/bean_manifest_details.dart';
import 'package:justruck/beans/bean_registration_details.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';
import 'package:http/http.dart' as http;

class AddManifestAPI
{
  static Future<bool> generateManifest(BeanManifestDetails manifestDetails) async
  {
    bool manifestAdded = false;

    String url = URLHelper.wsAddManifest;
    print("Generating Manifest => "+url);

    var client = http.Client();

    try
    {

      List<Map> _manifestParcels = List.empty(growable: true);

      for (int i=0; i<manifestDetails.listParcelDetails.length; i++)
      {
        String locationDetails = jsonEncode({
          "parcel_id": manifestDetails.listParcelDetails[i].parcelId
        });

        Map decoded = jsonDecode(locationDetails);
        _manifestParcels.add(decoded);
      }

      BeanLoginDetails loginDetails = await PreferenceHelper.getLoginDetails();

      String outerJson = jsonEncode({
        "manifest_date": '',
        "transporter_id": loginDetails.logInUniqueId,
        "route_id": manifestDetails.routeId,
        "trucker_id": '0',
        "vehicle_id": manifestDetails.vehicleId,
        "parcel_details": _manifestParcels,
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