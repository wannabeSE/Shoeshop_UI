import 'package:flutter/material.dart';
import 'package:sneakerheads/auth/customer_signin.dart';
import 'package:sneakerheads/demo.dart';
import 'package:sneakerheads/screens/addproduct.dart';

import 'package:sneakerheads/screens/productview.dart';
import 'auth/customersignup.dart';
import 'firebase_options.dart';
import 'splashscreen/splash.dart';
import 'package:firebase_core/firebase_core.dart';



void main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    
    initialRoute: '/splash',
   
    routes: {
      '/splash':(context) => const SplashScreen(),
      '/customer_signup':((context) => const CustomerSignUp()),
      '/customer_signin':(context) => const CustomerSignIn(),
      '/demo':(context) => const Demo(),
      '/product_view':(context) => const ProductView(),
      '/add_prod':(context) => const AddProduct(),
      // '/productdetail':(context) => ProductDetails(),
    },
    theme:ThemeData(brightness: Brightness.dark),
  )
  );
}