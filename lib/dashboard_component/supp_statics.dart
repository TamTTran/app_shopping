import 'package:flutter/material.dart';
class StaticseSceen extends StatelessWidget {
 const StaticseSceen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text('Statics Screen'.toUpperCase(), style: const TextStyle(
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