import 'package:justruck/beans/bean_delivery_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';
import 'package:dio/dio.dart';

class ParcelDeliveryAPI
{
  static Future<bool> submitParcelDeliveryDetails(BeanDeliveryDetails deliveryDetails) async
  {
    bool deliveryDone = false;

    try
    {
      String url = URLHelper.wsParcelDelivery;
      print("Submitting Parcel Delivery Details => "+url);

      String jwtToken = await PreferenceHelper.getJwtToken();

      Map<String, String> header = {
        "Content-Type":"application/json",
        "Authorization":"Bearer "+jwtToken
      };

      FormData formData = FormData.fromMap({
        'parcel_id': deliveryDetails.parcelId,
        'receiver_name':deliveryDetails.receiverName,
        'receiver_mobile': deliveryDetails.receiverMobileNo,
        'latitude': deliveryDetails.latitude,
        'longitude': deliveryDetails.longitude,
        'last_location': deliveryDetails.address,
        'status': deliveryDetails.trackStatus,

        'receiver_photo': deliveryDetails.receiverImage.isEmpty ? '' : await MultipartFile.fromFile(deliveryDetails.receiverImage),
        'pod_image': deliveryDetails.podImage.isEmpty ? '' : await MultipartFile.fromFile(deliveryDetails.podImage),
        'singnature': deliveryDetails.signatureImage.isEmpty ? '' : await MultipartFile.fromFile(deliveryDetails.signatureImage)
      });


      Dio dio = Dio();
      dio.options.headers = header;
      Response uriResponse = await dio.post(url, data: formData);
      print("reponse => "+uriResponse.toString());

      var response = uriResponse.data;
      if(response[CommonConstants.success] == true)
      {
        deliveryDone = true;
      }
      else
      {
        deliveryDone = false;
        var message = response[CommonConstants.message];
        CommonWidgets.showToast(message);
      }
    }
    finally
    {

    }

    return deliveryDone;
  }
}