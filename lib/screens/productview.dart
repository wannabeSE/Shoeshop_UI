import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


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

      var data=values['mainCatList'];
      
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
      print(sData);
      setState(() {
      for (int i=0;i<sData.length;i++){
        sneakers.add({
          'name':sData[i]['name'],
          'price':sData[i]['price'],
          'image':sData[i]['pics'][0]
        });
      }
      });
    }catch(e){
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  // print(sneakers);
  // print(sneakers[1]['image']['img']);
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
          Padding(
                padding:const EdgeInsets.fromLTRB(10,20,10,50),
                child: Row(
                  children: [
                    RichText(
                      text:const TextSpan(
                        children: [
                          TextSpan(text: "Find Your\n",style: TextStyle(fontSize: 30,fontFamily: 'Montserrat',)),
                          TextSpan(text:"BEST PAIR",style: TextStyle(fontSize: 40,fontFamily: 'Montserrat',fontWeight: FontWeight.bold,color: Colors.greenAccent) )
                        ]
                      )
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
              return Card(
                margin:const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                shadowColor: Colors.deepOrangeAccent,
                elevation: 10,
                child: Column(
                  children: [
                     AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          color:Colors.white,
                          
                          child:Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Image.network('http://10.0.2.2:8080//SneakerHead//serverside//uploads//${sneakers[index]['image']['img']}'),
                          )
                          )
                        ),
                         Text('${sneakers[index]['name']}'),
                         Padding(
                           padding: const EdgeInsets.all(5.0),
                           child: Text('${sneakers[index]['price']} Tk'),
                         ),
                  ],
                ),
              );
            }))
        ],
      ) 
      ),
    );
  }
}