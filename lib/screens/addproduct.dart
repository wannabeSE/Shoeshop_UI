import 'dart:io';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}
final GlobalKey <FormState> _form=GlobalKey<FormState>();
final TextEditingController name=  TextEditingController();
final TextEditingController price =  TextEditingController();
final TextEditingController quantity =  TextEditingController();
final TextEditingController description=  TextEditingController();
final TextEditingController category=  TextEditingController();
final TextEditingController picname=  TextEditingController();
String? selected;
File? file;
class _AddProductState extends State<AddProduct> {
  static String? imageUrl;
  bool isloading=false;
  List categorylist=[];
  List dropDown=[];
  void getCategory()async{
    String url='http://10.0.2.2:8080/api/category/getcategory';
    
    try{
      var res= await http.get(Uri.parse(url));
      var values=jsonDecode(res.body);

      var data=values['mainCatList'];
      
      setState(() {
      for (int i=0;i<data.length;i++){
        categorylist.add({
          'name':data[i]['name'],
          'id':data[i]['_id']
      });
      }
     
      for(int i =0;i<categorylist.length;i++){
        dropDown.add(categorylist[i]['name']+' '+'id:(${categorylist[i]['id']})');
        
      } 
      selected=dropDown[0];
 
      });
    }catch(e){
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }
  Future addProduct(String pName,String pPrice,String pQuantity,String pDescription,String pCategory,String imgUrl)async{
    if(_form.currentState!.validate()){
      var res=await http.post(Uri.parse('http://10.0.2.2:8080/api/product/create'),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,String>{
        'name':pName,
        'price':pPrice,
        'quantity':pQuantity,
        'description':pDescription,
        'pics':imgUrl,
        'category':pCategory,
        
      }        
      )
    
      );
      if(res.statusCode==201){
        Fluttertoast.showToast(msg:'Product Created Succesfully');
      }else{
        Fluttertoast.showToast(msg: 'Unable to create product');
      }
    }
  }
  Future pickImg() async{
    var pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery, 
      maxWidth: 1920,
      maxHeight: 1200,   
      imageQuality: 80); 

      uploadPhoto(pickedImage);
  }
    Future uploadPhoto (var img) async{    
  //upload and download url
  Reference ref = FirebaseStorage.instance.ref().child(picname.text);
  await ref.putFile(File(img!.path));

  
  imageUrl = await ref.getDownloadURL();
  }
 

    @override
  void initState(){
    getCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: 
      SingleChildScrollView(
        child: Form(
          key: _form, 
          child: Column(
            children: [
              Padding(padding:const  EdgeInsets.all(6),
            child: TextFormField(
              controller: name,
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter Shoe name';
                }else{
                  return null;
                }
              },
              
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                    borderSide:const BorderSide(color: Colors.black87)
                ),
                hintText: 'Name of the Shoe',
              ),
            ),
            ),
            Padding(padding:const  EdgeInsets.all(6),
            child: TextFormField(
              controller: price,
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter price';
                }else{
                  return null;
                }
              },
              
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                    borderSide:const BorderSide(color: Colors.black87)
                ),
                hintText: 'Price of the Shoe',
              ),
            ),
            ),
            Padding(padding:const  EdgeInsets.all(6),
            child: TextFormField(
              controller: quantity,
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter the quantity';
                }else{
                  return null;
                }
              },
              
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                    borderSide:const BorderSide(color: Colors.black87)
                ),
                hintText: 'How many shoes are in stock?',
              ),
            ),
            ),
            Padding(padding:const  EdgeInsets.all(6),
            child: TextFormField(
              controller: description,
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter Description';
                }else{
                  return null;
                }
              },
              
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                    borderSide:const BorderSide(color: Colors.black87)
                ),
                hintText: 'Description of the Shoe',
              ),
            ),
            ),
           Padding(padding:const  EdgeInsets.all(6),
            child: TextFormField(
              controller: category,
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter Category';
                }else{
                  return null;
                }
              },
              
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                    borderSide:const BorderSide(color: Colors.black87)
                ),
                labelText: 'Enter id from available category list below',
              ),
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding:const EdgeInsets.all(10),
                    child: DropdownButton(
                      value: selected,
                      icon: const Icon(Icons.arrow_downward,color: Colors.greenAccent,),
                      items: dropDown.map((item)=>
                    DropdownMenuItem(
                      value: item,
                      child: Text(item,style:const TextStyle(color: Colors.white),)
                      ),
                  ).toList(), 
                  onChanged: (val)=>setState(()=> {
                    selected=val as String ,
                  })
                  ),
                  ),
              ],
            ),
            Padding(padding:const  EdgeInsets.all(6),
            child: TextFormField(
              controller: picname,
              validator: (value){
                if(value!.isEmpty){
                  return 'Please give name for Picture';
                }else{
                  return null;
                }
              },
              
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                    borderSide:const BorderSide(color: Colors.black87)
                ),
                labelText: 'Give a name for the picture',
              ),
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(onPressed: (){
                  pickImg();
                }, child:const Text('Pick Image')
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextButton(onPressed: (){
                    setState(() {
                      isloading=true;
                    });
                    showDialog(context: context, builder:(context){
                      return const Center(child: CircularProgressIndicator());
                    }
                  );
                  if(isloading==true){
                      Future.delayed(const Duration(seconds: 3),(){
                      Navigator.of(context).pop();
                      // Navigator.pushNamed(context, '/demo');
                      isloading= false;
                    });
                  }
                  }, child: const Text('Upload Image')),
                  ),
              ],
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
                      addProduct(name.text,price.text,quantity.text,description.text,category.text,imageUrl!);
                    }, child:const Text('Submit',style: TextStyle(fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.bold,color: Colors.white),),)
                ],
              )
            ],
          ),
          ),
      )
      ),
    );
  }
}