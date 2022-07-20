import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_city.dart';
import 'package:justruck/beans/bean_id_value.dart';
import 'package:justruck/beans/bean_route_details.dart';
import 'package:justruck/beans/bean_rto_details.dart';
import 'package:justruck/beans/bean_state.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';

class GetRTOListAPI
{
  static Future<List<BeanRtoDetails>> getRtoDetailsList() async
  {
    List<BeanRtoDetails> listRto = List.empty(growable: true);
    listRto.clear();

    String url = URLHelper.wsGetRtoList;

    var client = http.Client();

    try
    {
      print("Getting RTO List => "+ url);

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
          List<dynamic> citiesData = response['rto'];
          for (int i=0; i<citiesData.length; i++)
          {
            String id = citiesData[i]['id'] ?? "0";
            String stateName = citiesData[i]['state_name'] ?? "NA";
            String cityName = citiesData[i]['city_name'] ?? "NA";
            String name = citiesData[i]['name'] ?? "NA";
            String displayName = citiesData[i]['display_name'] ?? "NA";

            BeanRtoDetails beanRTODetails = BeanRtoDetails(id, name, displayName);
            beanRTODetails.stateName = stateName;
            beanRTODetails.cityName = cityName;

            listRto.add(beanRTODetails);
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listRto;
  }
}