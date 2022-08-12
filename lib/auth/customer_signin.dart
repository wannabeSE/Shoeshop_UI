import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CustomerSignIn extends StatefulWidget {
  const CustomerSignIn({ Key? key }) : super(key: key);

  @override
  State<CustomerSignIn> createState() => _CustomerSignInState();
}
final GlobalKey <FormState> _formkey= GlobalKey<FormState>();

String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
bool observeText=true;
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
bool isloading= false;
int selected=0;
RegExp regExp = RegExp(p);

class _CustomerSignInState extends State<CustomerSignIn> {
  void login(String email, String password) async{
    final FormState? _form = _formkey.currentState;
    if(_form!.validate()){
    var res= await http.post(Uri.parse('http://10.0.2.2:8080/api/signin'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:jsonEncode(<String,String> {
      'email':email,
      'password':password,
    }
    )
    );
    
    if(res.statusCode==400){
      Fluttertoast.showToast(msg: 'Please enter your email and password',
        backgroundColor: Colors.white,
        textColor: Colors.black
      );
    }else if(res.statusCode==401){
      Fluttertoast.showToast(msg: 'Wrong email or password',
        backgroundColor: Colors.white,
        textColor: Colors.black
      );
    }else if(res.statusCode==402){
      Fluttertoast.showToast(msg: 'Invalid password',
        backgroundColor: Colors.white,
        textColor: Colors.black
        );
    }else if(res.statusCode==200){
      isloading=true;
      showDialog(context: context, builder:(context){
        return const Center(child: CircularProgressIndicator()) ;
        
      }
      );
      
    }
    if(isloading==true){
      Future.delayed(const Duration(seconds: 2),(){
      Navigator.of(context).pop();
      Navigator.pushNamed(context, '/demo');
      isloading= false;
    });
    }
    
    
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body:
         SafeArea(
           child: Form(
            key: _formkey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              Padding(
                padding:const EdgeInsets.fromLTRB(10,20,10,70),
                child: Row(
                  children: [
                    RichText(
                      text:const TextSpan(
                        children: [
                          TextSpan(text: "Let's get into the\n",style: TextStyle(fontSize: 30,fontFamily: 'Montserrat')),
                          TextSpan(text:"Community",style: TextStyle(fontSize: 50,fontFamily: 'Lobster') )
         
                        ]
                       
                        
                      )
                      ),
                     
                  ],
                
                ),
              ),
              
               Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: emailController,
                   validator: (value){
                    if(value!.isEmpty){
                      return 'Please enter your E-mail';
                    }else if(!regExp.hasMatch(value)){
                      return 'E-mail is invalid';
                    }
                    return null;
                  },
                  decoration:InputDecoration(
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.white)
                    ),
                    hintText: 'E-mail',
                    
                  ), 
                ),
              ),
              Padding(padding: const EdgeInsets.all(10),
              child: TextFormField(
                obscureText: observeText,
                controller: passwordController,
                validator: ((value) {
                  if(value!.isEmpty){
                    return 'Please Enter Your Password';
                  }else{
                    return null;
                  }
                }),
                  decoration: InputDecoration(
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.white)
                    ),
                    hintText: 'Password',
                    suffixIcon: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            observeText=! observeText;
                          });
                        },
                        child: Icon(
                          observeText==true?
                           Icons.visibility:
                           Icons.visibility_off,
                           color: Colors.white,
                          ),
                      ),
                  ),  
                ),
              ),
              Row(
                children: [
                  //radio button for customer
                   Radio(value: 0, groupValue: selected, onChanged:(value){setState(() {
                    selected=0;
                    
                  });}),
                  
                  const Text('Customer',style: TextStyle(color: Colors.white),),
                  // radio button for admin
                  Radio(value: 1, groupValue: selected, onChanged:(value){setState(() {
                    selected=1;
                    
                  });}),
                  
                  const Text('Admin',style: TextStyle(color: Colors.white),),

                  //radio button for seller
                  Radio(value: 2, groupValue: selected, onChanged: (value){setState(() {
                    selected=2;
                    
                  });}),
                  const Text('Seller',style: TextStyle(color: Colors.white),),

                ],
              ),
            
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0,10),
                child: Row(
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, '/customer_signup');
                    }, child:const Text('Create an account'))
                  ],
                ),
              ),
               
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black54,
                      elevation: 8,
                      shadowColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                    
                    onPressed: (){
                      if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty && selected==0){
                              login(emailController.text,passwordController.text);
                              // print('customer selected');
                           }
                           else if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty && selected==1){
                              // login(emailController.text,passwordController.text);
                           }
                    }, child:const Text('Login',style: TextStyle(fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.bold,color: Colors.white),),)
                ],
              )
            ],      
                ),
                 ),
         ),
        
    );
  }
}