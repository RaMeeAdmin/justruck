import 'package:justruck/other/strings.dart';

class BeanMaxLoad
{
  String _maxLoadId = "", _maxLoadValue = "";

  BeanMaxLoad(this._maxLoadId, this._maxLoadValue);

  String get maxLoadId => _maxLoadId;

  set maxLoadId(String value) {
    _maxLoadId = value;
  }

  get maxLoadValue => _maxLoadValue;

  set maxLoadValue(value) {
    _maxLoadValue = value;
  }

  static List<BeanMaxLoad> getDefaultLoads()
  {
    List<BeanMaxLoad> _listMaxLoads = List.empty(growable: true);

    _listMaxLoads.add(BeanMaxLoad("0", Strings.selectLoadValue+" *"));
    _listMaxLoads.add(BeanMaxLoad("1", "1 Ton"));
    _listMaxLoads.add(BeanMaxLoad("2", "2 Tons"));
    _listMaxLoads.add(BeanMaxLoad("3", "3 Tons"));
    _listMaxLoads.add(BeanMaxLoad("4", "4 Tons"));

    return _listMaxLoads;
  }
}