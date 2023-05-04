import 'package:flutter/material.dart';
class BalanceSceen extends StatelessWidget {
const BalanceSceen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text('Balance Screen'.toUpperCase(), style: const TextStyle(
          fontFamily: 'Acme',
          fontSize: 24,
          color: Colors.black
        ),),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
      ),
    );
  }
}