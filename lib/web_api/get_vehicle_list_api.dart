import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_vehicle_details.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';

class GetVehicleListAPI
{
  static Future<List<BeanVehicleDetails>> getVehicleDetailsList() async
  {
    List<BeanVehicleDetails> listVehicles = List.empty(growable: true);
    listVehicles.clear();

    String url = URLHelper.wsListVehicles;

    var client = http.Client();

    try
    {
      print("Getting Vehicle List => "+ url);

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
            String vehicleId = citiesData[i]['id'] ?? "0";
            String vehicleNumber = citiesData[i]['vehicle_number'] ?? "NA";
            String vehicleBrand = citiesData[i]['brand_name'] ?? "NA";
            String vehicleModel = citiesData[i]['model_name'] ?? "NA";
            String loadCapacity = citiesData[i]['max_load_capacity'] ?? "NA";
            String vehicleImage = citiesData[i]['image'] ?? "NA";

            BeanVehicleDetails vehicleDetails = BeanVehicleDetails(vehicleId, vehicleNumber);
            vehicleDetails.vehicleBrandName = vehicleBrand;
            vehicleDetails.vehicleModelName = vehicleModel;
            vehicleDetails.loadCapacity = loadCapacity;
            vehicleDetails.vehicleImage = vehicleImage;

            listVehicles.add(vehicleDetails);
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listVehicles;
  }
}