import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_city.dart';
import 'package:justruck/beans/bean_state.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';

class GetCityListAPI
{
  static Future<List<BeanCity>> getCityList(String stateCode) async
  {
    List<BeanCity> listCities = List.empty(growable: true);
    listCities.clear();

    String url = URLHelper.wsGetCityList;

    var client = http.Client();

    try
    {
      print("Getting Cities List => "+ url);
      var uriResponse = await client.post(
          Uri.parse(url),
        body: {
            'state_code': stateCode
        }
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> citiesData = response['cities'];
          for (int i=0; i<citiesData.length; i++)
          {
            String cityId = citiesData[i]['id'] ?? "00";
            String cityName = citiesData[i]['city_name'] ?? "NA";

            listCities.add(BeanCity(cityId, cityName));
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listCities;
  }
}