class BeanServiceOpted
{
  String _serviceId = "0", _serviceName = "" ;

  BeanServiceOpted(this._serviceId, this._serviceName);

  String get serviceId => _serviceId;

  set serviceId(String value) {
    _serviceId = value;
  }

  get serviceName => _serviceName;

  set serviceName(value) {
    _serviceName = value;
  }

  static List<BeanServiceOpted> getDefaultTypes()
  {
    List<BeanServiceOpted> types = List.empty(growable: true);

    types.add(BeanServiceOpted("0", "Select Opted For"));
    types.add(BeanServiceOpted("1", "Service 1"));
    types.add(BeanServiceOpted("2", "Service 2"));
    types.add(BeanServiceOpted("3", "Service 3"));

    return types;
  }
}