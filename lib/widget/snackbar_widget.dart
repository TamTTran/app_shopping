import 'package:flutter/material.dart';
class MyMessageHandler {
  static  void showSnackBar(var _snackKey, String messenger ) {
    _snackKey.currentState!.hideCurrentSnackBar();
    _snackKey.currentState!.showSnackBar(
                                 SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red, 
                                content: Text(messenger, style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),),
                                ),);
  }
}
