class CommonConstants
{
  static String androidAppVersion = "1.2";
  static String iOSAppVersion = "1.2";

  static const int codeSuccess = 200;
  static const int codeNotFound = 404;
  static const int codeUnauthorized = 401;
  static const double progressBarWidth = 4;

  static const double cgstPercentage = 9;
  static const double sgstPercentage = 9;

  static String success = "success";
  static String message = "message";

  static List loginAs = ["Transporter", "Trucker", "Driver"];
  static String typeSuperAdmin = "1";
  static String typeJtStaff = "2";
  static String typeTrucker = "3";
  static String typeTransporter = "4";
  static String typeDriver = "5";

  static List bookingType = ["Single", "Bulk"];
  static String bookingTypeSingle = "1";
  static String bookingTypeBulk = "2";

  static List yesNo = ["Yes", "No"];
  static String yes = "Y";
  static String no = "N";

  static String payStatusPaid = "P";
  static String payStatusToPay = "T";

  static String statusBooked = "booked";
  static String statusInTransit = "intransit";
  static String statusScanned = "scanned";
  static String statusReceived = "received";
  static String statusDelivered = "delivered";

  static String bookedParcelList = "booked";
  static String receivingParcelList = "receiving";

  static String inTransitMessage = "Parcel was made In-Transit";
  static String scannedMessage = "Parcel was Scanned";
  static String receivedMessage = "Parcel arrived at";

  static String companyTypeIndividual = "1";
  static String companyTypeSoleProprietorship = "2";
  static String companyTypePartnershipCompany = "3";
  static String companyTypeLLP = "4";
  static String companyTypePrivateLimited = "5";
  static String companyTypePublicLimited = "6";

  static List routeType = ["Open", "Point to Point"];
  static String routeTypeOpen = "1";
  static String routeTypePointToPoint = "2";

  static String payModeCash = "Cash";
  static String payModeCard = "Card";
  static String payModeUPI = "UPI";
  static String payModeCredit = "Credit";

  static String customerTypeIndividual = "Individual";
  static String customerTypeFirm = "Firm";
}