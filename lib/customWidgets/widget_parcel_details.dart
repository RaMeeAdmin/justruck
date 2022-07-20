import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_parcel_item_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_functions.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';

class WidgetParcelDetails
{
  static Column getParcelDetailsLayout(BuildContext context, BeanParcelDetails parcelDetails)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: Column(
                  children: [
                    CommonWidgets.getH4NormalText(S.of(context).parcelNumber, gray),
                    CommonWidgets.getH4NormalText(parcelDetails.parcelId, Colors.black),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: Column(
                  children: [
                    CommonWidgets.getH4NormalText(S.of(context).receiptNumber, gray),
                    CommonWidgets.getH4NormalText(parcelDetails.receiptNumber, Colors.black),
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
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: Column(
                  children: [
                    CommonWidgets.getH4NormalText(S.of(context).date, gray),
                    CommonWidgets.getH4NormalText(CommonFunctions.getFormattedDate(parcelDetails.parcelBookingDate), Colors.black),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: Column(
                  children: [
                    CommonWidgets.getH4NormalText(S.of(context).from, gray, maxLines: 1),
                    CommonWidgets.getH4NormalText(parcelDetails.senderCityName, Colors.black, maxLines: 1),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: Column(
                  children: [
                    CommonWidgets.getH4NormalText(S.of(context).to, gray, maxLines: 1),
                    CommonWidgets.getH4NormalText(parcelDetails.receiverCityName, Colors.black, maxLines: 1),
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
            padding: const EdgeInsets.all(3.0),
            decoration: Style.getSquareBorder(),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgets.getH4NormalText(S.of(context).senderName+":", gray),
                    SizedBox(width: 5),
                    Expanded(
                      child: CommonWidgets.getH4NormalText(parcelDetails.senderName, Colors.black),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgets.getH4NormalText(S.of(context).mobileNumber+":", gray),
                    SizedBox(width: 5),
                    Expanded(
                      child: CommonWidgets.getH4NormalText(parcelDetails.senderMobile, Colors.black),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgets.getH4NormalText(S.of(context).address+":", gray),
                    SizedBox(width: 5),
                    Expanded(
                      child: CommonWidgets.getH4NormalText(parcelDetails.senderAddress, Colors.black),
                    )
                  ],
                ),
              ],
            )
        ),
        Container(
            padding: const EdgeInsets.all(3.0),
            decoration: Style.getSquareBorder(),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgets.getH4NormalText(S.of(context).receiverName+":", gray),
                    SizedBox(width: 5),
                    Expanded(
                      child: CommonWidgets.getH4NormalText(parcelDetails.receiverName, Colors.black),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgets.getH4NormalText(S.of(context).mobileNumber+":", gray),
                    SizedBox(width: 5),
                    Expanded(
                      child: CommonWidgets.getH4NormalText(parcelDetails.receiverMobile, Colors.black),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgets.getH4NormalText(S.of(context).address+":", gray),
                    SizedBox(width: 5),
                    Expanded(
                      child: CommonWidgets.getH4NormalText(parcelDetails.receiverAddress, Colors.black),
                    )
                  ],
                ),
              ],
            )
        ),
        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(3.0),
            decoration: Style.getSquareBorderWithFill(),
            child: CommonWidgets.getH4NormalText(S.of(context).parcelDetails, Colors.black)
        ),

        Row(
          children: [
            Expanded(
              flex: 14,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(S.of(context).description, Colors.black),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(S.of(context).qty, Colors.black),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(S.of(context).amt, Colors.black),
              ),
            ),
          ],
        ),
        Container(
          child: _buildParcelItemsList(parcelDetails.listParcelItems),
        ),


        Row(
          children: [
            Expanded(
              flex: 14,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(S.of(context).subTotal, Colors.black, textAlign: TextAlign.right),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(parcelDetails.parcelCharges, Colors.black),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 14,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(S.of(context).gst, Colors.black, textAlign: TextAlign.right),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(parcelDetails.totalGSTCharges, Colors.black),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 14,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(S.of(context).totalPayable, Colors.black, textAlign: TextAlign.right),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorderWithFill(fillColor: limeYellow),
                child: CommonWidgets.getH4NormalText(parcelDetails.totalAmount, Colors.black),
              ),
            )
          ],
        ),

        Row(
          children: [
            Expanded(
              flex: 14,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(S.of(context).parcelBookingType, Colors.black),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(BeanParcelDetails.getBookingTypeString(parcelDetails.parcelBookingType), Colors.black),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 14,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(S.of(context).paymentStatus, Colors.black),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(parcelDetails.paymentStatus, Colors.black),
              ),
            )
          ],
        ),


        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(3.0),
            decoration: Style.getSquareBorderWithFill(),
            child: CommonWidgets.getH4NormalText(S.of(context).receivingTransporter, Colors.black)
        ),
        Container(
            padding: const EdgeInsets.all(3.0),
            decoration: Style.getSquareBorder(),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CommonWidgets.getH4NormalText(parcelDetails.recievingTransporterName, Colors.black),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgets.getH4NormalText(S.of(context).address+":", gray),
                    SizedBox(width: 5),
                    Expanded(
                      child: CommonWidgets.getH4NormalText(parcelDetails.recievingTransporterAddress, Colors.black),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgets.getH4NormalText(S.of(context).doorStepDelivery+":", gray),
                    const SizedBox(width: 5),
                    Expanded(
                      child: parcelDetails.homeDeliveryRequired=="Y" ?
                      CommonWidgets.getH4NormalText(Strings.yes, Colors.black) :
                      CommonWidgets.getH4NormalText(Strings.no, Colors.black),
                    )
                  ],
                ),
              ],
            )
        ),
        Row(
          children: [
            Expanded(
              flex: 14,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(S.of(context).parcelStatus, Colors.black),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorderWithFill(fillColor: Style.getColorByParcelStatus(parcelDetails.parcelStatus)),
                child: CommonWidgets.getH4NormalText(BeanParcelDetails.getParcelStatusString(parcelDetails.parcelStatus), Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }

  static _buildParcelItemsList(List<BeanParcelItemDetails> listParcelItems)
  {
    var _parcelItemsList = ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listParcelItems.length,
      itemBuilder: (context, index)
      {
        return Row(
          children: [
            Expanded(
              flex: 14,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(listParcelItems[index].parcelDescription, Colors.black),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(listParcelItems[index].quantity, Colors.black),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: Style.getSquareBorder(),
                child: CommonWidgets.getH4NormalText(listParcelItems[index].amount, Colors.black),
              ),
            ),
          ],
        );
      },
    );
    return _parcelItemsList;
  }
}