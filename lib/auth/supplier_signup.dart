import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_mysql/widget/auth_widget.dart';
import 'package:data_mysql/widget/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_strong;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SupplierSignUp extends StatefulWidget {
  const SupplierSignUp({Key? key}) : super(key: key);

  @override
  _SupplierSignUpState createState() => _SupplierSignUpState();
}

class _SupplierSignUpState extends State<SupplierSignUp> {
  late bool isShowPasswork = true;
  late bool isProcress = false;
  late String storeName;
  late String email;
  late String passwd;
  late String storeLogo;
  late String _uid;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _snackKey =
      GlobalKey<ScaffoldMessengerState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  dynamic _pickedImageError;

  CollectionReference supplier =
      FirebaseFirestore.instance.collection('supplier');

  void _pickImageFromCamera() async {
    try {
      final pickImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      // ignore: avoid_print
      print(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      // ignore: avoid_print
      print(_pickedImageError);
    }
  }

  Future<void> signUp() async {
    setState(() {
      isProcress = true;
    });
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: passwd);
          firebase_strong.Reference ref = firebase_strong
              .FirebaseStorage.instance
              .ref('supp-images/$email.jpg');
          await ref.putFile(File(_imageFile!.path));
          _uid = FirebaseAuth.instance.currentUser!.uid;
          storeLogo = await ref.getDownloadURL();
          await supplier.doc(FirebaseAuth.instance.currentUser!.uid).set({
            'storeName': storeName,
            'email': email,
            'storeLogo': storeLogo,
            'phone': '',
            'address': '',
            'sid': _uid,
            'coverimage': ''
          });

          _formKey.currentState!.reset();
          setState(() {
            _imageFile = null;
          });
          Navigator.pushReplacementNamed(context, '/supplier_login');
        } on FirebaseAuthException catch (e) {
          setState(() {
            isProcress = false;
          });
          if (e.code == 'weak-password') {
            setState(() {
              isProcress = false;
            });
            MyMessageHandler.showSnackBar(
                _snackKey, 'The password provied is too weak.');
          } else if (e.code == 'email-already-in-use') {
            setState(() {
              isProcress = false;
            });
            MyMessageHandler.showSnackBar(
                _snackKey, 'The account exists for the mail.');
          }
        }
      } else {
        setState(() {
          isProcress = false;
        });
        MyMessageHandler.showSnackBar(_snackKey, 'plesae pick image first');
      }
    } else {
      setState(() {
        isProcress = false;
      });
      MyMessageHandler.showSnackBar(_snackKey, 'please fill all fields');
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
                  child: Column(children: [
                    const AuthHeaderLabel(headerlabel: 'Sign Up'),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 14),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.pinkAccent,
                            backgroundImage: _imageFile == null
                                ? null
                                : FileImage(File(_imageFile!.path)),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.purpleAccent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  )),
                              child: IconButton(
                                onPressed: () {
                                  _pickImageFromCamera();
                                },
                                icon: const Icon(Icons.camera_alt),
                                color: Colors.white,
                                iconSize: 23,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.purpleAccent,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  )),
                              child: IconButton(
                                onPressed: () {
                                  _pickImageFromGallery();
                                },
                                icon: const Icon(Icons.image),
                                color: Colors.white,
                                iconSize: 23,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please fill Full Name !!!';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            storeName = value;
                          },
                          maxLength: 12,
                          decoration: textFormField.copyWith(
                              labelText: 'Full Name',
                              hintText: 'Enter your Full Name')),
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
                    HaveAccount(
                        haveAccount: 'Already have account ?',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/supplier_login');
                        },
                        login: 'Log In'),
                    isProcress == true
                        ? const CircularProgressIndicator()
                        : MateralBtnSignUp(
                            label: 'Sign Up',
                            onPressed: () async {
                              await signUp();
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
