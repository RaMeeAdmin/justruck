import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_city.dart';
import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/beans/bean_route_details.dart';
import 'package:justruck/beans/bean_state.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';

class GetRouteListAPI
{
  static Future<List<BeanRouteDetails>> getRouteList() async
  {
    List<BeanRouteDetails> listRoutes = List.empty(growable: true);
    listRoutes.clear();

    String url = URLHelper.wsListRoute;

    var client = http.Client();

    try
    {
      print("Getting Routes List => "+ url);

      String jwtToken = await PreferenceHelper.getJwtToken();

      Map<String, String> header = {
        "Content-Type":"application/json",
        "Authorization":"Bearer "+jwtToken
      };

      var uriResponse = await client.get(
          Uri.parse(url),
        headers: header
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> citiesData = response['data'];
          for (int i=0; i<citiesData.length; i++)
          {
            String routeId = citiesData[i]['id'] ?? "0";
            String routeName = citiesData[i]['route_name'] ?? "NA";
            String startLocationId = citiesData[i]['start_location_id'] ?? "NA";
            String endLocationId = citiesData[i]['end_location_id'] ?? "NA";
            String startLocationName = citiesData[i]['start_location_name'] ?? "NA";
            String endLocationName = citiesData[i]['end_location_name'] ?? "NA";

            List<BeanIdValue> _listIntermediateLocations = List.empty(growable: true);
            List<dynamic> intLocations = citiesData[i]['intermediate_location'];
            for(int k=0; k < intLocations.length; k++)
            {
              String id = intLocations[k]["id"];
              String value = intLocations[k]["location_name"];
              _listIntermediateLocations.add(BeanIdValue(id, value));
            }

            BeanRouteDetails routeDetails = BeanRouteDetails(routeId, routeName, startLocationId, endLocationId);
            routeDetails.listIntermediateLocations = _listIntermediateLocations;
            routeDetails.startLocationName = startLocationName;
            routeDetails.endLocationName = endLocationName;

            listRoutes.add(routeDetails);
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listRoutes;
  }
}