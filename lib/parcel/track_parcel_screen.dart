import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/beans/bean_track_details.dart';
import 'package:justruck/beans/bean_track_response.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/common_functions.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/web_api/get_parcel_track_api.dart';

class TrackParcelScreen extends StatefulWidget
{
  _TrackParcelScreen createState() => _TrackParcelScreen();
}

class _TrackParcelScreen extends State<TrackParcelScreen>
{
  TextEditingController _controllerParcelNo = TextEditingController();
  bool _showList = false, _showNotFound = false, _showProgress = false;

  List<BeanTrackDetails> _listTrackDetails = List.empty(growable: true);
  BeanParcelDetails _parcelDetails = BeanParcelDetails.empty();

  @override
  void initState()
  {
    //_listTrackDetails = BeanTrackDetails.getDefaultTrackingDetails();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child : Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                              controller: _controllerParcelNo,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: S.of(context).parcelNumber,
                                counterText: "",
                                contentPadding: Style.getTextFieldContentPadding(),
                                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                              ),
                            )
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: ElevatedButton(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(S.of(context).viewDetails),
                              ),
                              onPressed: ()
                              {
                                if(_validate())
                                {
                                  _getParcelTrackingDetails(_controllerParcelNo.text.trim());
                                }
                              },
                            )
                        ),
                      ],
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Visibility(
                              visible: _showList,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top:5),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: Style.getSquareBorder(),
                                                padding: const EdgeInsets.all(2.0),
                                                child: CommonWidgets.getH3NormalText(S.of(context).sender, Colors.black, textAlign: TextAlign.center),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: Style.getSquareBorder(),
                                                padding: const EdgeInsets.all(2.0),
                                                child: CommonWidgets.getH3NormalText(S.of(context).receiver, Colors.black, textAlign: TextAlign.center),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: Style.getSquareBorder(),
                                                padding: const EdgeInsets.all(2.0),
                                                child: Column(
                                                  children: [
                                                    CommonWidgets.getH4NormalText(_parcelDetails.senderName, Colors.black),
                                                    CommonWidgets.getH4NormalText(_parcelDetails.senderMobile, darkGrey)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: Style.getSquareBorder(),
                                                padding: const EdgeInsets.all(2.0),
                                                child: Column(
                                                  children: [
                                                    CommonWidgets.getH4NormalText(_parcelDetails.receiverName, Colors.black),
                                                    CommonWidgets.getH4NormalText(_parcelDetails.receiverMobile, darkGrey)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: _buildTrackingDetailsList()
                                  ),
                                ],
                              )
                          ),
                          Center(
                            child: Visibility(
                              visible: _showProgress,
                              child: const CircularProgressIndicator(strokeWidth: CommonConstants.progressBarWidth),
                            ),
                          ),
                          Center(
                            child: CommonWidgets.getNoDetailsFoundWidget(_showNotFound, S.of(context).trackDetailsNotFound),
                          )
                        ],
                      ),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  _buildTrackingDetailsList()
  {
    var _parcelTrackingList = ListView.builder(
      shrinkWrap: true,
      itemCount: _listTrackDetails.length,
      itemBuilder: (context, index)
      {
        return Card(
          margin: const EdgeInsets.only(top: 5, left: 1, right: 1),
          clipBehavior: Clip.hardEdge,
          elevation: 2,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Row(
                          children:
                          [
                            CommonWidgets.getH4NormalText(
                                CommonFunctions.getFormattedDate(_listTrackDetails[index].date)+" \u2022 "+
                                    CommonFunctions.getTwelveHourTime(_listTrackDetails[index].time), Colors.grey
                            )
                          ],
                        ),
                        CommonWidgets.getH3NormalText(_listTrackDetails[index].description, Colors.black),
                        Container(
                            margin: const EdgeInsets.only(top: 1.0),
                            child: CommonWidgets.getH4NormalText(
                                _listTrackDetails[index].address.trim().isNotEmpty ?
                                _listTrackDetails[index].address : Strings.addressUnavailable,
                                Colors.grey)
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  color: Style.getColorByParcelStatus(_listTrackDetails[index].status),
                  padding: const EdgeInsets.all(5.0),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: CommonWidgets.getH4NormalText(
                      BeanParcelDetails.getParcelStatusString(_listTrackDetails[index].status), Colors.white,
                      textAlign: TextAlign.center
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return _parcelTrackingList;
  }

  _validate()
  {
    bool valid = true;

    if(_controllerParcelNo.text.trim().isEmpty)
    {
      valid = false;
      CommonWidgets.showToast(S.of(context).plzEnterParcelNo);
    }

    return valid;
  }

  _getParcelTrackingDetails(String parcelId) async
  {
    setState(() {
      _showProgress = true;
      _showNotFound = false;
      _showList = false;
    });

    BeanTrackResponse response = await GetParcelTrackAPI.getTrackingDetailsFor(parcelId);
    if(response.success)
    {
      if(response.listTrackDetails.isNotEmpty)
      {
        setState(()
        {
          _listTrackDetails = response.listTrackDetails;
          _showProgress = false;
          _showNotFound = false;
          _showList = true;
          _parcelDetails = response.parcelDetails;
        });
      }
    }
    else
    {
      setState(() {
        _showProgress = false;
        _showNotFound = true;
        _showList = false;
      });
    }
  }
}