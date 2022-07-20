import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_count_report.dart';
import 'package:justruck/beans/bean_date_time.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/common_functions.dart';
import 'package:justruck/web_api/get_statistics_data_api.dart';

class ReportsStatScreen extends StatefulWidget
{
  _ReportsStatScreen createState() => _ReportsStatScreen();
}

class _ReportsStatScreen extends State<ReportsStatScreen>
{
  bool _showProgress = false, _showReportLayout = false;
  BeanCountReport _countReport = BeanCountReport("", "");

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now().subtract(Duration(days: 6)),
    end: DateTime.now(),
  );


  @override
  void initState()
  {
    _getReportStats(
        CommonFunctions.getFormattedDateTime(dateRange.start).date,
        CommonFunctions.getFormattedDateTime(dateRange.end).date
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child : Column(
                    children:
                    [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    children: [
                                      Text(CommonFunctions.getFormattedDateTime(dateRange.start).readableDate),
                                      const SizedBox(width: 5),
                                      Text(S.of(context).to.toLowerCase(), style: const TextStyle(color: gray)),
                                      const SizedBox(width: 5),
                                      Text(CommonFunctions.getFormattedDateTime(dateRange.end).readableDate),
                                    ],
                                  ),
                                ),
                                Icon(Icons.date_range, color: primaryColor)
                              ],
                            ),
                          ),
                          onTap: () async
                          {
                            DateTimeRange? newDateRange = await pickDateRange();

                            if(newDateRange!=null)
                            {
                              setState(() {
                                dateRange = newDateRange;
                              });

                              _getReportStats(
                                  CommonFunctions.getFormattedDateTime(dateRange.start).date,
                                  CommonFunctions.getFormattedDateTime(dateRange.end).date
                              );
                            }
                          },
                        ),
                      ),

                      Visibility(
                          visible: _showReportLayout,
                          child: Column(
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      gradient: RadialGradient(
                                        center: Alignment.topLeft,
                                        radius: 1.5,
                                        colors: [violetLight, violet],
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            CommonWidgets.getH1NormalText(_countReport.totalParcelBooked, Colors.white),
                                            CommonWidgets.getH4NormalText(S.of(context).totalParcelsBooked, Colors.white),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 0.5,
                                        width: 150,
                                        color: Colors.white,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  CommonWidgets.getH1NormalText(_countReport.totalPaidBookings, Colors.white),
                                                  CommonWidgets.getH4NormalText(S.of(context).paidBookings, Colors.white),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 0.5,
                                            color: Colors.white,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  CommonWidgets.getH1NormalText(_countReport.totalToPayBookings, Colors.white),
                                                  CommonWidgets.getH4NormalText(S.of(context).toPayBookings, Colors.white),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      gradient: RadialGradient(
                                        center: Alignment.topRight,
                                        radius: 1.5,
                                        colors: [cyanLight, cyan],
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            CommonWidgets.getH1NormalText(_countReport.totalBookingAmount, Colors.white),
                                            CommonWidgets.getH4NormalText(S.of(context).totalBookingAmount, Colors.white),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 0.5,
                                        width: 150,
                                        color: Colors.white,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                                              child: Column(
                                                children: [
                                                  CommonWidgets.getH1NormalText(_countReport.cardPaymentAmount, Colors.white),
                                                  CommonWidgets.getH4NormalText(S.of(context).card, Colors.white),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 0.5,
                                            color: Colors.white,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  CommonWidgets.getH1NormalText(_countReport.cashPaymentAmount, Colors.white),
                                                  CommonWidgets.getH4NormalText(S.of(context).cash, Colors.white),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  CommonWidgets.getH1NormalText(_countReport.upiPaymentAmount, Colors.white),
                                                  CommonWidgets.getH4NormalText(S.of(context).upi, Colors.white),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 0.5,
                                            color: Colors.white,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  CommonWidgets.getH1NormalText(_countReport.creditPaymentAmount, Colors.white),
                                                  CommonWidgets.getH4NormalText(S.of(context).credit, Colors.white),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      gradient: RadialGradient(
                                        center: Alignment.topLeft,
                                        radius: 1.5,
                                        colors: [pinkLight, pink],
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            CommonWidgets.getH1NormalText(_countReport.totalParcelDelivered, Colors.white),
                                            CommonWidgets.getH4NormalText(S.of(context).parcelsDelivered, Colors.white),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    ],
                  )
              ),
            ),
            Center(
              child: Visibility(
                visible: _showProgress,
                child: const CircularProgressIndicator(strokeWidth: CommonConstants.progressBarWidth),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<DateTimeRange?> pickDateRange() async
  {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime.now().subtract(Duration(days: 90)),
      lastDate: DateTime.now(),
    );

    return newDateRange;
  }

  _getReportStats(String startDate, String endDate) async
  {
    setState(()
    {
      _showProgress = true;
      _showReportLayout = false;
    });

    BeanCountReport tempReport = await GetStatisticsDataAPI.getStatsData(startDate, endDate);

    setState(()
    {
      _countReport = tempReport;
      _showProgress = false;
      _showReportLayout = true;
    });
  }
}