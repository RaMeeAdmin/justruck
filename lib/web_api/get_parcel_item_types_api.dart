import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_item_type.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';

class GetParcelItemTypesAPI
{
  static Future<List<BeanItemType>> getParcelItemTypes() async
  {
    List<BeanItemType> listItemTypes = List.empty(growable: true);
    listItemTypes.clear();

    String url = URLHelper.wsGetItemTypes;

    var client = http.Client();

    try
    {
      print("Getting Parcel Item Types => "+ url);
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
          List<dynamic> itemTypesData = response['Item_type'];
          for (int i=0; i<itemTypesData.length; i++)
          {
            String id = itemTypesData[i]['id'] ?? "00";
            String name = itemTypesData[i]['name'] ?? "NA";

            listItemTypes.add(BeanItemType(id, name));
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listItemTypes;
  }
}