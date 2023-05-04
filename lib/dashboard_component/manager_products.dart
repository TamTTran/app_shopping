import 'package:flutter/material.dart';
class ManagerProdcuts extends StatelessWidget {
const ManagerProdcuts({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text('Manager Prodcuts'.toUpperCase(), style: const TextStyle(
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