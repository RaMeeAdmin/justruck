import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_parcel_details.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/colors.dart';
import 'package:justruck/other/common_constants.dart';
import 'package:justruck/other/strings.dart';
import 'package:justruck/other/style.dart';
import 'package:justruck/parcel/parcel_details_screen.dart';
import 'package:justruck/web_api/get_parcel_list_api.dart';

class BookedParcelListScreen extends StatefulWidget
{
  final String status;
  const BookedParcelListScreen(this.status);
  _BookedParcelListScreen createState() => _BookedParcelListScreen();
}

class _BookedParcelListScreen extends State<BookedParcelListScreen> with AutomaticKeepAliveClientMixin<BookedParcelListScreen>
{
  bool _showProgress = false, _showNotFound = false;
  List<BeanParcelDetails> _listParcelDetailsAll = List.empty(growable: true);
  List<BeanParcelDetails> _listParcelDetailsFiltered = List.empty(growable: true);

  @override
  void initState()
  {
    //_listParcelDetails = BeanParcelDetails.getDefaultParcelList();
    _getParcelList();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context)
  {
    super.build(context); // need to call super method.
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: S.of(context).searchParcel,
                        counterText: "",
                        contentPadding: Style.getTextFieldContentPadding(),
                        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                      ),
                      onChanged: (String query)
                      {
                        List<BeanParcelDetails> _tempList = filterList(query);
                        setState(() {
                          _listParcelDetailsFiltered = _tempList;
                        });
                      },
                    ),
                  ),
                  Expanded(child: _buildParcelDetailsList()),
                ],
              ),
            ),
            Center(
              child: Visibility(
                visible: _showProgress,
                child: const CircularProgressIndicator(strokeWidth: CommonConstants.progressBarWidth),
              ),
            ),
            Center(
              child: CommonWidgets.getNoDetailsFoundWidget(_showNotFound, S.of(context).parcelDetailsNotFound),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildParcelDetailsList()
  {
    var _parcelDetailsList = ListView.builder(
        shrinkWrap: true,
        itemCount: _listParcelDetailsFiltered.length,
        itemBuilder: (context, index)
        {
          return GestureDetector(
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CommonWidgets.getH3NormalText(_listParcelDetailsFiltered[index].senderCityName, skyBlue)
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CommonWidgets.getH3NormalText(S.of(context).to, Colors.grey)
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CommonWidgets.getH3NormalText(_listParcelDetailsFiltered[index].receiverCityName, skyBlue)
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CommonWidgets.getH3NormalText("# "+_listParcelDetailsFiltered[index].parcelId, Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IntrinsicHeight(
                    child: Row(
                      children:
                      [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: CommonWidgets.getH3NormalText(S.of(context).from, Colors.grey)
                                  ),
                                  Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CommonWidgets.getH3NormalText(_listParcelDetailsFiltered[index].senderName, Colors.black)
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: CommonWidgets.getH3NormalText(S.of(context).to, Colors.grey)
                                  ),
                                  Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CommonWidgets.getH3NormalText(_listParcelDetailsFiltered[index].receiverName, Colors.black)
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: CommonWidgets.getH3NormalText(S.of(context).bookingDate, Colors.grey)
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: CommonWidgets.getH3NormalText(_listParcelDetailsFiltered[index].parcelBookingDate, Colors.black)
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        RotatedBox(
                            quarterTurns: 3,
                            child: Container(
                              width: double.infinity,
                              color: Style.getColorByParcelStatus(_listParcelDetailsFiltered[index].parcelStatus),
                              padding: const EdgeInsets.all(2.0),
                              child: CommonWidgets.getH4NormalText(
                                  BeanParcelDetails.getParcelStatusString(_listParcelDetailsFiltered[index].parcelStatus), Colors.white,
                                textAlign: TextAlign.center
                              ),
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ParcelDetailsScreen(_listParcelDetailsFiltered[index].parcelId))),
          );
        }
    );
    return _parcelDetailsList;
  }

  List<BeanParcelDetails> filterList(String pattern)
  {
    List<BeanParcelDetails> _tempList =  List.empty(growable: true);
    _tempList.clear();

    for(int i=0; i<_listParcelDetailsAll.length; i++)
    {
      if( _listParcelDetailsAll[i].senderCityName.toLowerCase().contains(pattern.toLowerCase()) ||
          _listParcelDetailsAll[i].receiverCityName.toLowerCase().contains(pattern.toLowerCase()) ||
          _listParcelDetailsAll[i].senderName.toLowerCase().contains(pattern.toLowerCase()) ||
          _listParcelDetailsAll[i].receiverName.toLowerCase().contains(pattern.toLowerCase()) )
      {
        _tempList.add(_listParcelDetailsAll[i]);
      }
    }

    return _tempList;
  }

  _getParcelList() async
  {
    setState(()
    {
      _showProgress = true;
      _showNotFound = false;
    });

    List<BeanParcelDetails> tempList = await GetParcelListAPI.retrieveParcelList(widget.status);

    setState(() { _showProgress = false; });

    if(tempList.length > 0)
    {
      setState(()
      {
        _listParcelDetailsAll = tempList;
        _listParcelDetailsFiltered = _listParcelDetailsAll;
        _showProgress = false;
      });
    }
    else
    {
      setState(()
      {
        _showProgress = false;
        _showNotFound = true;
      });
    }
  }
}