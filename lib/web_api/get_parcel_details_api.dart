import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_parcel_item_details.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';

class GetParcelDetailsAPI
{
  static Future<BeanParcelDetails> getParcelDetailsFor(String parcelId) async
  {
    BeanParcelDetails beanParcelDetails = BeanParcelDetails("0", "", "", "", "", "", "");

    String url = URLHelper.wsGetParcelDetails;

    var client = http.Client();

    try
    {
      print("Getting Parcel Details => "+ url);

      String jwtToken = await PreferenceHelper.getJwtToken();

      Map<String, String> header = {
        "Content-Type":"application/json",
        "Authorization":"Bearer "+jwtToken
      };

      var uriResponse = await client.post(Uri.parse(url),
          body: {
            'parcel_id': parcelId
          }
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          Map parcelData = response['data'];

          String id = parcelData['id'] ?? "";
          String receiptNo = parcelData['receiptNumber'] ?? "";

          String bookingDate = parcelData['booking_date'] ?? "";

          String parcelBookingType = parcelData['parcel_booking_type'] ?? "";
          String senderName = parcelData['from_cust_name'] ?? "";
          String senderMobile = parcelData['from_mobile_no'] ?? "";
          String senderCityId = parcelData['from_city_id'] ?? "";
          String senderCityName = parcelData['senderCityName'] ?? "";
          String senderAddress = parcelData['from_address'] ?? "";
          String receiverName = parcelData['to_cust_name'] ?? "";
          String receiverMobile = parcelData['to_mobile_no'] ?? "";
          String receiverCityId = parcelData['receiver_city_id'] ?? "";
          String receiverCityName = parcelData['receiverCityName'] ?? "";
          String receiverAddress = parcelData['to_address'] ?? "";

          String receivingTransporterId = parcelData['receivingTransporterId'] ?? "";
          String recievingTransporterAddress = parcelData['address'] ?? "";
          String recievingTransporterName = parcelData['name'] ?? "";
          String homeDeliveryRequired = parcelData['homeDelivery'] ?? "";
          String isRecieved = parcelData['isReceived'] ?? "";

          String receiptURL = parcelData['receipt_url'] ?? "";
          String qrCodeURL = parcelData['barcode_url'] ?? "";
          String parcelStatus = parcelData['parcelStatus'] ?? "";
          String payStatus = parcelData['payment_status'] ?? "";

          String subTotal = parcelData['sub_total'] ?? "";
          String gstAmount = parcelData['gst_amount'] ?? "";
          String payableAmount = parcelData['grand_total'] ?? "";
          String driverId = parcelData['driver_id'] ?? "";

          List<BeanParcelItemDetails> _listParcelItems = List.empty(growable: true);

          List<dynamic> parcelItemData = parcelData['parcel_iteam'];
          for (int i=0; i<parcelItemData.length; i++)
          {
            String itemType = parcelItemData[i]['item_type'] ?? "";
            String parcelDescription = parcelItemData[i]['description'] ?? "";
            String parcelWeight = parcelItemData[i]['weight'] ?? "";
            String declaredValue = parcelItemData[i]['declare_value'] ?? "";
            String quantity = parcelItemData[i]['quantity'] ?? "";
            String volume = parcelItemData[i]['volume'] ?? "";
            String length = parcelItemData[i]['length'] ?? "";
            String breadth = parcelItemData[i]['breadth'] ?? "";
            String height = parcelItemData[i]['height'] ?? "";
            String amount = parcelItemData[i]['amount'] ?? "";

            BeanParcelItemDetails itemDetails = BeanParcelItemDetails(itemType, parcelDescription, parcelWeight, declaredValue,
                quantity, volume, length, breadth, height, amount);
            _listParcelItems.add(itemDetails);
          }

          beanParcelDetails.parcelId = id;
          beanParcelDetails.receiptNumber = receiptNo;
          beanParcelDetails.parcelBookingDate = bookingDate;

          beanParcelDetails.parcelBookingType = parcelBookingType;
          beanParcelDetails.senderName = senderName;
          beanParcelDetails.senderMobile = senderMobile;
          beanParcelDetails.senderCityId = senderCityId;
          beanParcelDetails.senderCityName = senderCityName;
          beanParcelDetails.senderAddress = senderAddress;
          beanParcelDetails.receiverName = receiverName;
          beanParcelDetails.receiverMobile = receiverMobile;
          beanParcelDetails.receiverCityId = receiverCityId;
          beanParcelDetails.receiverCityName = receiverCityName;
          beanParcelDetails.receiverAddress = receiverAddress;

          beanParcelDetails.receivingTransporterId = receivingTransporterId;
          beanParcelDetails.recievingTransporterAddress = recievingTransporterAddress;
          beanParcelDetails.recievingTransporterName = recievingTransporterName;
          beanParcelDetails.homeDeliveryRequired = homeDeliveryRequired;
          beanParcelDetails.isReceived = isRecieved;

          beanParcelDetails.receiptURL = receiptURL;
          beanParcelDetails.qrCodeURL = qrCodeURL;
          beanParcelDetails.parcelStatus = parcelStatus;
          beanParcelDetails.paymentStatus = payStatus;

          beanParcelDetails.parcelCharges = subTotal;
          beanParcelDetails.totalGSTCharges = gstAmount;
          beanParcelDetails.totalAmount = payableAmount;
          beanParcelDetails.assignedDriverId = driverId;

          beanParcelDetails.listParcelItems = _listParcelItems;
        }
      }
      else
      {

      }
    }
    finally
    {
      client.close();
    }

    return beanParcelDetails;
  }
}