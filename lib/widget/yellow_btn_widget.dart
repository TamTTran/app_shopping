import 'package:flutter/material.dart';
// ignore: must_be_immutable
class YellowBtn extends StatelessWidget {
  final String label;
  final Function() onPressed;
  double width;
   YellowBtn({
    super.key,
    required this.label,
    required this.onPressed,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
          color: Colors.yellow, borderRadius: BorderRadius.circular(25)),
      child: MaterialButton(
        onPressed: onPressed,
        child:  Text(label),
      ),
    );
  }
}
