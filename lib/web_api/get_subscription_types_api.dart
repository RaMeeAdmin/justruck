import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_subscription_type.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/url_helper.dart';

class GetSubscriptionTypesAPI
{
  static Future<List<BeanSubscriptionType>> getSubscriptionTypeList() async
  {
    List<BeanSubscriptionType> listSubscriptionTypes = List.empty(growable: true);
    listSubscriptionTypes.clear();

    String url = URLHelper.wsGetSubscriptionTypes;

    var client = http.Client();

    try
    {
      print("Getting Subscription Types => "+ url);
      var uriResponse = await client.get(Uri.parse(url));
      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          List<dynamic> subscriptionTypesData = response['subscription_types'];
          for (int i=0; i<subscriptionTypesData.length; i++)
          {
            int typeId = subscriptionTypesData[i]['id'] ?? 00;
            String typeName = subscriptionTypesData[i]['name'] ?? "NA";

            listSubscriptionTypes.add(BeanSubscriptionType(typeId.toString(), typeName));
          }
        }
      }
    }
    finally
    {
      client.close();
    }
    return listSubscriptionTypes;
  }
}