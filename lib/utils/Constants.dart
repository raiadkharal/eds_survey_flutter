import '../data/models/outlet_request/LookUpDataObject.dart';

class Constants {
  static const homeButtonsPadding = 8.0;

  static const String NETWORK_ERROR = "No internet, Please try again later!";

  static const String GENERIC_ERROR =
      "Something went wrong, Please contact Manager!";
  static const String GENERIC_ERROR2 =
      "Something went wrong, Please try again!";
  static const String LOADED = "Loaded Successfully!";
  static String ERROR_DAY_NO_STARTED = "You have not even started your day";
  static const String PHONE_NUMBER_HELPER_TEXT = "923XXXXXXXXX";

  static const int MERCHANDISE_BEFORE_IMAGE = 0;
  static const int MERCHANDISE_AFTER_IMAGE = 1;

  static const int ENGRO_USER_ID = 2;

  static final valid = [ "","Yes", "No"];
  static final verify = ["","Yes", "No"];
  static final confirmation = ["","Yes", "No", "Sometimes", "Majority"];

  static final List<LookUpDataObject> competitorCooler = [
    LookUpDataObject(value: "Yes"),
    LookUpDataObject(value: "No")
  ];


  static final percentage = [
    "",
    "0-20%",
    "21-40%",
    "41-60%",
    "61-80%",
    "81-100%"
  ];
  static const int NEW_OUTLET_REQUEST_TYPE_ID = 4;
  static const int OUTLETS_REVERTED_WORKFLOW = 19;

  static final int NEW_OUTLET_REQUEST = 2 ;
  static final int SYNC_OUTLET_REQ = 5 ;

  static const int SUNDAY = 1;
  static const int MONDAY = 2;
  static const int TUESDAY = 3;
  static const int WEDNESDAY = 4;
  static const int THURSDAY = 5;
  static const int FRIDAY = 6;
  static const int SATURDAY = 7;
}
