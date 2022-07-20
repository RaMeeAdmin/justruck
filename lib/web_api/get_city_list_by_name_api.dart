import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_city.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';

class GetCityListByNameAPI
{
  static Future<List<BeanCity>> getCityListForMatchingPattern(String pattern) async
  {
    List<BeanCity> listCities = List.empty(growable: true);
    listCities.clear();

    String url = URLHelper.wsGetCityListByName;

    var client = http.Client();

    try
    {
      print("Getting Cities List By Name => "+ url);
      var uriResponse = await client.post(
          Uri.parse(url),
        body: {
            'city_name': pattern
        }
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> citiesData = response['city_list'];
          for (int i=0; i<citiesData.length; i++)
          {
            String cityId = citiesData[i]['id'] ?? "00";
            String cityName = citiesData[i]['city_name'] ?? "NA";
            String pinCode = citiesData[i]['pincode'] ?? "NA";
            String districtName = citiesData[i]['district_name'] ?? "NA";
            String stateName = citiesData[i]['state_name'] ?? "NA";
            String stateCode = citiesData[i]['state_code'] ?? "NA";
            String countryName = citiesData[i]['country_name'] ?? "NA";

            BeanCity cityDetails = BeanCity(cityId, cityName);
            cityDetails.pinCode = pinCode;
            cityDetails.districtName = districtName;
            cityDetails.stateName = stateName;
            cityDetails.stateCode = stateCode;
            cityDetails.countryName = countryName;

            listCities.add(cityDetails);
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