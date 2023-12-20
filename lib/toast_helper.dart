import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage(String message) {
  const backgroundColor = Colors.black87;
  Fluttertoast.showToast(
    msg: message,
    //message to show toast
    toastLength: Toast.LENGTH_LONG,
    //duration for message to show
    gravity: ToastGravity.BOTTOM,
    //where you want to show, top, bottom
    timeInSecForIosWeb: 3,
    //for iOS only
    backgroundColor: backgroundColor,
    //background Color for message
    textColor: Colors.white,
    //message text color
    fontSize: 16.0,
    //message font size
    webBgColor:
        'rgb(${backgroundColor.red},${backgroundColor.green},${backgroundColor.blue})',
  );
}
