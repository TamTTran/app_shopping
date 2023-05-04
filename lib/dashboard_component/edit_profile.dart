import 'package:flutter/material.dart';
class EditProfie extends StatelessWidget {
const EditProfie({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text('edit profile'.toUpperCase(), style: const TextStyle(
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