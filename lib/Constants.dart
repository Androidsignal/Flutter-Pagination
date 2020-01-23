import 'dart:io';

import 'package:flutter/material.dart';

class Constants {
  static String prefUserId = "";
  static String prefPassword = "";

  static bool checkPromoCode = false;

  //this is  for search screen to manage loading in subclass
//  static bool loadInSubClassOfSearch = false;
  static const String loginUserName = "loginUserName";
  static const String loginPassword = "loginpassword";
  static const String prefUserIdKeyInt = "UserId";
  static const String prefPasswordKey = "user_password";
  static const String prefUserNameKey = "user_name";

  static const String prefIsLoginSkippedKey = "isLoginSkipped";

  static const String prefAddressId = "mAddressId";
  static const String prefAddressName = "mAddressName";
  static const String prefAddressName1 = "mAddressName1";
  static const String prefCity = "city";

  static const String prefPlaceId = "placeId";
  static const String prefMainAddress = "mainAddress";
  static const String prefSecondAddress = "secondAddress";
  static const String prefAddress = "Address";
  static const String prefLatitude = "Latitude";
  static const String prefLongitude = "Longitude";

  static const int FOR_LOGIN = 2;

  static const int NORMAL_VALIDATION = 1;
  static const int EMAIL_VALIDATION = 2;
  static const int PHONE_VALIDATION = 3;
  static const int STRONG_PASSWORD_VALIDATION = 4;
  static const int PHONE_OR_EMAIL_VALIDATION = 5;

  static const int SEND_OTP_FROM_FORGOT_PASSWORD = 1;
  static const int SEND_OTP_FROM_CREATE_ACCOUNT = 2;
  static const int SEND_OTP_FROM_SING_IN = 4;
  static const int SEND_OTP_FROM_PROFILE = 3;

  static String latitude = "";
  static String longitude = "";
  static String otpCode = "";
  static int otpLength = 4;

  static const int CREATE_PASSWORD = 0;
  static const int RESET_PASSWORD = 1;
  static const int CHANGE_PASSWORD = 2;

  static const int OTP_PAGE = 10;
  static const int MY_ADDRESS = 11;
  static const int EDIT_ADDRESS = 12;
  static const int HOME_PAGE = 13;

  static bool isAddress = false;

  static Future<bool> isInternetAvailable() async {
    try {
      /*var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        return true;
      }*/

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static progressDialog(bool isLoading, BuildContext context) {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
          height: 40.0,
          child: new Center(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                new Text("Please wait")
              ],
            ),
          )),
      contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
    );
    if (!isLoading) {
      Navigator.of(context).pop();
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return dialog;
          });
    }
  }

  static resultInApi(var value, var isError) {
    Map<String, dynamic> map = {"isError": isError, "value": value};
    return map;
  }

  static bool isValidPhone(String phone) {
    bool isPhone = false;
    RegExp exp = new RegExp('^[0-9]{10}\$');
    Iterable<Match> matches = exp.allMatches(phone);
    for (Match m in matches) {
      m.group(0);
      isPhone = true;
    }
    return isPhone;
  }

  static bool isValidEmail(String email) {
    bool isEmail = false;
    RegExp exp = new RegExp("[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+");
    Iterable<Match> matches = exp.allMatches(email);
    for (Match m in matches) {
      m.group(0);
      isEmail = true;
    }
    return isEmail;
  }
}
