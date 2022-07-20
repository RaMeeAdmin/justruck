import 'package:flutter/material.dart';
import 'package:justruck/beans/bean_language.dart';
import 'package:justruck/customWidgets/common_widgets.dart';
import 'package:justruck/generated/l10n.dart';
import 'package:justruck/other/preference_helper.dart';
import 'package:justruck/other/strings.dart';
import 'package:provider/src/provider.dart';

import 'LanguageChangeProvider.dart';

class ChangeLanguageScreen extends StatefulWidget
{
  _ChangeLanguageScreen createState() => _ChangeLanguageScreen();
}

class _ChangeLanguageScreen extends State<ChangeLanguageScreen>
{
  List<BeanLanguage> _listLanguages = List.empty(growable: true);

  @override
  void initState()
  {
    _listLanguages = BeanLanguage.getAppLanguages();
    _setPreviouslySelectedLanguage();
  }

  _setPreviouslySelectedLanguage() async
  {
    String locale = await PreferenceHelper.getAppLanguage();

    int index = 0;
    for(int i=0; i < _listLanguages.length; i++)
    {
      if(_listLanguages[i].code.toLowerCase() == locale.toLowerCase())
      {
        index = i;
        break;
      }
    }

    setState(() {
      _listLanguages[index].isSelected = true;
    });
  }

  Future<bool> _onWillPop()
  {
    Navigator.of(context).pop();
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context)
  {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).changeLanguage)),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgets.getH3NormalText(S.of(context).choosePreferredLanguage, Colors.black),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: _buildChangeLanguageList(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangeLanguageList()
  {
    var _languageList = ListView.builder(
      shrinkWrap: true,
      itemCount: _listLanguages.length,
      itemBuilder: (context, index)
      {
        return GestureDetector(
          child: Card(
            margin: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
            clipBehavior: Clip.hardEdge,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                      child: CommonWidgets.getH2NormalText(_listLanguages[index].languageName, Colors.black)
                  ),
                  Visibility(
                      visible: _listLanguages[index].isSelected,
                      child: const Icon(Icons.done, color: Colors.green)
                  )
                ],
              ),
            ),
          ),
          onTap: ()
          {
            _setSelectedLanguage(index);
            PreferenceHelper.setAppLanguage(_listLanguages[index].code);
            context.read<LanguageChangeProvider>().changeLocale(_listLanguages[index].code);
          },
        );
      },
    );
    return _languageList;
  }

  _setSelectedLanguage(int index)
  {
    for(int i=0; i < _listLanguages.length; i++)
    {
      _listLanguages[i].isSelected = false;
    }

    setState(() {
      _listLanguages[index].isSelected = true;
    });

  }
}