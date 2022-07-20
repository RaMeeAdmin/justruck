import 'package:justruck/other/strings.dart';

class BeanInsuranceProvider
{
  String _providerId = "", _providerName = "", _displayName = "";


  BeanInsuranceProvider(this._providerId, this._providerName, this._displayName);

  get providerName => _providerName;

  set providerName(value) {
    _providerName = value;
  }

  String get providerId => _providerId;

  set providerId(String value) {
    _providerId = value;
  }

  get displayName => _displayName;

  set displayName(value) {
    _displayName = value;
  }

  static List<BeanInsuranceProvider> getDefaultInsuranceProviders()
  {
    List<BeanInsuranceProvider> _listInsuranceProvider = List.empty(growable: true);

    _listInsuranceProvider.add(BeanInsuranceProvider("0", Strings.selectInsuranceProvider, Strings.selectInsuranceProvider+" *"));

    return _listInsuranceProvider;
  }
}