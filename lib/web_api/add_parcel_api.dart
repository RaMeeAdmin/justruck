import 'dart:convert';

import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_response.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';
import 'package:http/http.dart' as http;

class AddParcelAPI
{
  static Future<BeanResponse> bookParcelDetails(BeanParcelDetails parcelDetails) async
  {
    BeanResponse _bookingResponse = BeanResponse(false, "", "");

    String url = URLHelper.wsAddParcelNew;
    print("Adding Parcel => "+url);

    var client = http.Client();

    try
    {

      List<Map> _materialInformation = List.empty(growable: true);

      for (int i=0; i<parcelDetails.listParcelItems.length; i++)
      {
        String itemDetails = jsonEncode({
          "item_code": '',
          "item_type": parcelDetails.listParcelItems[i].itemType,
          "description": parcelDetails.listParcelItems[i].parcelDescription,
          "weight": parcelDetails.listParcelItems[i].parcelWeight,
          "declared_value": parcelDetails.listParcelItems[i].declaredValue,
          "quantity": parcelDetails.listParcelItems[i].quantity,
          "length": parcelDetails.listParcelItems[i].length,
          "breadth": parcelDetails.listParcelItems[i].breadth,
          "height": parcelDetails.listParcelItems[i].height,
          "volume": parcelDetails.listParcelItems[i].volume,
          "amount": parcelDetails.listParcelItems[i].amount,
        });

        Map decoded = jsonDecode(itemDetails);
        _materialInformation.add(decoded);
      }

      print("Sub Total => "+parcelDetails.parcelCharges);
      print("Grand Total => "+parcelDetails.totalAmount);
      print("Total Declared Value => "+parcelDetails.totalDeclaredValue);
      print("Payment Mode => "+parcelDetails.paymentMode);


      List<Map> _paymentInformation  = List.empty(growable: true);
      for (int i=0; i<parcelDetails.listPaymentDetails.length; i++)
      {
        String payDetails = jsonEncode({
          "mode": parcelDetails.listPaymentDetails[i].id,
          "amount": parcelDetails.listPaymentDetails[i].value,
        });

        Map decoded = jsonDecode(payDetails);
        _paymentInformation.add(decoded);
      }

      String outerJson = jsonEncode({
        "parcel_booking_type": parcelDetails.parcelBookingType,
        "sender_name": parcelDetails.senderName,
        "sender_mobile": parcelDetails.senderMobile,
        "sender_address": parcelDetails.senderAddress,
        "sender_email": '',
        "sender_gstn": '',
        "receiver_name": parcelDetails.receiverName,
        "receiver_mobile": parcelDetails.receiverMobile,
        "receiver_address": parcelDetails.receiverAddress,
        "sender_city_id": parcelDetails.senderCityId,
        "receiver_city_id": parcelDetails.receiverCityId,
        "source_location": '',
        "destination_location": '',
        "total_parcel_wt": parcelDetails.totalWeight,
        "total_parcel_volume": parcelDetails.totalVolume,
        "insurance_required": parcelDetails.insuranceRequired,
        "insurance_id": parcelDetails.insuranceProviderId,
        "insurance_percentage": parcelDetails.insurancePercentage,
        "insurance_amount": parcelDetails.insuranceCharges,
        //"payment_status": parcelDetails.paymentStatus,
        "material_info": _materialInformation,
        "gst_amount": parcelDetails.totalGSTCharges,
        "homeDelivery": parcelDetails.homeDeliveryRequired,
        "receivingTransporterId": parcelDetails.receivingTransporterId,

        "sub_total": parcelDetails.parcelCharges,
        "grand_total": parcelDetails.totalAmount,
        "total_decleard_value": parcelDetails.totalDeclaredValue,
        //"payment_mode": parcelDetails.paymentMode,
        "paymentDetails": _paymentInformation,
        "amount_tendered": parcelDetails.tenderedAmount,
        "change_return": parcelDetails.changeReturn,
      });

      print(outerJson);

      String jwtToken = await PreferenceHelper.getJwtToken();
      Map<String, String> header = {
        "Content-Type":"application/json",
        "Authorization":"Bearer "+jwtToken
      };

      var uriResponse = await client.post(Uri.parse(url),
          headers: header,
          body: outerJson
      );

      print(uriResponse.body.toString());

      Map response = jsonDecode(uriResponse.body);
      if(response[CommonConstants.success]== true)
      {
        _bookingResponse.success = true;
        _bookingResponse.data = response['data'];

        _bookingResponse.value1 = response['recipt_url'];
        _bookingResponse.value2 = response['barcode_url'];
      }
      else
      {
        _bookingResponse.success = false;
      }
    }
    finally
    {
      client.close();
    }

    return _bookingResponse;
  }
}