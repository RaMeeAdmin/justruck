// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Choose Preferred Language`
  String get choosePreferredLanguage {
    return Intl.message(
      'Choose Preferred Language',
      name: 'choosePreferredLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `मराठी`
  String get marathi {
    return Intl.message(
      'मराठी',
      name: 'marathi',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Customers`
  String get customers {
    return Intl.message(
      'Customers',
      name: 'customers',
      desc: '',
      args: [],
    );
  }

  /// `Change PIN`
  String get changePin {
    return Intl.message(
      'Change PIN',
      name: 'changePin',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Hello There`
  String get helloThere {
    return Intl.message(
      'Hello There',
      name: 'helloThere',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get login {
    return Intl.message(
      'LOGIN',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Primary Mobile Number`
  String get primaryMobileNo {
    return Intl.message(
      'Primary Mobile Number',
      name: 'primaryMobileNo',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp Mobile Number`
  String get whatsAppMobileNo {
    return Intl.message(
      'WhatsApp Mobile Number',
      name: 'whatsAppMobileNo',
      desc: '',
      args: [],
    );
  }

  /// `PIN`
  String get pin {
    return Intl.message(
      'PIN',
      name: 'pin',
      desc: '',
      args: [],
    );
  }

  /// `Forgot PIN ?`
  String get forgotPin {
    return Intl.message(
      'Forgot PIN ?',
      name: 'forgotPin',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register As\nTransporter`
  String get registerAsTransporter {
    return Intl.message(
      'Register As\nTransporter',
      name: 'registerAsTransporter',
      desc: '',
      args: [],
    );
  }

  /// `Register As\nTrucker`
  String get registerAsTrucker {
    return Intl.message(
      'Register As\nTrucker',
      name: 'registerAsTrucker',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message(
      'OR',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Transporter Registration\nStep 1 of 2`
  String get transporterRegistrationStep1 {
    return Intl.message(
      'Transporter Registration\nStep 1 of 2',
      name: 'transporterRegistrationStep1',
      desc: '',
      args: [],
    );
  }

  /// `Transporter Registration\nStep 2 of 2`
  String get transporterRegistrationStep2 {
    return Intl.message(
      'Transporter Registration\nStep 2 of 2',
      name: 'transporterRegistrationStep2',
      desc: '',
      args: [],
    );
  }

  /// `Transporter Registration\nStep 3 of 3`
  String get transporterRegistrationStep3 {
    return Intl.message(
      'Transporter Registration\nStep 3 of 3',
      name: 'transporterRegistrationStep3',
      desc: '',
      args: [],
    );
  }

  /// `Trucker Registration\nStep 1 of 2`
  String get truckerRegistrationStep1 {
    return Intl.message(
      'Trucker Registration\nStep 1 of 2',
      name: 'truckerRegistrationStep1',
      desc: '',
      args: [],
    );
  }

  /// `Trucker Registration\nStep 2 of 2`
  String get truckerRegistrationStep2 {
    return Intl.message(
      'Trucker Registration\nStep 2 of 2',
      name: 'truckerRegistrationStep2',
      desc: '',
      args: [],
    );
  }

  /// `Trucker Registration\nStep 3 of 3`
  String get truckerRegistrationStep3 {
    return Intl.message(
      'Trucker Registration\nStep 3 of 3',
      name: 'truckerRegistrationStep3',
      desc: '',
      args: [],
    );
  }

  /// `Save & Continue`
  String get saveAndContinue {
    return Intl.message(
      'Save & Continue',
      name: 'saveAndContinue',
      desc: '',
      args: [],
    );
  }

  /// `Do you provide home delivery?`
  String get doYouProvideHomeDelivery {
    return Intl.message(
      'Do you provide home delivery?',
      name: 'doYouProvideHomeDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Do you provide insurance?`
  String get doYouProvideInsurance {
    return Intl.message(
      'Do you provide insurance?',
      name: 'doYouProvideInsurance',
      desc: '',
      args: [],
    );
  }

  /// `Is GST Registered?`
  String get isGSTRegistered {
    return Intl.message(
      'Is GST Registered?',
      name: 'isGSTRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get okay {
    return Intl.message(
      'Okay',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Search Another`
  String get searchAgain {
    return Intl.message(
      'Search Another',
      name: 'searchAgain',
      desc: '',
      args: [],
    );
  }

  /// `Submit Details`
  String get submitDetails {
    return Intl.message(
      'Submit Details',
      name: 'submitDetails',
      desc: '',
      args: [],
    );
  }

  /// `Transporter Type`
  String get transporterType {
    return Intl.message(
      'Transporter Type',
      name: 'transporterType',
      desc: '',
      args: [],
    );
  }

  /// `Select Transporter Type`
  String get selectTransporterType {
    return Intl.message(
      'Select Transporter Type',
      name: 'selectTransporterType',
      desc: '',
      args: [],
    );
  }

  /// `Individual`
  String get individual {
    return Intl.message(
      'Individual',
      name: 'individual',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get company {
    return Intl.message(
      'Company',
      name: 'company',
      desc: '',
      args: [],
    );
  }

  /// `Company Type`
  String get companyType {
    return Intl.message(
      'Company Type',
      name: 'companyType',
      desc: '',
      args: [],
    );
  }

  /// `Service Opted For`
  String get serviceOptedFor {
    return Intl.message(
      'Service Opted For',
      name: 'serviceOptedFor',
      desc: '',
      args: [],
    );
  }

  /// `Company / Individual Name`
  String get companyOrIndividualName {
    return Intl.message(
      'Company / Individual Name',
      name: 'companyOrIndividualName',
      desc: '',
      args: [],
    );
  }

  /// `Company Address`
  String get companyAddress {
    return Intl.message(
      'Company Address',
      name: 'companyAddress',
      desc: '',
      args: [],
    );
  }

  /// `Company State`
  String get companyState {
    return Intl.message(
      'Company State',
      name: 'companyState',
      desc: '',
      args: [],
    );
  }

  /// `Company City`
  String get companyCity {
    return Intl.message(
      'Company City',
      name: 'companyCity',
      desc: '',
      args: [],
    );
  }

  /// `Company PAN`
  String get companyPan {
    return Intl.message(
      'Company PAN',
      name: 'companyPan',
      desc: '',
      args: [],
    );
  }

  /// `Company Email Id`
  String get companyEmailId {
    return Intl.message(
      'Company Email Id',
      name: 'companyEmailId',
      desc: '',
      args: [],
    );
  }

  /// `Individual PAN`
  String get pan {
    return Intl.message(
      'Individual PAN',
      name: 'pan',
      desc: '',
      args: [],
    );
  }

  /// `Company GSTIN`
  String get companyGstin {
    return Intl.message(
      'Company GSTIN',
      name: 'companyGstin',
      desc: '',
      args: [],
    );
  }

  /// `GSTIN`
  String get gstin {
    return Intl.message(
      'GSTIN',
      name: 'gstin',
      desc: '',
      args: [],
    );
  }

  /// `Primary Contact Details`
  String get primaryContactDetails {
    return Intl.message(
      'Primary Contact Details',
      name: 'primaryContactDetails',
      desc: '',
      args: [],
    );
  }

  /// `Contact Details`
  String get contactDetails {
    return Intl.message(
      'Contact Details',
      name: 'contactDetails',
      desc: '',
      args: [],
    );
  }

  /// `Add Another`
  String get addAnother {
    return Intl.message(
      'Add Another',
      name: 'addAnother',
      desc: '',
      args: [],
    );
  }

  /// `Contact Name`
  String get contactName {
    return Intl.message(
      'Contact Name',
      name: 'contactName',
      desc: '',
      args: [],
    );
  }

  /// `Contact Email`
  String get contactEmail {
    return Intl.message(
      'Contact Email',
      name: 'contactEmail',
      desc: '',
      args: [],
    );
  }

  /// `Contact Designation`
  String get contactDesignation {
    return Intl.message(
      'Contact Designation',
      name: 'contactDesignation',
      desc: '',
      args: [],
    );
  }

  /// `Individual Aadhar Number`
  String get individualAadhar {
    return Intl.message(
      'Individual Aadhar Number',
      name: 'individualAadhar',
      desc: '',
      args: [],
    );
  }

  /// `Is this primary contact?`
  String get isPrimaryContact {
    return Intl.message(
      'Is this primary contact?',
      name: 'isPrimaryContact',
      desc: '',
      args: [],
    );
  }

  /// `Set your 4 digit PIN`
  String get setPIN {
    return Intl.message(
      'Set your 4 digit PIN',
      name: 'setPIN',
      desc: '',
      args: [],
    );
  }

  /// `Banking Details`
  String get bankingDetails {
    return Intl.message(
      'Banking Details',
      name: 'bankingDetails',
      desc: '',
      args: [],
    );
  }

  /// `Bank Name`
  String get bankName {
    return Intl.message(
      'Bank Name',
      name: 'bankName',
      desc: '',
      args: [],
    );
  }

  /// `Branch Name`
  String get branchName {
    return Intl.message(
      'Branch Name',
      name: 'branchName',
      desc: '',
      args: [],
    );
  }

  /// `IFSC Code`
  String get ifsCode {
    return Intl.message(
      'IFSC Code',
      name: 'ifsCode',
      desc: '',
      args: [],
    );
  }

  /// `Account Number`
  String get accountNumber {
    return Intl.message(
      'Account Number',
      name: 'accountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Details`
  String get subscriptionDetails {
    return Intl.message(
      'Subscription Details',
      name: 'subscriptionDetails',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Type`
  String get subscriptionType {
    return Intl.message(
      'Subscription Type',
      name: 'subscriptionType',
      desc: '',
      args: [],
    );
  }

  /// `OTP पडताळणी`
  String get verifyOTP {
    return Intl.message(
      'OTP पडताळणी',
      name: 'verifyOTP',
      desc: '',
      args: [],
    );
  }

  /// `[mobile_number] या क्रमांकावर आलेला OTP एंटर करा.`
  String get enterVerificationCode {
    return Intl.message(
      '[mobile_number] या क्रमांकावर आलेला OTP एंटर करा.',
      name: 'enterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP`
  String get resendOTP {
    return Intl.message(
      'Resend OTP',
      name: 'resendOTP',
      desc: '',
      args: [],
    );
  }

  /// `OTP ची खात्री करा`
  String get confirmOTP {
    return Intl.message(
      'OTP ची खात्री करा',
      name: 'confirmOTP',
      desc: '',
      args: [],
    );
  }

  /// `Please complete the registration process.`
  String get regExitMessage {
    return Intl.message(
      'Please complete the registration process.',
      name: 'regExitMessage',
      desc: '',
      args: [],
    );
  }

  /// `Exit Anyway`
  String get exitAnyway {
    return Intl.message(
      'Exit Anyway',
      name: 'exitAnyway',
      desc: '',
      args: [],
    );
  }

  /// `Thank You`
  String get thankYou {
    return Intl.message(
      'Thank You',
      name: 'thankYou',
      desc: '',
      args: [],
    );
  }

  /// `for registering with us. You will be able to login after verification and approval.`
  String get thankYouMessage {
    return Intl.message(
      'for registering with us. You will be able to login after verification and approval.',
      name: 'thankYouMessage',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get backToLogin {
    return Intl.message(
      'Back to Login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `Parcel Booking`
  String get parcelBooking {
    return Intl.message(
      'Parcel Booking',
      name: 'parcelBooking',
      desc: '',
      args: [],
    );
  }

  /// `Parcel Booking Type`
  String get parcelBookingType {
    return Intl.message(
      'Parcel Booking Type',
      name: 'parcelBookingType',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Consignor Details`
  String get senderDetails {
    return Intl.message(
      'Consignor Details',
      name: 'senderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Consignee Details`
  String get receiverDetails {
    return Intl.message(
      'Consignee Details',
      name: 'receiverDetails',
      desc: '',
      args: [],
    );
  }

  /// `Search By Name / Mobile`
  String get searchByNameMobile {
    return Intl.message(
      'Search By Name / Mobile',
      name: 'searchByNameMobile',
      desc: '',
      args: [],
    );
  }

  /// `Consignor Name`
  String get senderName {
    return Intl.message(
      'Consignor Name',
      name: 'senderName',
      desc: '',
      args: [],
    );
  }

  /// `Alternate Mobile Number`
  String get alternateMobile {
    return Intl.message(
      'Alternate Mobile Number',
      name: 'alternateMobile',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Consignee Name`
  String get receiverName {
    return Intl.message(
      'Consignee Name',
      name: 'receiverName',
      desc: '',
      args: [],
    );
  }

  /// `Material Information`
  String get materialInformation {
    return Intl.message(
      'Material Information',
      name: 'materialInformation',
      desc: '',
      args: [],
    );
  }

  /// `Select City`
  String get selectCity {
    return Intl.message(
      'Select City',
      name: 'selectCity',
      desc: '',
      args: [],
    );
  }

  /// `Consignor's City`
  String get senderCity {
    return Intl.message(
      'Consignor\'s City',
      name: 'senderCity',
      desc: '',
      args: [],
    );
  }

  /// `Consignee's City`
  String get receiverCity {
    return Intl.message(
      'Consignee\'s City',
      name: 'receiverCity',
      desc: '',
      args: [],
    );
  }

  /// `Search By City Name`
  String get searchByCityName {
    return Intl.message(
      'Search By City Name',
      name: 'searchByCityName',
      desc: '',
      args: [],
    );
  }

  /// `Other Details`
  String get otherDetails {
    return Intl.message(
      'Other Details',
      name: 'otherDetails',
      desc: '',
      args: [],
    );
  }

  /// `Receiving Transporter`
  String get receivingTransporter {
    return Intl.message(
      'Receiving Transporter',
      name: 'receivingTransporter',
      desc: '',
      args: [],
    );
  }

  /// `Doorstep Delivery`
  String get doorStepDelivery {
    return Intl.message(
      'Doorstep Delivery',
      name: 'doorStepDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Doorstep Delivery Required?`
  String get doorStepDeliveryRequired {
    return Intl.message(
      'Doorstep Delivery Required?',
      name: 'doorStepDeliveryRequired',
      desc: '',
      args: [],
    );
  }

  /// `Provides door step delivery`
  String get providesDoorStepDelivery {
    return Intl.message(
      'Provides door step delivery',
      name: 'providesDoorStepDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Door step delivery unavailable`
  String get doorStepDeliveryUnavailable {
    return Intl.message(
      'Door step delivery unavailable',
      name: 'doorStepDeliveryUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Pick Receiver Transporter`
  String get pickReceiverTransporter {
    return Intl.message(
      'Pick Receiver Transporter',
      name: 'pickReceiverTransporter',
      desc: '',
      args: [],
    );
  }

  /// `Review Booking Details`
  String get reviewBookingDetails {
    return Intl.message(
      'Review Booking Details',
      name: 'reviewBookingDetails',
      desc: '',
      args: [],
    );
  }

  /// `Parcel Details`
  String get parcelDetails {
    return Intl.message(
      'Parcel Details',
      name: 'parcelDetails',
      desc: '',
      args: [],
    );
  }

  /// `Parcel Status`
  String get parcelStatus {
    return Intl.message(
      'Parcel Status',
      name: 'parcelStatus',
      desc: '',
      args: [],
    );
  }

  /// `Add Customer`
  String get addCustomer {
    return Intl.message(
      'Add Customer',
      name: 'addCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Add New`
  String get addNewCustomer {
    return Intl.message(
      'Add New',
      name: 'addNewCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Customer Type`
  String get customerType {
    return Intl.message(
      'Customer Type',
      name: 'customerType',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get save {
    return Intl.message(
      'save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Firm Name`
  String get firmName {
    return Intl.message(
      'Firm Name',
      name: 'firmName',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Middle Name`
  String get middleName {
    return Intl.message(
      'Middle Name',
      name: 'middleName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Contact Person First Name`
  String get contactPersonFirstName {
    return Intl.message(
      'Contact Person First Name',
      name: 'contactPersonFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Contact Person Last Name`
  String get contactPersonLastName {
    return Intl.message(
      'Contact Person Last Name',
      name: 'contactPersonLastName',
      desc: '',
      args: [],
    );
  }

  /// `Mobile No.`
  String get mobileNumber {
    return Intl.message(
      'Mobile No.',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Email ID`
  String get emailAddress {
    return Intl.message(
      'Email ID',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Company Address Line 1`
  String get companyAddressLine1 {
    return Intl.message(
      'Company Address Line 1',
      name: 'companyAddressLine1',
      desc: '',
      args: [],
    );
  }

  /// `Company Address Line 2`
  String get companyAddressLine2 {
    return Intl.message(
      'Company Address Line 2',
      name: 'companyAddressLine2',
      desc: '',
      args: [],
    );
  }

  /// `Address Line 1`
  String get addressLine1 {
    return Intl.message(
      'Address Line 1',
      name: 'addressLine1',
      desc: '',
      args: [],
    );
  }

  /// `Address Line 2`
  String get addressLine2 {
    return Intl.message(
      'Address Line 2',
      name: 'addressLine2',
      desc: '',
      args: [],
    );
  }

  /// `Nearby Landmark`
  String get nearbyLandmark {
    return Intl.message(
      'Nearby Landmark',
      name: 'nearbyLandmark',
      desc: '',
      args: [],
    );
  }

  /// `Pin Code`
  String get pinCode {
    return Intl.message(
      'Pin Code',
      name: 'pinCode',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get district {
    return Intl.message(
      'District',
      name: 'district',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Declared Value`
  String get declaredValue {
    return Intl.message(
      'Declared Value',
      name: 'declaredValue',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Amt.`
  String get amt {
    return Intl.message(
      'Amt.',
      name: 'amt',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Qty.`
  String get qty {
    return Intl.message(
      'Qty.',
      name: 'qty',
      desc: '',
      args: [],
    );
  }

  /// `Volume`
  String get volume {
    return Intl.message(
      'Volume',
      name: 'volume',
      desc: '',
      args: [],
    );
  }

  /// `Length`
  String get length {
    return Intl.message(
      'Length',
      name: 'length',
      desc: '',
      args: [],
    );
  }

  /// `Breadth`
  String get breadth {
    return Intl.message(
      'Breadth',
      name: 'breadth',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `(m)`
  String get inMeter {
    return Intl.message(
      '(m)',
      name: 'inMeter',
      desc: '',
      args: [],
    );
  }

  /// `Cubic Metre`
  String get cubicMetre {
    return Intl.message(
      'Cubic Metre',
      name: 'cubicMetre',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Insurance Required ?`
  String get insuranceRequired {
    return Intl.message(
      'Insurance Required ?',
      name: 'insuranceRequired',
      desc: '',
      args: [],
    );
  }

  /// `Insurance Percentage`
  String get insurancePercentage {
    return Intl.message(
      'Insurance Percentage',
      name: 'insurancePercentage',
      desc: '',
      args: [],
    );
  }

  /// `Insurance Charges`
  String get insuranceCharges {
    return Intl.message(
      'Insurance Charges',
      name: 'insuranceCharges',
      desc: '',
      args: [],
    );
  }

  /// `Sub Total`
  String get subTotal {
    return Intl.message(
      'Sub Total',
      name: 'subTotal',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Total Payable`
  String get totalPayable {
    return Intl.message(
      'Total Payable',
      name: 'totalPayable',
      desc: '',
      args: [],
    );
  }

  /// `Amount Tendered`
  String get amountTendered {
    return Intl.message(
      'Amount Tendered',
      name: 'amountTendered',
      desc: '',
      args: [],
    );
  }

  /// `Balance Amount`
  String get balanceAmount {
    return Intl.message(
      'Balance Amount',
      name: 'balanceAmount',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Change Return`
  String get changeReturn {
    return Intl.message(
      'Change Return',
      name: 'changeReturn',
      desc: '',
      args: [],
    );
  }

  /// `Payment Status`
  String get paymentStatus {
    return Intl.message(
      'Payment Status',
      name: 'paymentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Pending balance amount => [balance amount]`
  String get pendingBalanceMessage {
    return Intl.message(
      'Pending balance amount => [balance amount]',
      name: 'pendingBalanceMessage',
      desc: '',
      args: [],
    );
  }

  /// `Choose One From Below`
  String get chooseOneFromBelow {
    return Intl.message(
      'Choose One From Below',
      name: 'chooseOneFromBelow',
      desc: '',
      args: [],
    );
  }

  /// `Payment Mode`
  String get paymentMode {
    return Intl.message(
      'Payment Mode',
      name: 'paymentMode',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `UPI`
  String get upi {
    return Intl.message(
      'UPI',
      name: 'upi',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get card {
    return Intl.message(
      'Card',
      name: 'card',
      desc: '',
      args: [],
    );
  }

  /// `Credit`
  String get credit {
    return Intl.message(
      'Credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paid {
    return Intl.message(
      'Paid',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `To Pay`
  String get toPay {
    return Intl.message(
      'To Pay',
      name: 'toPay',
      desc: '',
      args: [],
    );
  }

  /// `Book Parcel`
  String get bookParcel {
    return Intl.message(
      'Book Parcel',
      name: 'bookParcel',
      desc: '',
      args: [],
    );
  }

  /// `Complete Booking`
  String get completeBooking {
    return Intl.message(
      'Complete Booking',
      name: 'completeBooking',
      desc: '',
      args: [],
    );
  }

  /// `Pay Now`
  String get payNow {
    return Intl.message(
      'Pay Now',
      name: 'payNow',
      desc: '',
      args: [],
    );
  }

  /// `Parcel Booked Successfully`
  String get bookedSuccess {
    return Intl.message(
      'Parcel Booked Successfully',
      name: 'bookedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Parcel List`
  String get parcelList {
    return Intl.message(
      'Parcel List',
      name: 'parcelList',
      desc: '',
      args: [],
    );
  }

  /// `Manifest`
  String get manifest {
    return Intl.message(
      'Manifest',
      name: 'manifest',
      desc: '',
      args: [],
    );
  }

  /// `Search Parcel`
  String get searchParcel {
    return Intl.message(
      'Search Parcel',
      name: 'searchParcel',
      desc: '',
      args: [],
    );
  }

  /// `Booked`
  String get booked {
    return Intl.message(
      'Booked',
      name: 'booked',
      desc: '',
      args: [],
    );
  }

  /// `In Transit`
  String get inTransit {
    return Intl.message(
      'In Transit',
      name: 'inTransit',
      desc: '',
      args: [],
    );
  }

  /// `Scanned`
  String get scanned {
    return Intl.message(
      'Scanned',
      name: 'scanned',
      desc: '',
      args: [],
    );
  }

  /// `Received`
  String get received {
    return Intl.message(
      'Received',
      name: 'received',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Booking Date`
  String get bookingDate {
    return Intl.message(
      'Booking Date',
      name: 'bookingDate',
      desc: '',
      args: [],
    );
  }

  /// `Routes`
  String get routes {
    return Intl.message(
      'Routes',
      name: 'routes',
      desc: '',
      args: [],
    );
  }

  /// `Vehicles`
  String get vehicles {
    return Intl.message(
      'Vehicles',
      name: 'vehicles',
      desc: '',
      args: [],
    );
  }

  /// `Drivers`
  String get drivers {
    return Intl.message(
      'Drivers',
      name: 'drivers',
      desc: '',
      args: [],
    );
  }

  /// `Add Route`
  String get addRoute {
    return Intl.message(
      'Add Route',
      name: 'addRoute',
      desc: '',
      args: [],
    );
  }

  /// `Booked Parcels`
  String get bookedParcels {
    return Intl.message(
      'Booked Parcels',
      name: 'bookedParcels',
      desc: '',
      args: [],
    );
  }

  /// `Receiving Parcels`
  String get receivingParcels {
    return Intl.message(
      'Receiving Parcels',
      name: 'receivingParcels',
      desc: '',
      args: [],
    );
  }

  /// `Route Name`
  String get routeName {
    return Intl.message(
      'Route Name',
      name: 'routeName',
      desc: '',
      args: [],
    );
  }

  /// `Start Location`
  String get startLocation {
    return Intl.message(
      'Start Location',
      name: 'startLocation',
      desc: '',
      args: [],
    );
  }

  /// `End Location`
  String get endLocation {
    return Intl.message(
      'End Location',
      name: 'endLocation',
      desc: '',
      args: [],
    );
  }

  /// `Radius in KM`
  String get radiusInKM {
    return Intl.message(
      'Radius in KM',
      name: 'radiusInKM',
      desc: '',
      args: [],
    );
  }

  /// `Intermediate Locations`
  String get intermediateLocations {
    return Intl.message(
      'Intermediate Locations',
      name: 'intermediateLocations',
      desc: '',
      args: [],
    );
  }

  /// `Estimated Travelling Time`
  String get estimatedTravelTime {
    return Intl.message(
      'Estimated Travelling Time',
      name: 'estimatedTravelTime',
      desc: '',
      args: [],
    );
  }

  /// `Estimated Time To Return Back`
  String get estimatedReturnTime {
    return Intl.message(
      'Estimated Time To Return Back',
      name: 'estimatedReturnTime',
      desc: '',
      args: [],
    );
  }

  /// `Distance in KM`
  String get distanceInKm {
    return Intl.message(
      'Distance in KM',
      name: 'distanceInKm',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Route Type`
  String get routeType {
    return Intl.message(
      'Route Type',
      name: 'routeType',
      desc: '',
      args: [],
    );
  }

  /// `Pick Location`
  String get pickLocation {
    return Intl.message(
      'Pick Location',
      name: 'pickLocation',
      desc: '',
      args: [],
    );
  }

  /// `Add Vehicle`
  String get addVehicle {
    return Intl.message(
      'Add Vehicle',
      name: 'addVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Add Driver`
  String get addDriver {
    return Intl.message(
      'Add Driver',
      name: 'addDriver',
      desc: '',
      args: [],
    );
  }

  /// `Select RTO`
  String get selectRTO {
    return Intl.message(
      'Select RTO',
      name: 'selectRTO',
      desc: '',
      args: [],
    );
  }

  /// `Part 2`
  String get part2 {
    return Intl.message(
      'Part 2',
      name: 'part2',
      desc: '',
      args: [],
    );
  }

  /// `e.g: GC`
  String get part2eg {
    return Intl.message(
      'e.g: GC',
      name: 'part2eg',
      desc: '',
      args: [],
    );
  }

  /// `Part 3`
  String get part3 {
    return Intl.message(
      'Part 3',
      name: 'part3',
      desc: '',
      args: [],
    );
  }

  /// `e.g: 1234`
  String get part3eg {
    return Intl.message(
      'e.g: 1234',
      name: 'part3eg',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Number`
  String get vehicleNumber {
    return Intl.message(
      'Vehicle Number',
      name: 'vehicleNumber',
      desc: '',
      args: [],
    );
  }

  /// `Chassis Number`
  String get chassisNumber {
    return Intl.message(
      'Chassis Number',
      name: 'chassisNumber',
      desc: '',
      args: [],
    );
  }

  /// `Insurance Provider`
  String get insuranceProvider {
    return Intl.message(
      'Insurance Provider',
      name: 'insuranceProvider',
      desc: '',
      args: [],
    );
  }

  /// `Insurance Number`
  String get insuranceNumber {
    return Intl.message(
      'Insurance Number',
      name: 'insuranceNumber',
      desc: '',
      args: [],
    );
  }

  /// `Insurance Valid From`
  String get insuranceValidFrom {
    return Intl.message(
      'Insurance Valid From',
      name: 'insuranceValidFrom',
      desc: '',
      args: [],
    );
  }

  /// `Insurance Valid Till`
  String get insuranceValidTill {
    return Intl.message(
      'Insurance Valid Till',
      name: 'insuranceValidTill',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message(
      'Brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Model`
  String get model {
    return Intl.message(
      'Model',
      name: 'model',
      desc: '',
      args: [],
    );
  }

  /// `Max Load Capacity`
  String get maxLoadCapacity {
    return Intl.message(
      'Max Load Capacity',
      name: 'maxLoadCapacity',
      desc: '',
      args: [],
    );
  }

  /// `Load Capacity`
  String get loadCapacity {
    return Intl.message(
      'Load Capacity',
      name: 'loadCapacity',
      desc: '',
      args: [],
    );
  }

  /// `Body Type`
  String get bodyType {
    return Intl.message(
      'Body Type',
      name: 'bodyType',
      desc: '',
      args: [],
    );
  }

  /// `Number of Tyres`
  String get numberOfTyres {
    return Intl.message(
      'Number of Tyres',
      name: 'numberOfTyres',
      desc: '',
      args: [],
    );
  }

  /// `Search By No. / Brand / Model / Load Capacity`
  String get vehicleSearchHint {
    return Intl.message(
      'Search By No. / Brand / Model / Load Capacity',
      name: 'vehicleSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Search By Route Name / Location`
  String get routeSearchHint {
    return Intl.message(
      'Search By Route Name / Location',
      name: 'routeSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Search By Driver Name / Mobile No.`
  String get driverSearchHint {
    return Intl.message(
      'Search By Driver Name / Mobile No.',
      name: 'driverSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Image`
  String get vehicleImage {
    return Intl.message(
      'Vehicle Image',
      name: 'vehicleImage',
      desc: '',
      args: [],
    );
  }

  /// `Insurance Copy`
  String get insuranceCopy {
    return Intl.message(
      'Insurance Copy',
      name: 'insuranceCopy',
      desc: '',
      args: [],
    );
  }

  /// `Storage LBH in Feet`
  String get storageLBH {
    return Intl.message(
      'Storage LBH in Feet',
      name: 'storageLBH',
      desc: '',
      args: [],
    );
  }

  /// `Select Insurance Provider`
  String get selectInsuranceProvider {
    return Intl.message(
      'Select Insurance Provider',
      name: 'selectInsuranceProvider',
      desc: '',
      args: [],
    );
  }

  /// `Select Vehicle Brand`
  String get selectVehicleBrand {
    return Intl.message(
      'Select Vehicle Brand',
      name: 'selectVehicleBrand',
      desc: '',
      args: [],
    );
  }

  /// `Select Vehicle Model`
  String get selectVehicleModel {
    return Intl.message(
      'Select Vehicle Model',
      name: 'selectVehicleModel',
      desc: '',
      args: [],
    );
  }

  /// `Select Max Load Value`
  String get selectLoadValue {
    return Intl.message(
      'Select Max Load Value',
      name: 'selectLoadValue',
      desc: '',
      args: [],
    );
  }

  /// `Select License Type`
  String get selectLicenseType {
    return Intl.message(
      'Select License Type',
      name: 'selectLicenseType',
      desc: '',
      args: [],
    );
  }

  /// `Select Route`
  String get selectRoute {
    return Intl.message(
      'Select Route',
      name: 'selectRoute',
      desc: '',
      args: [],
    );
  }

  /// `Pick Date`
  String get pickDate {
    return Intl.message(
      'Pick Date',
      name: 'pickDate',
      desc: '',
      args: [],
    );
  }

  /// `Select Driver`
  String get selectDriver {
    return Intl.message(
      'Select Driver',
      name: 'selectDriver',
      desc: '',
      args: [],
    );
  }

  /// `Trucker Name`
  String get truckerName {
    return Intl.message(
      'Trucker Name',
      name: 'truckerName',
      desc: '',
      args: [],
    );
  }

  /// `Driver Name`
  String get driverName {
    return Intl.message(
      'Driver Name',
      name: 'driverName',
      desc: '',
      args: [],
    );
  }

  /// `Driver Mobile`
  String get driverMobileNumber {
    return Intl.message(
      'Driver Mobile',
      name: 'driverMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Current Address`
  String get currentAddress {
    return Intl.message(
      'Current Address',
      name: 'currentAddress',
      desc: '',
      args: [],
    );
  }

  /// `Current Address Line 1`
  String get currentAddressLine1 {
    return Intl.message(
      'Current Address Line 1',
      name: 'currentAddressLine1',
      desc: '',
      args: [],
    );
  }

  /// `Current Address Line 2`
  String get currentAddressLine2 {
    return Intl.message(
      'Current Address Line 2',
      name: 'currentAddressLine2',
      desc: '',
      args: [],
    );
  }

  /// `Current City`
  String get currentCity {
    return Intl.message(
      'Current City',
      name: 'currentCity',
      desc: '',
      args: [],
    );
  }

  /// `Permanent Address`
  String get permanentAddress {
    return Intl.message(
      'Permanent Address',
      name: 'permanentAddress',
      desc: '',
      args: [],
    );
  }

  /// `Permanent Address Line 1`
  String get permanentAddressLine1 {
    return Intl.message(
      'Permanent Address Line 1',
      name: 'permanentAddressLine1',
      desc: '',
      args: [],
    );
  }

  /// `Permanent Address Line 2`
  String get permanentAddressLine2 {
    return Intl.message(
      'Permanent Address Line 2',
      name: 'permanentAddressLine2',
      desc: '',
      args: [],
    );
  }

  /// `Permanent City`
  String get permanentCity {
    return Intl.message(
      'Permanent City',
      name: 'permanentCity',
      desc: '',
      args: [],
    );
  }

  /// `Same as\nCurrent Address`
  String get sameAsCurrent {
    return Intl.message(
      'Same as\nCurrent Address',
      name: 'sameAsCurrent',
      desc: '',
      args: [],
    );
  }

  /// `Aadhar Number`
  String get aadharNumber {
    return Intl.message(
      'Aadhar Number',
      name: 'aadharNumber',
      desc: '',
      args: [],
    );
  }

  /// `License Type`
  String get licenseType {
    return Intl.message(
      'License Type',
      name: 'licenseType',
      desc: '',
      args: [],
    );
  }

  /// `Driving License Number`
  String get drivingLicenseNumber {
    return Intl.message(
      'Driving License Number',
      name: 'drivingLicenseNumber',
      desc: '',
      args: [],
    );
  }

  /// `License Expiry Date`
  String get licenseExpiryDate {
    return Intl.message(
      'License Expiry Date',
      name: 'licenseExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Driver Aadhar Image`
  String get driverAadharImage {
    return Intl.message(
      'Driver Aadhar Image',
      name: 'driverAadharImage',
      desc: '',
      args: [],
    );
  }

  /// `Driving License Image`
  String get driverLicenseImage {
    return Intl.message(
      'Driving License Image',
      name: 'driverLicenseImage',
      desc: '',
      args: [],
    );
  }

  /// `Driver Image`
  String get driverImage {
    return Intl.message(
      'Driver Image',
      name: 'driverImage',
      desc: '',
      args: [],
    );
  }

  /// `My Routes`
  String get myRoutes {
    return Intl.message(
      'My Routes',
      name: 'myRoutes',
      desc: '',
      args: [],
    );
  }

  /// `Search Route`
  String get searchRoute {
    return Intl.message(
      'Search Route',
      name: 'searchRoute',
      desc: '',
      args: [],
    );
  }

  /// `My Vehicles`
  String get myVehicles {
    return Intl.message(
      'My Vehicles',
      name: 'myVehicles',
      desc: '',
      args: [],
    );
  }

  /// `Search Vehicle`
  String get searchVehicle {
    return Intl.message(
      'Search Vehicle',
      name: 'searchVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Search Driver`
  String get searchDriver {
    return Intl.message(
      'Search Driver',
      name: 'searchDriver',
      desc: '',
      args: [],
    );
  }

  /// `Assign Driver`
  String get assignDriver {
    return Intl.message(
      'Assign Driver',
      name: 'assignDriver',
      desc: '',
      args: [],
    );
  }

  /// `Assigned Vehi.`
  String get assignedVehicle {
    return Intl.message(
      'Assigned Vehi.',
      name: 'assignedVehicle',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get neww {
    return Intl.message(
      'New',
      name: 'neww',
      desc: '',
      args: [],
    );
  }

  /// `Generate Manifest`
  String get generateManifest {
    return Intl.message(
      'Generate Manifest',
      name: 'generateManifest',
      desc: '',
      args: [],
    );
  }

  /// `Select Trucker`
  String get selectTrucker {
    return Intl.message(
      'Select Trucker',
      name: 'selectTrucker',
      desc: '',
      args: [],
    );
  }

  /// `Select Vehicle`
  String get selectVehicle {
    return Intl.message(
      'Select Vehicle',
      name: 'selectVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Manifest Date`
  String get manifestDate {
    return Intl.message(
      'Manifest Date',
      name: 'manifestDate',
      desc: '',
      args: [],
    );
  }

  /// `Old PIN`
  String get oldPin {
    return Intl.message(
      'Old PIN',
      name: 'oldPin',
      desc: '',
      args: [],
    );
  }

  /// `New PIN`
  String get newPin {
    return Intl.message(
      'New PIN',
      name: 'newPin',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New PIN`
  String get confirmPin {
    return Intl.message(
      'Confirm New PIN',
      name: 'confirmPin',
      desc: '',
      args: [],
    );
  }

  /// `Change My PIN`
  String get changeMyPin {
    return Intl.message(
      'Change My PIN',
      name: 'changeMyPin',
      desc: '',
      args: [],
    );
  }

  /// `Get PIN`
  String get getPin {
    return Intl.message(
      'Get PIN',
      name: 'getPin',
      desc: '',
      args: [],
    );
  }

  /// `Select All`
  String get selectAll {
    return Intl.message(
      'Select All',
      name: 'selectAll',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message(
      'Selected',
      name: 'selected',
      desc: '',
      args: [],
    );
  }

  /// `Track Parcel`
  String get trackParcel {
    return Intl.message(
      'Track Parcel',
      name: 'trackParcel',
      desc: '',
      args: [],
    );
  }

  /// `Parcel Number`
  String get parcelNumber {
    return Intl.message(
      'Parcel Number',
      name: 'parcelNumber',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Number`
  String get receiptNumber {
    return Intl.message(
      'Receipt Number',
      name: 'receiptNumber',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR`
  String get scanQR {
    return Intl.message(
      'Scan QR',
      name: 'scanQR',
      desc: '',
      args: [],
    );
  }

  /// `Unable to Scan?`
  String get unableToScan {
    return Intl.message(
      'Unable to Scan?',
      name: 'unableToScan',
      desc: '',
      args: [],
    );
  }

  /// `Search Here`
  String get searchHere {
    return Intl.message(
      'Search Here',
      name: 'searchHere',
      desc: '',
      args: [],
    );
  }

  /// `Proceed Delivery`
  String get proceedDelivery {
    return Intl.message(
      'Proceed Delivery',
      name: 'proceedDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Search By Parcel Id`
  String get searchByParcelId {
    return Intl.message(
      'Search By Parcel Id',
      name: 'searchByParcelId',
      desc: '',
      args: [],
    );
  }

  /// `Parcel Id`
  String get parcelId {
    return Intl.message(
      'Parcel Id',
      name: 'parcelId',
      desc: '',
      args: [],
    );
  }

  /// `Consignor`
  String get sender {
    return Intl.message(
      'Consignor',
      name: 'sender',
      desc: '',
      args: [],
    );
  }

  /// `Consignee`
  String get receiver {
    return Intl.message(
      'Consignee',
      name: 'receiver',
      desc: '',
      args: [],
    );
  }

  /// `Mark Received`
  String get markReceived {
    return Intl.message(
      'Mark Received',
      name: 'markReceived',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR Code pasted over parcel`
  String get scanQRCodeOnParcel {
    return Intl.message(
      'Scan QR Code pasted over parcel',
      name: 'scanQRCodeOnParcel',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations..!!\nYou have been successfully registered.`
  String get regSuccessMessage {
    return Intl.message(
      'Congratulations..!!\nYou have been successfully registered.',
      name: 'regSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Oopss..!!\nUnable to register. Mobile number you've entered might have already been registered`
  String get regFailedMessage {
    return Intl.message(
      'Oopss..!!\nUnable to register. Mobile number you\'ve entered might have already been registered',
      name: 'regFailedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get confirmation {
    return Intl.message(
      'Confirmation',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to logout ?`
  String get logoutMessage {
    return Intl.message(
      'Do you want to logout ?',
      name: 'logoutMessage',
      desc: '',
      args: [],
    );
  }

  /// `Yes, Logout`
  String get yesLogout {
    return Intl.message(
      'Yes, Logout',
      name: 'yesLogout',
      desc: '',
      args: [],
    );
  }

  /// `Want to exit from app ?`
  String get wantToExitApp {
    return Intl.message(
      'Want to exit from app ?',
      name: 'wantToExitApp',
      desc: '',
      args: [],
    );
  }

  /// `Yes, Exit`
  String get yesExit {
    return Intl.message(
      'Yes, Exit',
      name: 'yesExit',
      desc: '',
      args: [],
    );
  }

  /// `Route details not found`
  String get routeDetailsNotFound {
    return Intl.message(
      'Route details not found',
      name: 'routeDetailsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Driver details not found`
  String get driverDetailsNotFound {
    return Intl.message(
      'Driver details not found',
      name: 'driverDetailsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle details not found`
  String get vehicleDetailsNotFound {
    return Intl.message(
      'Vehicle details not found',
      name: 'vehicleDetailsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Manifest details not found`
  String get manifestDetailsNotFound {
    return Intl.message(
      'Manifest details not found',
      name: 'manifestDetailsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `No Parcel Details found`
  String get parcelDetailsNotFound {
    return Intl.message(
      'No Parcel Details found',
      name: 'parcelDetailsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `No Parcel Details found for selected route`
  String get parcelDetailsNotFoundForSelectedRoute {
    return Intl.message(
      'No Parcel Details found for selected route',
      name: 'parcelDetailsNotFoundForSelectedRoute',
      desc: '',
      args: [],
    );
  }

  /// `Customer Details Not Found`
  String get customerDetailsNotFound {
    return Intl.message(
      'Customer Details Not Found',
      name: 'customerDetailsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Transporter Details Not Found`
  String get transporterDetailsNotFound {
    return Intl.message(
      'Transporter Details Not Found',
      name: 'transporterDetailsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Parcel Tracking Details Not Found`
  String get trackDetailsNotFound {
    return Intl.message(
      'Parcel Tracking Details Not Found',
      name: 'trackDetailsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Result(s) Found`
  String get resultsFound {
    return Intl.message(
      'Result(s) Found',
      name: 'resultsFound',
      desc: '',
      args: [],
    );
  }

  /// `Combined Weight`
  String get combinedWeight {
    return Intl.message(
      'Combined Weight',
      name: 'combinedWeight',
      desc: '',
      args: [],
    );
  }

  /// `Combined Declared Value`
  String get combinedDeclaredValue {
    return Intl.message(
      'Combined Declared Value',
      name: 'combinedDeclaredValue',
      desc: '',
      args: [],
    );
  }

  /// `Parcel Charges`
  String get parcelCharges {
    return Intl.message(
      'Parcel Charges',
      name: 'parcelCharges',
      desc: '',
      args: [],
    );
  }

  /// `GST`
  String get gst {
    return Intl.message(
      'GST',
      name: 'gst',
      desc: '',
      args: [],
    );
  }

  /// `CGST`
  String get cgst {
    return Intl.message(
      'CGST',
      name: 'cgst',
      desc: '',
      args: [],
    );
  }

  /// `SGST`
  String get sgst {
    return Intl.message(
      'SGST',
      name: 'sgst',
      desc: '',
      args: [],
    );
  }

  /// `(if applicable)`
  String get ifApplicable {
    return Intl.message(
      '(if applicable)',
      name: 'ifApplicable',
      desc: '',
      args: [],
    );
  }

  /// `Manifest Details`
  String get manifestDetails {
    return Intl.message(
      'Manifest Details',
      name: 'manifestDetails',
      desc: '',
      args: [],
    );
  }

  /// `Manifest Id`
  String get manifestId {
    return Intl.message(
      'Manifest Id',
      name: 'manifestId',
      desc: '',
      args: [],
    );
  }

  /// `[count] Parcels on route`
  String get parcelsOnRoute {
    return Intl.message(
      '[count] Parcels on route',
      name: 'parcelsOnRoute',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Loading`
  String get confirmLoading {
    return Intl.message(
      'Confirm Loading',
      name: 'confirmLoading',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to remove Parcel No. [parcel_id] from Scanned List ?`
  String get removeFromScannedMessage {
    return Intl.message(
      'Do you want to remove Parcel No. [parcel_id] from Scanned List ?',
      name: 'removeFromScannedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to remove Parcel No. [parcel_id] from Manifest List ?`
  String get removeFromManifestMessage {
    return Intl.message(
      'Do you want to remove Parcel No. [parcel_id] from Manifest List ?',
      name: 'removeFromManifestMessage',
      desc: '',
      args: [],
    );
  }

  /// `Yes, Remove`
  String get yesRemove {
    return Intl.message(
      'Yes, Remove',
      name: 'yesRemove',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Parcel Delivery`
  String get parcelDelivery {
    return Intl.message(
      'Parcel Delivery',
      name: 'parcelDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Proof Of Delivery (POD)`
  String get proofOfDelivery {
    return Intl.message(
      'Proof Of Delivery (POD)',
      name: 'proofOfDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Receiver Signature`
  String get receiverSignature {
    return Intl.message(
      'Receiver Signature',
      name: 'receiverSignature',
      desc: '',
      args: [],
    );
  }

  /// `Receiver Photo`
  String get receiverPhoto {
    return Intl.message(
      'Receiver Photo',
      name: 'receiverPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Mark As Delivered`
  String get markDelivered {
    return Intl.message(
      'Mark As Delivered',
      name: 'markDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to mark this parcel as Delivered ?`
  String get deliveryConfirmationMessage {
    return Intl.message(
      'Do you want to mark this parcel as Delivered ?',
      name: 'deliveryConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `View / Print Receipt`
  String get viewPrintReceipt {
    return Intl.message(
      'View / Print Receipt',
      name: 'viewPrintReceipt',
      desc: '',
      args: [],
    );
  }

  /// `View / Print QR`
  String get viewPrintQR {
    return Intl.message(
      'View / Print QR',
      name: 'viewPrintQR',
      desc: '',
      args: [],
    );
  }

  /// `Print`
  String get print {
    return Intl.message(
      'Print',
      name: 'print',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Not Found`
  String get receiptNotFound {
    return Intl.message(
      'Receipt Not Found',
      name: 'receiptNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Address unavailable`
  String get addressUnavailable {
    return Intl.message(
      'Address unavailable',
      name: 'addressUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Location 1 -> Location 2 -> Location 3 -> Location 4 -> Location 5 -> Location 6`
  String get sampleIntermediateLocation {
    return Intl.message(
      'Location 1 -> Location 2 -> Location 3 -> Location 4 -> Location 5 -> Location 6',
      name: 'sampleIntermediateLocation',
      desc: '',
      args: [],
    );
  }

  /// `Sr. No 23, Near BMCC College, Agarkar Road, Apartment No. 133, Deccan Gymkhana, Shivajinagar, Pune 411023`
  String get sampleAddress {
    return Intl.message(
      'Sr. No 23, Near BMCC College, Agarkar Road, Apartment No. 133, Deccan Gymkhana, Shivajinagar, Pune 411023',
      name: 'sampleAddress',
      desc: '',
      args: [],
    );
  }

  /// `Total Parcels Booked`
  String get totalParcelsBooked {
    return Intl.message(
      'Total Parcels Booked',
      name: 'totalParcelsBooked',
      desc: '',
      args: [],
    );
  }

  /// `Paid Bookings`
  String get paidBookings {
    return Intl.message(
      'Paid Bookings',
      name: 'paidBookings',
      desc: '',
      args: [],
    );
  }

  /// `To Pay Bookings`
  String get toPayBookings {
    return Intl.message(
      'To Pay Bookings',
      name: 'toPayBookings',
      desc: '',
      args: [],
    );
  }

  /// `Total Booking Amount`
  String get totalBookingAmount {
    return Intl.message(
      'Total Booking Amount',
      name: 'totalBookingAmount',
      desc: '',
      args: [],
    );
  }

  /// `Parcels Delivered`
  String get parcelsDelivered {
    return Intl.message(
      'Parcels Delivered',
      name: 'parcelsDelivered',
      desc: '',
      args: [],
    );
  }

  /// `QR code can be printed from Android Devices only.`
  String get printAndroidOnlyMessage {
    return Intl.message(
      'QR code can be printed from Android Devices only.',
      name: 'printAndroidOnlyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Parcels in Booked status only can be added to manifest`
  String get bookedStatusOnly {
    return Intl.message(
      'Parcels in Booked status only can be added to manifest',
      name: 'bookedStatusOnly',
      desc: '',
      args: [],
    );
  }

  /// `Scanned Parcel is not listed in this manifest`
  String get notInManifest {
    return Intl.message(
      'Scanned Parcel is not listed in this manifest',
      name: 'notInManifest',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Common`
  String get common {
    return Intl.message(
      'Common',
      name: 'common',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Printer`
  String get printer {
    return Intl.message(
      'Printer',
      name: 'printer',
      desc: '',
      args: [],
    );
  }

  /// `Label Printer`
  String get labelPrinter {
    return Intl.message(
      'Label Printer',
      name: 'labelPrinter',
      desc: '',
      args: [],
    );
  }

  /// `Select Printer`
  String get selectPrinter {
    return Intl.message(
      'Select Printer',
      name: 'selectPrinter',
      desc: '',
      args: [],
    );
  }

  /// `Set`
  String get set {
    return Intl.message(
      'Set',
      name: 'set',
      desc: '',
      args: [],
    );
  }

  /// `No Paired Bluetooth Device Found`
  String get noPairedDeviceFound {
    return Intl.message(
      'No Paired Bluetooth Device Found',
      name: 'noPairedDeviceFound',
      desc: '',
      args: [],
    );
  }

  /// `No printer is Set.`
  String get noPrinterSet {
    return Intl.message(
      'No printer is Set.',
      name: 'noPrinterSet',
      desc: '',
      args: [],
    );
  }

  /// `Tap Here to Set Printer`
  String get tapToSet {
    return Intl.message(
      'Tap Here to Set Printer',
      name: 'tapToSet',
      desc: '',
      args: [],
    );
  }

  /// `Please select transporter Type`
  String get plzSelectTransporterType {
    return Intl.message(
      'Please select transporter Type',
      name: 'plzSelectTransporterType',
      desc: '',
      args: [],
    );
  }

  /// `Please select company type`
  String get plzSelectCompanyType {
    return Intl.message(
      'Please select company type',
      name: 'plzSelectCompanyType',
      desc: '',
      args: [],
    );
  }

  /// `Please select State`
  String get plzSelectState {
    return Intl.message(
      'Please select State',
      name: 'plzSelectState',
      desc: '',
      args: [],
    );
  }

  /// `Please select City`
  String get plzSelectCity {
    return Intl.message(
      'Please select City',
      name: 'plzSelectCity',
      desc: '',
      args: [],
    );
  }

  /// `Invalid PAN Number`
  String get invalidPanNo {
    return Intl.message(
      'Invalid PAN Number',
      name: 'invalidPanNo',
      desc: '',
      args: [],
    );
  }

  /// `Invalid GSTIN Number`
  String get invalidGstNo {
    return Intl.message(
      'Invalid GSTIN Number',
      name: 'invalidGstNo',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Mobile No.`
  String get plzEnterMobileNo {
    return Intl.message(
      'Please enter Mobile No.',
      name: 'plzEnterMobileNo',
      desc: '',
      args: [],
    );
  }

  /// `Please enter PIN`
  String get plzEnterPin {
    return Intl.message(
      'Please enter PIN',
      name: 'plzEnterPin',
      desc: '',
      args: [],
    );
  }

  /// `Pin must be 4 digit long`
  String get pinMustBeFourDigit {
    return Intl.message(
      'Pin must be 4 digit long',
      name: 'pinMustBeFourDigit',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Contact Name`
  String get plzEnterContactName {
    return Intl.message(
      'Please enter Contact Name',
      name: 'plzEnterContactName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Contact Email`
  String get plzEnterEmail {
    return Intl.message(
      'Please enter Contact Email',
      name: 'plzEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Contact Designation`
  String get plzEnterDesignation {
    return Intl.message(
      'Please enter Contact Designation',
      name: 'plzEnterDesignation',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Aadhar No`
  String get plzEnterAadharNo {
    return Intl.message(
      'Please enter Aadhar No',
      name: 'plzEnterAadharNo',
      desc: '',
      args: [],
    );
  }

  /// `Aadhar Number must be 12 digit long`
  String get plzEnterValidAadharNo {
    return Intl.message(
      'Aadhar Number must be 12 digit long',
      name: 'plzEnterValidAadharNo',
      desc: '',
      args: [],
    );
  }

  /// `Please set PIN`
  String get plzSetPin {
    return Intl.message(
      'Please set PIN',
      name: 'plzSetPin',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Bank Name`
  String get plzEnterBankName {
    return Intl.message(
      'Please enter Bank Name',
      name: 'plzEnterBankName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Branch Name`
  String get plzEnterBranchName {
    return Intl.message(
      'Please enter Branch Name',
      name: 'plzEnterBranchName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Account Number`
  String get plzEnterAccountNo {
    return Intl.message(
      'Please enter Account Number',
      name: 'plzEnterAccountNo',
      desc: '',
      args: [],
    );
  }

  /// `Please enter IFSC Code`
  String get plzEnterIFSCCode {
    return Intl.message(
      'Please enter IFSC Code',
      name: 'plzEnterIFSCCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Parcel Number`
  String get plzEnterParcelNo {
    return Intl.message(
      'Please enter Parcel Number',
      name: 'plzEnterParcelNo',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Old PIN`
  String get enterOldPin {
    return Intl.message(
      'Please enter Old PIN',
      name: 'enterOldPin',
      desc: '',
      args: [],
    );
  }

  /// `Please enter New PIN`
  String get enterNewPin {
    return Intl.message(
      'Please enter New PIN',
      name: 'enterNewPin',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Confirm New PIN`
  String get enterConfirmPin {
    return Intl.message(
      'Please enter Confirm New PIN',
      name: 'enterConfirmPin',
      desc: '',
      args: [],
    );
  }

  /// `New PIN and Confirmed PIN doesn't match`
  String get confirmPINDoesNotMatch {
    return Intl.message(
      'New PIN and Confirmed PIN doesn\'t match',
      name: 'confirmPINDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Name`
  String get plzEnterName {
    return Intl.message(
      'Please enter Name',
      name: 'plzEnterName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Address`
  String get plzEnterAddress {
    return Intl.message(
      'Please enter Address',
      name: 'plzEnterAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter PAN`
  String get plzEnterPAN {
    return Intl.message(
      'Please enter PAN',
      name: 'plzEnterPAN',
      desc: '',
      args: [],
    );
  }

  /// `Please enter GSTIN`
  String get plzEnterGSTIN {
    return Intl.message(
      'Please enter GSTIN',
      name: 'plzEnterGSTIN',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Mobile Number`
  String get invalidMobile {
    return Intl.message(
      'Invalid Mobile Number',
      name: 'invalidMobile',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email Id`
  String get invalidEmailId {
    return Intl.message(
      'Invalid Email Id',
      name: 'invalidEmailId',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Route Name`
  String get plzEnterRouteName {
    return Intl.message(
      'Please enter Route Name',
      name: 'plzEnterRouteName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Estimated Travel Time`
  String get plzEnterEstimateTravelTime {
    return Intl.message(
      'Please enter Estimated Travel Time',
      name: 'plzEnterEstimateTravelTime',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Estimated Time to return Back`
  String get plzEnterReturnTime {
    return Intl.message(
      'Please enter Estimated Time to return Back',
      name: 'plzEnterReturnTime',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Distance in KM`
  String get plzDistanceInKM {
    return Intl.message(
      'Please enter Distance in KM',
      name: 'plzDistanceInKM',
      desc: '',
      args: [],
    );
  }

  /// `Please select Consignor City`
  String get plzSelectSenderCity {
    return Intl.message(
      'Please select Consignor City',
      name: 'plzSelectSenderCity',
      desc: '',
      args: [],
    );
  }

  /// `Please select Consignee City`
  String get plzSelectReceiverCity {
    return Intl.message(
      'Please select Consignee City',
      name: 'plzSelectReceiverCity',
      desc: '',
      args: [],
    );
  }

  /// `Please add Consignor Details`
  String get plzAddSenderDetails {
    return Intl.message(
      'Please add Consignor Details',
      name: 'plzAddSenderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Consignor Name`
  String get plzAddSenderName {
    return Intl.message(
      'Please enter Consignor Name',
      name: 'plzAddSenderName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Consignor Mobile`
  String get plzAddSenderMobile {
    return Intl.message(
      'Please enter Consignor Mobile',
      name: 'plzAddSenderMobile',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Consignor Address`
  String get plzAddSenderAddress {
    return Intl.message(
      'Please enter Consignor Address',
      name: 'plzAddSenderAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please add Consignee Details`
  String get plzAddReceiverDetails {
    return Intl.message(
      'Please add Consignee Details',
      name: 'plzAddReceiverDetails',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Consignee Name`
  String get plzAddReceiverName {
    return Intl.message(
      'Please enter Consignee Name',
      name: 'plzAddReceiverName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Consignee Mobile`
  String get plzAddReceiverMobile {
    return Intl.message(
      'Please enter Consignee Mobile',
      name: 'plzAddReceiverMobile',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Consignee Address`
  String get plzAddReceiverAddress {
    return Intl.message(
      'Please enter Consignee Address',
      name: 'plzAddReceiverAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please select Route`
  String get plzSelectRoute {
    return Intl.message(
      'Please select Route',
      name: 'plzSelectRoute',
      desc: '',
      args: [],
    );
  }

  /// `Please select Vehicle`
  String get plzSelectVehicle {
    return Intl.message(
      'Please select Vehicle',
      name: 'plzSelectVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Parcel Item Type`
  String get plzSelectParcelItemType {
    return Intl.message(
      'Please Select Parcel Item Type',
      name: 'plzSelectParcelItemType',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Parcel Description`
  String get plzEnterParcelDescription {
    return Intl.message(
      'Please Enter Parcel Description',
      name: 'plzEnterParcelDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Declared Value`
  String get plzEnterDeclaredValue {
    return Intl.message(
      'Please Enter Declared Value',
      name: 'plzEnterDeclaredValue',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Weight`
  String get plzEnterWeight {
    return Intl.message(
      'Please Enter Weight',
      name: 'plzEnterWeight',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Quantity`
  String get plzEnterQuantity {
    return Intl.message(
      'Please Enter Quantity',
      name: 'plzEnterQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Amount`
  String get plzEnterAmount {
    return Intl.message(
      'Please Enter Amount',
      name: 'plzEnterAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Driver Name`
  String get plzEnterDriverName {
    return Intl.message(
      'Please Enter Driver Name',
      name: 'plzEnterDriverName',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Driver Mobile Number`
  String get plzEnterDriverMob {
    return Intl.message(
      'Please Enter Driver Mobile Number',
      name: 'plzEnterDriverMob',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Current Address Line 1`
  String get plzEnterCurrentAddressLine1 {
    return Intl.message(
      'Please Enter Current Address Line 1',
      name: 'plzEnterCurrentAddressLine1',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Current City`
  String get plzSelectCurrentCity {
    return Intl.message(
      'Please Select Current City',
      name: 'plzSelectCurrentCity',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Driver Aadhar Number`
  String get plzEnterDriverAadhar {
    return Intl.message(
      'Please Enter Driver Aadhar Number',
      name: 'plzEnterDriverAadhar',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Driver License Number`
  String get plzEnterDriverLicenseNo {
    return Intl.message(
      'Please Enter Driver License Number',
      name: 'plzEnterDriverLicenseNo',
      desc: '',
      args: [],
    );
  }

  /// `Please Select License Type`
  String get plzSelectLicenseType {
    return Intl.message(
      'Please Select License Type',
      name: 'plzSelectLicenseType',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter License Expiry Date`
  String get plzEnterLicenseExpDate {
    return Intl.message(
      'Please Enter License Expiry Date',
      name: 'plzEnterLicenseExpDate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Vehicle Number`
  String get plzEnterVehicleNo {
    return Intl.message(
      'Please enter Vehicle Number',
      name: 'plzEnterVehicleNo',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Chassis Number`
  String get plzEnterChassisNo {
    return Intl.message(
      'Please enter Chassis Number',
      name: 'plzEnterChassisNo',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Insurance Provider`
  String get plzSelectInsProvider {
    return Intl.message(
      'Please Select Insurance Provider',
      name: 'plzSelectInsProvider',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Insurance Number`
  String get plzEnterInsNumber {
    return Intl.message(
      'Please enter Insurance Number',
      name: 'plzEnterInsNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Insurance Valid From Date`
  String get plzSelectInsValidFromDate {
    return Intl.message(
      'Please Select Insurance Valid From Date',
      name: 'plzSelectInsValidFromDate',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Insurance Valid Till Date`
  String get plzSelectInsValidTillDate {
    return Intl.message(
      'Please Select Insurance Valid Till Date',
      name: 'plzSelectInsValidTillDate',
      desc: '',
      args: [],
    );
  }

  /// `Please Select vehicle brand`
  String get plzSelectVehicleBrand {
    return Intl.message(
      'Please Select vehicle brand',
      name: 'plzSelectVehicleBrand',
      desc: '',
      args: [],
    );
  }

  /// `Please Select vehicle model`
  String get plzSelectVehicleModel {
    return Intl.message(
      'Please Select vehicle model',
      name: 'plzSelectVehicleModel',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Max Load Value`
  String get plzSelectMaxLoadValue {
    return Intl.message(
      'Please Select Max Load Value',
      name: 'plzSelectMaxLoadValue',
      desc: '',
      args: [],
    );
  }

  /// `Please Select body type`
  String get plzSelectBodyType {
    return Intl.message(
      'Please Select body type',
      name: 'plzSelectBodyType',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter No of Tyres`
  String get plzEnterNoOfTyres {
    return Intl.message(
      'Please Enter No of Tyres',
      name: 'plzEnterNoOfTyres',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Driver to Assign`
  String get plzSelectDriverToAssign {
    return Intl.message(
      'Please Select Driver to Assign',
      name: 'plzSelectDriverToAssign',
      desc: '',
      args: [],
    );
  }

  /// `Please Scan QR Code pasted over parcel`
  String get plzScanQRCodeOnParcel {
    return Intl.message(
      'Please Scan QR Code pasted over parcel',
      name: 'plzScanQRCodeOnParcel',
      desc: '',
      args: [],
    );
  }

  /// `Please Add Signature`
  String get plzAddSignature {
    return Intl.message(
      'Please Add Signature',
      name: 'plzAddSignature',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Complete OTP`
  String get enterCompleteOTP {
    return Intl.message(
      'Please Enter Complete OTP',
      name: 'enterCompleteOTP',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter First Name`
  String get plzEnterFirstName {
    return Intl.message(
      'Please Enter First Name',
      name: 'plzEnterFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Last Name`
  String get plzEnterLastName {
    return Intl.message(
      'Please Enter Last Name',
      name: 'plzEnterLastName',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number must be 10 digit long`
  String get plzEnterValidMobileNo {
    return Intl.message(
      'Mobile Number must be 10 digit long',
      name: 'plzEnterValidMobileNo',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Payment Mode`
  String get plzSelectPaymentMode {
    return Intl.message(
      'Please Select Payment Mode',
      name: 'plzSelectPaymentMode',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Start Location`
  String get plzSelectStartLocation {
    return Intl.message(
      'Please Select Start Location',
      name: 'plzSelectStartLocation',
      desc: '',
      args: [],
    );
  }

  /// `Please Select End Location`
  String get plzSelectEndLocation {
    return Intl.message(
      'Please Select End Location',
      name: 'plzSelectEndLocation',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Radius`
  String get plzEnterRadius {
    return Intl.message(
      'Please Enter Radius',
      name: 'plzEnterRadius',
      desc: '',
      args: [],
    );
  }

  /// `Please Select RTO`
  String get plzSelectRTO {
    return Intl.message(
      'Please Select RTO',
      name: 'plzSelectRTO',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Length`
  String get plzEnterLength {
    return Intl.message(
      'Please Enter Length',
      name: 'plzEnterLength',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Breadth`
  String get plzEnterBreadth {
    return Intl.message(
      'Please Enter Breadth',
      name: 'plzEnterBreadth',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Height`
  String get plzEnterHeight {
    return Intl.message(
      'Please Enter Height',
      name: 'plzEnterHeight',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Tendered Amount`
  String get plzEnterTenderAmount {
    return Intl.message(
      'Please Enter Tendered Amount',
      name: 'plzEnterTenderAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please set the printer first`
  String get plzSetPrinter {
    return Intl.message(
      'Please set the printer first',
      name: 'plzSetPrinter',
      desc: '',
      args: [],
    );
  }

  /// `Parcel must have at least 1 material in it`
  String get mustHaveAtLeastOneItem {
    return Intl.message(
      'Parcel must have at least 1 material in it',
      name: 'mustHaveAtLeastOneItem',
      desc: '',
      args: [],
    );
  }

  /// `Please Select parcel to add in manifest`
  String get selectParcelToAddInManifest {
    return Intl.message(
      'Please Select parcel to add in manifest',
      name: 'selectParcelToAddInManifest',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'mr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
