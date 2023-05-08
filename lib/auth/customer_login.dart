import 'package:data_mysql/widget/auth_widget.dart';
import 'package:data_mysql/widget/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({Key? key}) : super(key: key);

  @override
  _CustomerLoginState createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  late bool isShowPasswork = true;
  late bool isProcess = false;
  late String email;
  late String passwd;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _snackKey =
      GlobalKey<ScaffoldMessengerState>();

  
void login() async {
  setState(() {
    isProcess = true;
  });
  if (_formKey.currentState!.validate()) {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: passwd);
      _formKey.currentState!.reset();
      Navigator.pushReplacementNamed(context, '/customer_screen');
    } on FirebaseAuthException catch (e) {
      setState(() {
        isProcess = false;
      });
      switch(e.code) {
        case 'invalid-email':
          MyMessageHandler.showSnackBar(_snackKey, 'No user found for that email.');
          break;
        case 'wrong-password':
          MyMessageHandler.showSnackBar(_snackKey, 'Wrong password provided for that user.');
          break;
        default:
          MyMessageHandler.showSnackBar(_snackKey, 'An error occurred. Please try again later.');
          break;
      }
    } catch (e) {
      setState(() {
        isProcess = false;
      });
      MyMessageHandler.showSnackBar(_snackKey, 'An error occurred. Please try again later.');
    }
  } else {
    setState(() {
      isProcess = false;
    });
    MyMessageHandler.showSnackBar(_snackKey, 'Please fill all fields.');
  }
}
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _snackKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const AuthHeaderLabel(headerlabel: 'LogIn'),
                    Row(
                      children: [
                        Column(
                          children: const [
                            SizedBox(height: 8.0),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please fill Email !!!';
                            } else if (value.isValiEmail() == false) {
                              return 'invalid email';
                            } else if (value.isValiEmail() == true) {
                              return null;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          maxLength: 30,
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormField.copyWith(
                              labelText: 'Email Address',
                              hintText: 'Enter your Email Address')),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please fill password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            passwd = value;
                          },
                          obscureText: isShowPasswork,
                          decoration: textFormField.copyWith(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isShowPasswork = !isShowPasswork;
                                  });
                                },
                                icon: isShowPasswork
                                    ? const Icon(Icons.visibility,
                                        color: Colors.purpleAccent)
                                    : const Icon(Icons.visibility_off,
                                        color: Colors.purpleAccent)),
                            labelText: 'Password',
                            hintText: 'Enten your Password',
                          )),
                    ),                                                                              
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                        'Forgot your password ?',
                          style: TextStyle(
                              color: Colors.blueAccent, fontStyle: FontStyle.italic, fontSize: 16, height: 1
                              ),
                        )),
                    HaveAccount(
                        haveAccount: 'Do not Have Account ?',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/customer_screen');
                        },
                        login: 'Sign up'),
                    isProcess == true
                        ? const Center(child: CircularProgressIndicator())
                        : MateralBtnSignUp(
                            label: 'LogIn',
                            onPressed: ()  {
                               login();
                            },
                          )
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValiEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}
