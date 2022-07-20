import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justruck/beans/bean_count_report.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/url_helper.dart';

class GetStatisticsDataAPI
{
  static Future<BeanCountReport> getStatsData(String fromDate, String toDate) async
  {
    BeanCountReport _beanCountReport = BeanCountReport(fromDate, toDate);

    String url = URLHelper.wsGetStatisticsData;

    var client = http.Client();

    try
    {
      print("Getting Counts for "+fromDate+" to "+toDate+" => "+ url);
      String jwtToken = await PreferenceHelper.getJwtToken();

      Map<String, String> header = {
        "Authorization":"Bearer "+jwtToken
      };

      var uriResponse = await client.post(Uri.parse(url),
          headers: header,
          body: {
            'fromDate': fromDate,
            'toDate': toDate,
          }
      );

      print('response: ${uriResponse.body}');

      int statusCode = uriResponse.statusCode;
      if(statusCode == CommonConstants.codeSuccess)
      {
        Map response = jsonDecode(uriResponse.body);
        if(response[CommonConstants.success] == true)
        {
          Map countData = response['data'];

          String totalParcelBooked = countData['total_parcel_booked'] ?? "-";
          String totalPaidBookings = countData['total_paid_bookings'] ?? "-";
          String totalToPayBookings = countData['to_pay_bookings'] ?? "-";
          String totalBookingAmount = countData['total_booking_amount'] ?? "-";
          String cardPaymentAmount = countData['card_payment_amount'] ?? "-";
          String cashPaymentAmount = countData['cash_payment_amount'] ?? "-";
          String upiPaymentAmount = countData['upi_payment_amount'] ?? "-";
          String creditPaymentAmount = countData['credit_payment_amout'] ?? "-";
          String totalParcelDelivered = countData['total_parcel_delivered'] ?? "-";

          _beanCountReport.totalParcelBooked = totalParcelBooked;
          _beanCountReport.totalPaidBookings = totalPaidBookings;
          _beanCountReport.totalToPayBookings = totalToPayBookings;
          _beanCountReport.totalBookingAmount = totalBookingAmount;
          _beanCountReport.cardPaymentAmount = cardPaymentAmount;
          _beanCountReport.cashPaymentAmount = cashPaymentAmount;
          _beanCountReport.upiPaymentAmount = upiPaymentAmount;
          _beanCountReport.creditPaymentAmount = creditPaymentAmount;
          _beanCountReport.totalParcelDelivered = totalParcelDelivered;
        }
        else
        {
          CommonWidgets.showToast(response[CommonConstants.message]);
        }
      }
    }
    finally
    {
      client.close();
    }

    return _beanCountReport;
  }
}