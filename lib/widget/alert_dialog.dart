
import 'package:flutter/cupertino.dart';
class MyAlertDialog {
  static void showMyAlertDialog({
    required BuildContext context,
    required String title,
    required String router,
    required String content,
    required Function() tabYes,
    required Function() tabNo,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: tabNo,
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: tabYes,
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}