import 'package:flutter/material.dart';

class ShowSnackBar {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(
      {required String text,
        Color? snackBarBackgroundColor,
      Color? textColor,
      double? fontSize,
      FontWeight? fontWeight}) {
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
        backgroundColor: snackBarBackgroundColor,
      ));
  }

  static void removeSnackBar(){
    messengerKey.currentState!.removeCurrentSnackBar();
  }
}
