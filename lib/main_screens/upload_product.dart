import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_mysql/utilities/categ_list.dart';
import 'package:data_mysql/widget/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
//import 'package:uuid/uuid.dart';

class UploadProduct extends StatefulWidget {
  const UploadProduct({Key? key}) : super(key: key);

  @override
  _UploadProductState createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  String dropdownValue = 'select category';
  String subCategValue = 'subcategory';
  List<String> subCategList = [];

  late double price;
  late int quantity;
  late String productName;
  late String productDescription;
  late String proId;
  late bool processing = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _snackKey =
      GlobalKey<ScaffoldMessengerState>();

  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];
  List<String>? imageUrlList = [];
  dynamic _pickImageError;

  void selectMainCateg(String? value) {
    if (value == 'select category') {
      subCategList = [];
    } else if (value == 'men') {
      subCategList = men;
    } else if (value == 'women') {
      subCategList = women;
    } else if (value == 'electronics') {
      subCategList = electronics;
    } else if (value == 'accessories') {
      subCategList = accessories;
    } else if (value == 'shoes') {
      subCategList = shoes;
    } else if (value == 'home & garden') {
      subCategList = homeandgarden;
    } else if (value == 'beauty') {
      subCategList = beauty;
    } else if (value == 'kids') {
      subCategList = kids;
    } else if (value == 'bags') {
      subCategList = bags;
    }
    setState(() {
      dropdownValue = value!;
      subCategValue = 'subcategory';
    });
  }

  void pickProductImage() async {
    try {
      final pickdImages = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);
      setState(() {
        imageFileList = pickdImages;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
      print(_pickImageError);
    }
  }

  Widget previewImage() {
    if (imageFileList!.isNotEmpty) {
      return ListView.builder(
        itemCount: imageFileList!.length,
        itemBuilder: (context, index) {
          return Image.file(File(imageFileList![index].path));
        },
      );
    } else {
      return const Center(child: Text('You have not \n \n picked images yet'));
    }
  }

  Future<void> uploadImage() async {
    if (dropdownValue != 'select category' && subCategValue != 'subcategory') {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (imageFileList!.isNotEmpty) {
          setState(() {
            processing = true;
          });
          try {
            for (var image in imageFileList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${path.basename(image.path)}');

              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imageUrlList!.add(value);
                });
              });
            }
          } catch (e) {
            print(e);
          }
        } else {
          MyMessageHandler.showSnackBar(_snackKey, 'please fill images first');
        }
      }
    } else {
      MyMessageHandler.showSnackBar(_snackKey, 'please select categories');
    }
  }

  void uploadData() async {
    if (imageUrlList!.isNotEmpty) {
      CollectionReference productRef =
          FirebaseFirestore.instance.collection('products');
      proId = const Uuid().v4();
      await productRef.doc(proId).set({
        'proId': proId,
        'maincateg': dropdownValue,
        'subcateg': subCategValue,
        'price': price,
        'instock': quantity,
        'proname': productName,
        'prodescript': productDescription,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'proImage': imageUrlList,
        'discout': 0
      }).whenComplete(() {
        setState(() {
          processing = false;
          imageFileList = [];
          dropdownValue = 'select category';
          subCategList = [];
          imageUrlList = [];
        });
      });
      _formKey.currentState!.reset();
    } else {
      print('no image');
    }
  }

  void uploadProduct() async {
    await uploadImage().whenComplete(() {
      return uploadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _snackKey,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.indigo.shade400,
                        height: MediaQuery.of(context).size.width * 0.6,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: imageFileList != null
                            ? previewImage()
                            : const Center(
                                child: Text(
                                    'You have not \n \n picked images yet')),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'select main category',
                                  style: TextStyle(fontSize: 14),
                                ),
                                DropdownButton(
                                  iconEnabledColor: Colors.deepPurpleAccent,
                                  dropdownColor: Colors.white,
                                  value: dropdownValue,
                                  onChanged: (String? value) {
                                    selectMainCateg(value!);
                                  },
                                  items: maincateg
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              color: Colors.deepPurpleAccent),
                                        ),
                                        value: value);
                                  }).toList(),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'select subcategory',
                                  style: TextStyle(fontSize: 14),
                                ),
                                DropdownButton(
                                  iconEnabledColor: Colors.black,
                                  iconDisabledColor: Colors.grey,
                                  dropdownColor: Colors.white,
                                  disabledHint: const Text('select category'),
                                  value: subCategValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      subCategValue = value!;
                                    });
                                  },
                                  items: subCategList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                        child: Text(value,
                                            style: TextStyle(
                                                color:
                                                    Colors.deepPurpleAccent)),
                                        value: value);
                                  }).toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleaes enter price';
                          } else if (value.isValiPrice() != true) {
                            return 'not valid price';
                          }
                          return null;
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: textFormDecoration.copyWith(
                            labelText: 'price', hintText: 'Example:100.11'),
                        onSaved: (value) {
                          price = double.parse(value!);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleaes enter Quantity';
                          } else if (value.isValiQuantity() != true) {
                            return 'not valid quantity';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: textFormDecoration.copyWith(
                            labelText: 'Quantity', hintText: 'Example:30000'),
                        onSaved: (value) {
                          quantity = int.parse(value!);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleaes enter Product Name';
                          }
                          return null;
                        },
                        maxLength: 100,
                        maxLines: 3,
                        decoration: textFormDecoration.copyWith(
                            labelText: 'Product Name',
                            hintText: 'Enter product name'),
                        onSaved: (value) {
                          productName = value!;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleaes enter Product Description';
                          }
                          return null;
                        },
                        maxLength: 800,
                        maxLines: 3,
                        decoration: textFormDecoration.copyWith(
                            labelText: 'Product Description',
                            hintText: 'Enter product description '),
                        onSaved: (value) {
                          productDescription = value!;
                        },
                      ),
                    ),
                  ),
                ]),
          ),
        )),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FloatingActionButton(
                onPressed: imageFileList!.isEmpty
                    ? () {
                        pickProductImage();
                      }
                    : () {
                        setState(() {
                          imageFileList = [];
                        });
                      },
                backgroundColor: Colors.deepPurple,
                child: imageFileList!.isEmpty
                    ? const Icon(
                        Icons.photo_library,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
              ),
            ),
            FloatingActionButton(
              onPressed: processing == true
                  ? null
                  : () {
                      uploadProduct();
                    },
              backgroundColor: Colors.deepPurple,
              child: processing == true
                  ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.upload,
                      color: Colors.white,
                    ),
            )
          ],
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
    labelText: 'price',
    hintText: 'price .. USD',
    labelStyle: const TextStyle(color: Colors.blueGrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blueGrey, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(10)));

extension QuantityValidation on String {
  bool isValiQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidation on String {
  bool isValiPrice() {
    return RegExp(r'^(?:0\.[0-9]{1,2}|[1-9]{1}[0-9]*(\.[0-9]{1,2})?|0)$')
        .hasMatch(this);
  }
}
