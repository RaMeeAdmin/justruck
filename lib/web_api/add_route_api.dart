import 'dart:convert';
import 'package:justruck/beans/bean_route_details.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';
import 'package:http/http.dart' as http;

class AddRouteAPI
{
  static Future<bool> saveRouteDetails(BeanRouteDetails routeDetails) async
  {
    bool routeAdded = false;

    String url = URLHelper.wsAddRoute;
    print("Adding Route => "+url);

    var client = http.Client();

    try
    {

      List<Map> _intermediateLocations = List.empty(growable: true);

      for (int i=0; i<routeDetails.listIntermediateLocations.length; i++)
      {
        String locationDetails = jsonEncode({
          "location_name": routeDetails.listIntermediateLocations[i].id
        });

        Map decoded = jsonDecode(locationDetails);
        _intermediateLocations.add(decoded);
      }

      String outerJson = jsonEncode({
        "route_name": routeDetails.routeName,
        "start_location": routeDetails.startLocationId,
        "end_location": routeDetails.endLocationId,
        "route_type": routeDetails.routeType,
        "radius_in_km": routeDetails.radiusInKM,
        "intermediate_location": _intermediateLocations,
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
        routeAdded = true;
      }
      else
      {
        routeAdded = false;
      }
    }
    finally
    {
      client.close();
    }

    return routeAdded;
  }
}