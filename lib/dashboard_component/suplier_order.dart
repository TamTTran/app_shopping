import 'package:flutter/material.dart';
class SupplierOrder extends StatelessWidget {
const SupplierOrder({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('oders'.toUpperCase(), style: const TextStyle(
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