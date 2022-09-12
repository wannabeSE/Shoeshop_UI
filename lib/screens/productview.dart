import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sneakerheads/screens/addproduct.dart';
import 'package:sneakerheads/screens/productdetailscreen.dart';


class ProductView extends StatefulWidget {
  const ProductView({ Key? key }) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {

  List sneakers=[];
  List category=[];

  void getCategory()async{
    String url='http://10.0.2.2:8080/api/category/getcategory';
    
    try{
      var res= await http.get(Uri.parse(url));
      var values=jsonDecode(res.body);

      var data=values['categories'];
      
      setState(() {
      for (int i=0;i<data.length;i++){
        category.add({
          'name':data[i]['name'],
        });
      }
      });
    }catch(e){
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  
  }
  void getProduct()async{
    String url = 'http://10.0.2.2:8080/api/product/getproduct';
    
    try{
      var res= await http.get(Uri.parse(url));
      var sValues=jsonDecode(res.body);

      var sData=sValues['products'];
      
      setState(() {
      for (int i=0;i<sData.length;i++){
        sneakers.add({
          'name':sData[i]['name'],
          'price':sData[i]['price'],
          'image':sData[i]['pics'],
          'description':sData[i]['description']
        });
      }
    });
    }catch(e){
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  // print(sneakers);
  }
  @override
  void initState(){
    getCategory();
    getProduct();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.black,
     body: SafeArea(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed: (){}, 
          icon:const Icon(Icons.arrow_back_ios_new_rounded, )),
          Row(
            children:const [
              Padding(
                padding:EdgeInsets.only(left: 18),
                child: Text('SneakerHeads',style: TextStyle(fontFamily: 'Lobster',fontWeight: FontWeight.bold,fontSize: 40,color: Colors.greenAccent),),
              )
            ],
          ),
          Padding(
                padding:const EdgeInsets.only(bottom: 10),
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(width: 20.0, height: 100.0),
                const Text(
                  'Be ',
                  style: TextStyle(fontSize: 43.0,fontFamily: 'Montserrat'),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Righteous',
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText('AWESOME'),
                      TypewriterAnimatedText('OPTIMISTIC'),
                      TypewriterAnimatedText('DIFFERENT'),
                      TypewriterAnimatedText('YOU...'),
                      
                    ],
                    
                  ),
                ),
              ],
            ),
            ),
             
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                child: TextField(
                  decoration: InputDecoration(
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.white54),
                      ),
                      hintText: 'search',
                      suffixIcon:const Icon(Icons.search,color: Colors.white,)
                  ),
                ),
              ),
             const Padding(
                padding:EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 30,
                  child: Text('Categories',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                ),
              ),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (
                    (context, index) => Padding(
                    padding:const  EdgeInsets.symmetric(horizontal: 10),
                    child: Text('${category[index]['name']}',style: const TextStyle(fontSize: 18, fontFamily: 'Montserrat',fontWeight: FontWeight.normal,color: Colors.white),),
                  )
                  )
                  ),
              ),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: sneakers.length,
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.75,
            ), 
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (() => Navigator.push(context, MaterialPageRoute(builder: ((context) => ProductDetails(sneaker:sneakers[index]))))),
                child: Card(
                  margin:const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  // color: const Color(0Xff51557E),
                  // color: Color(0Xff2A2550),
                  color:const Color(0XffD3ECA7),
                  // shadowColor: const Color(0Xff1A4D2E),
                  shadowColor: Colors.deepOrangeAccent,
                  elevation: 10,
                  child: Column(
                    children: [
                       AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            color:Colors.white,
                            
                            child:Padding(
                              padding:const EdgeInsets.all(5.0),
                              child: Image.network('${sneakers[index]['image']}'),
                            )
                            )
                          ),
                           
                          Text('${sneakers[index]['name']}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                           
                           Padding(
                             padding: const EdgeInsets.all(5.0),
                             child: Text('Price: ${sneakers[index]['price']} Tk',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                           ),
                    ],
                  ),
                ),
              );
            })
            )
        ],
      ) 
      ),
    );
  }
}