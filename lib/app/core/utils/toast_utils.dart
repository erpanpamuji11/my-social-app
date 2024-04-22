import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  // static void showPositiveMessage(String message) => Fluttertoast.showToast(
  //       msg: message,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: CustomColor.danger700,
  //       toastLength: Toast.LENGTH_SHORT,
  //     );

  static void showNeutralMessage(String message) => Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.black,
      );

  static void showNegativeMessage(String message) => Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        toastLength: Toast.LENGTH_SHORT,
      );

  static void showMessageOnTop(String message) => Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.TOP_LEFT,
        backgroundColor: Colors.black45,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.black,
      );
}
