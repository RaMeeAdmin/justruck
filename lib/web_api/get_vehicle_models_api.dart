import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_vehicle_model.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';

class GetVehicleModelsAPI
{
  static Future<List<BeanVehicleModel>> retrieveVehicleModelsList(String brandId) async
  {
    List<BeanVehicleModel> listModels = List.empty(growable: true);

    listModels.clear();

    String url = URLHelper.wsGetVehicleModels;

    var client = http.Client();

    try
    {
      print("Getting Vehicle Models => "+ url);

      var uriResponse = await client.post(
          Uri.parse(url),
          body: {
            'brand_id': brandId
        }
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> insProvidersData = response['vehicle_model'];
          for (int i=0; i<insProvidersData.length; i++)
          {
            String modelId = insProvidersData[i]['id'] ?? "00";
            String modelName = insProvidersData[i]['name'] ?? "NA";
            String displayName = insProvidersData[i]['display_name'] ?? "NA";
            String brandId = insProvidersData[i]['brand_id'] ?? "NA";

            listModels.add(BeanVehicleModel(modelId, modelName, displayName, brandId));
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listModels;
  }
}