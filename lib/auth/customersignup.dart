import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CustomerSignUp extends StatefulWidget {
  const CustomerSignUp({ Key? key }) : super(key: key);

  @override
  State<CustomerSignUp> createState() => _CustomerSignUpState();
}
final GlobalKey <FormState> _formkey2= GlobalKey<FormState>();

String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmpassController =  TextEditingController();
final TextEditingController firstnameController =  TextEditingController();
final TextEditingController lastnameController =  TextEditingController();
final TextEditingController emailController = TextEditingController();

RegExp regExp =RegExp(p);
bool observeText=true;
class _CustomerSignUpState extends State<CustomerSignUp> {
  Future signUp(String fname, String lname, String email, String password)async{
    if(_formkey2.currentState!.validate()){
      var res=await http.post(Uri.parse('http://10.0.2.2:8080/api/signup'),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,String>{
        'firstName':fname,
        'lastName':lname,
        'email':email,
        'password':password,
      }        
      )
    
      );
      if(res.statusCode==201){
        Fluttertoast.showToast(msg:'Account Created Succesfully');
      }
    }
    
  }
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,

        body: SafeArea(
          child: Form(
            key: _formkey2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, 
              icon: const Icon(Icons.arrow_back_ios_new_rounded)
              ),
              Padding(
                padding:const EdgeInsets.fromLTRB(10,20,10,40),
                child: Row(
                  children: [
                    RichText(
                      text:const TextSpan(
                        children: [
                          TextSpan(text: "Hey There!\n",style: TextStyle(fontSize: 30,fontFamily: 'Montserrat')),
                          TextSpan(text: "Let's join the\n",style: TextStyle(fontSize: 30,fontFamily: 'Montserrat')),
                          TextSpan(text:"SneakerHeads",style: TextStyle(fontSize: 40,fontFamily: 'Lobster',color: Colors.orangeAccent) 
                          ),
                        ]
                      )
                      ),
                  ],
                
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: TextFormField(
                  controller: firstnameController,
                  validator: ((value){
                    if(value!.isEmpty){
                      return 'Please Enter First Name';
                    }else{
                      return null;
                    }
                  }),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:const BorderSide(color: Colors.black87)
                    ),
                    hintText: 'firstname',
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(6),
                child: TextFormField(
                  controller: lastnameController,
                  validator: ((value) {
                    if(value!.isEmpty){
                      return 'Please Enter Last Name';
                    }else{
                      return null;
                    }
                  }),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:const BorderSide(color: Colors.black87)
                    ),
                    hintText: 'lastname',
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(6),
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
                  onChanged:(value) {},
                  decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:const BorderSide(color: Colors.black87)
                    ),
                  labelText: 'E-mail',
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(6),
              child: TextFormField(
                obscureText: observeText,
                controller: passwordController,
                validator: ((value) {
                  if(value!.isEmpty){
                    return 'Please enter password';
                  }else if(value.length<6){
                    return 'The password is too short';
                  }else{
                    return null;
                  }
                  
                }),
                onChanged: (value){},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:const BorderSide(color: Colors.black87)
                    ),
                    hintText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: () {  
                        setState(() {
                          observeText=!observeText;
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
               const SizedBox(
                      height: 20,
                    ),
                     Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black54,
                      elevation: 8,
                      shadowColor: Colors.orange[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),

                    onPressed: (){
                      signUp(firstnameController.text,lastnameController.text,emailController.text,passwordController.text);
                    }, child:const Text('Sign Up',style: TextStyle(fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.bold,color: Colors.white),),)
                ],
              )
            ],      
                ),
          ),
        ),
    );
  }
}