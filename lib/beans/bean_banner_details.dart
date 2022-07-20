class BeanBannerDetails
{
  String _bannerId = "", _imageURL = "";

  BeanBannerDetails(this._bannerId);

  String get bannerId => _bannerId;

  set bannerId(String value) {
    _bannerId = value;
  }

  get imageURL => _imageURL;

  set imageURL(value) {
    _imageURL = value;
  }

  static List<BeanBannerDetails> getDefaultBanners()
  {
    List<BeanBannerDetails> listBannerDetails = List.empty(growable: true);

    BeanBannerDetails b1 = new BeanBannerDetails("1");
    b1.imageURL = "https://media.istockphoto.com/photos/the-truck-runs-on-the-highway-with-speed-picture-id1249888857?k=20&m=1249888857&s=612x612&w=0&h=41-mwmzvm81zQbPjL9sSsMzyS6z700gUIbG9PUUXdNI=";

    BeanBannerDetails b2 = new BeanBannerDetails("2");
    b2.imageURL = "https://etimg.etb2bimg.com/photo/87713340.cms";

    BeanBannerDetails b3 = new BeanBannerDetails("2");
    b3.imageURL = "https://assets.volvo.com/is/image/VolvoInformationTechnologyAB/T2021_47293_smaller-1?wid=1024";

    BeanBannerDetails b4 = new BeanBannerDetails("2");
    b4.imageURL = "https://www.ttnews.com/sites/default/files/images/articles/itechseth-column.jpg";

    listBannerDetails.add(b1);
    listBannerDetails.add(b2);
    listBannerDetails.add(b3);
    listBannerDetails.add(b4);

    return listBannerDetails;
  }
}