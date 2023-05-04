import 'package:flutter/material.dart';
class MateralBtnSignUp extends StatelessWidget {
  final String label;
  final Function() onPressed;
  const MateralBtnSignUp({
    super.key,
    required this.label,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:  10.0),
      child: Material(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(25),
        child: MaterialButton(
          minWidth: double.infinity,
          onPressed: onPressed,
          child:  Text(label, style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}

class HaveAccount extends StatelessWidget {
  final String haveAccount;
  final String login;
  final Function() onPressed;
  const HaveAccount({
    super.key,
    required this.haveAccount,
    required this.login,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
        return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children:  [
        Text(haveAccount, style: const TextStyle(
          fontSize: 16, fontStyle: FontStyle.italic
        ),),
        TextButton(
        onPressed: onPressed, 
        child:  Text(login, style: 
        const TextStyle(
          color: Colors.purpleAccent,
          fontSize: 20,
          fontFamily: 'Acme',
          fontWeight: FontWeight.bold
        ),))
      ],
    );
  }
}

class AuthHeaderLabel extends StatelessWidget {
  final String headerlabel;
  const AuthHeaderLabel({
    super.key,
    required this.headerlabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(headerlabel,
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/welcome_come_screen');
            },
            icon: const Icon(Icons.home_work),
            iconSize: 34,
          )
        ],
      ),
    );
  }
}

var textFormField = InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Enter your Full Name',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                      enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.purpleAccent, width: 1),
                      borderRadius: BorderRadius.circular(25),),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purpleAccent, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      )
                      );