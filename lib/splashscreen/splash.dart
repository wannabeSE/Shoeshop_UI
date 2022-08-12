import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sneakerheads/auth/customer_signin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.of(context).pop();
      // Navigator.pushNamed(context, '/customer_signin');
      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade,child:const CustomerSignIn()));
      
    });
    super.initState();
     
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 241, 21, 21),
      body:SizedBox(
        height: double.infinity,
        width: double.infinity,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:const  [
            Image(image:AssetImage('assets/images/splash.jpg'),
            width: 300,
            ),
            SizedBox(
              height: 50,
            ),
            Text('SneakerHeads',style: TextStyle(fontFamily: 'Lobster',fontSize: 40,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 30,
            ),
            SpinKitCubeGrid(
              color: Colors.black,
              size: 60,
            )
          ],
        )
      ),
      
    );
  }
}