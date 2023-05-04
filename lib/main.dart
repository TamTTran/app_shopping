import 'package:data_mysql/auth/customer_login.dart';
import 'package:data_mysql/auth/customer_signup.dart';
import 'package:data_mysql/auth/supplier_login.dart';
import 'package:data_mysql/auth/supplier_signup.dart';
import 'package:data_mysql/main_screens/customer_screen.dart';
import 'package:data_mysql/main_screens/suplier_home_screen.dart';
import 'package:data_mysql/main_screens/welcome_come_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app connect databaese Firebase',
      theme: ThemeData(
      primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      //home: const WelcomeComeScreen(),
      initialRoute: '/welcome_come_screen',
      routes: {
        '/welcome_come_screen':(context) => const WelcomeComeScreen(),
        '/customer_screen':(context) => const CustomerScreen(),
        '/suplier_home_screen':(context) => const SuplierHomeScreen(), 
        '/customer_signup': (context) => const CustomerSignup(),
        '/customer_login':(context) => const CustomerLogin(),
        '/supplier_login':(context) => const SupplierLogin(),
        '/supplier_signup':(context) => const SupplierSignUp(),
      }        
  );
  }
}
