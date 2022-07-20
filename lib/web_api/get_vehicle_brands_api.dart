import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_vehicle_brand.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';

class GetVehicleBrandsAPI
{
  static Future<List<BeanVehicleBrand>> retrieveVehicleBrandsList() async
  {
    List<BeanVehicleBrand> listBrands = List.empty(growable: true);

    listBrands.clear();

    String url = URLHelper.wsGetVehicleBrands;

    var client = http.Client();

    try
    {
      print("Getting Vehicle Brands => "+ url);

      var uriResponse = await client.get(
          Uri.parse(url),
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> insProvidersData = response['vehicle_brand'];
          for (int i=0; i<insProvidersData.length; i++)
          {
            String brandId = insProvidersData[i]['id'] ?? "00";
            String brandName = insProvidersData[i]['name'] ?? "NA";
            String displayName = insProvidersData[i]['display_name'] ?? "NA";

            listBrands.add(BeanVehicleBrand(brandId, brandName, displayName));
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listBrands;
  }
}