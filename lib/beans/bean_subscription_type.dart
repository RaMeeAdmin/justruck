class BeanSubscriptionType
{
  String _subscriptionTypeId = "0", _subscriptionTypeName = "";

  BeanSubscriptionType(this._subscriptionTypeId, this._subscriptionTypeName);

  String get subscriptionTypeId => _subscriptionTypeId;

  set subscriptionTypeId(String value) {
    _subscriptionTypeId = value;
  }

  get subscriptionTypeName => _subscriptionTypeName;

  set subscriptionTypeName(value) {
    _subscriptionTypeName = value;
  }

  static List<BeanSubscriptionType> getDefaultTypes()
  {
    List<BeanSubscriptionType> types = List.empty(growable: true);

    types.add(BeanSubscriptionType("0", "Select Subscription Type"));
    /*types.add(BeanSubscriptionType("1", "Flat Rate – INR X Per Parcel Booking"));
    types.add(BeanSubscriptionType("2", "Percentage Basis – X% of the Parcel Charges"));
    types.add(BeanSubscriptionType("3", "Fixed Charges - INR X Per Month"));
    types.add(BeanSubscriptionType("4", "Slab based Charges – INR X as per Slab"));
    types.add(BeanSubscriptionType("5", "Free – Valid up to DD_MM_YYYY Date."));*/

    return types;
  }
}