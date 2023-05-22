import 'package:flutter/material.dart';
class MyMessageHandler {
  static  void showSnackBar(var snackKey, String messenger ) {
    snackKey.currentState!.hideCurrentSnackBar();
    snackKey.currentState!.showSnackBar(
                                 SnackBar(
                                duration: const Duration(seconds: 2),
                                backgroundColor: Colors.red, 
                                content: Text(messenger, style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),),
                                ),);
  }
}
