import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_company_type.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';

class GetCompanyTypesAPI
{
  static Future<List<BeanCompanyType>> getCompanyTypeList() async
  {
    List<BeanCompanyType> listCompanyTypes = List.empty(growable: true);
    listCompanyTypes.clear();

    String url = URLHelper.wsGetCompanyTypes;

    var client = http.Client();

    try
    {
      print("Getting Company Types => "+ url);
      var uriResponse = await client.get(Uri.parse(url));
      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> companyTypesData = response['company_types'];
          for (int i=0; i<companyTypesData.length; i++)
          {
            int typeId = companyTypesData[i]['id'] ?? 0;
            String typeName = companyTypesData[i]['name'] ?? "NA";

            listCompanyTypes.add(BeanCompanyType(typeId.toString(), typeName));
          }
        }
      }
    }
    finally
    {
      client.close();
    }

    return listCompanyTypes;
  }
}