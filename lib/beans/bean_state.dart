class BeanState
{
  String _stateCode = "0", _stateName = "" ;

  BeanState(this._stateCode, this._stateName);

  get stateName => _stateName;

  set stateName(value) {
    _stateName = value;
  }

  String get stateCode => _stateCode;

  set stateCode(String value) {
    _stateCode = value;
  }

  static List<BeanState> getDefaultState()
  {
    List<BeanState> types = List.empty(growable: true);

    types.add(BeanState("0", "Select Company State"));

    return types;
  }
}