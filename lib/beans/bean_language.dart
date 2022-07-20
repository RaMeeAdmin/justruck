import 'package:justruck/other/strings.dart';

class BeanLanguage
{
  String _code = "", _languageName = "";
  bool _isSelected = false;

  BeanLanguage(this._code, this._languageName);

  String get code => _code;

  set code(String value) {
    _code = value;
  }

  get languageName => _languageName;

  set languageName(value) {
    _languageName = value;
  }

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }

  static List<BeanLanguage> getAppLanguages()
  {
    List<BeanLanguage> _listLanguages = List.empty(growable: true);

    BeanLanguage languageEnglish = BeanLanguage("en", Strings.english);
    languageEnglish.isSelected = false;
    _listLanguages.add(languageEnglish);

    BeanLanguage languageMarathi = BeanLanguage("mr", Strings.marathi);
    languageMarathi.isSelected = false;
    _listLanguages.add(languageMarathi);

    return _listLanguages;
  }
}