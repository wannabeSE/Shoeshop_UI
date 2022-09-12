import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final sneaker;
  const ProductDetails({Key? key,required this.sneaker}) : super(key: key);
  
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body:Stack(
          children: [
           
            Container(
              
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration:BoxDecoration(
                image: DecorationImage(image: NetworkImage('${widget.sneaker['image']}'),
                fit: BoxFit.cover
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius:const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(1),
                      offset: const Offset(2,-4),
                      blurRadius: 9,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding:const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      child: Text('${widget.sneaker['name']}',
                      style:const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Righteous'),
                      ),
                    ),
                    Padding(padding:const EdgeInsets.fromLTRB(20, 5, 0, 8),
                    child: Row(
                      children:[
                        Text('Price: ${
                          widget.sneaker['price']
                        } Tk',
                        style:const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: 23),
                          ),
                        
                      ],
                    ),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(20, 10, 0, 8),
                    child: SizedBox(
                      width: 500,
                      child:RichText(text:TextSpan(
                          children: [
                            TextSpan(
                              text: 'Description: ${widget.sneaker['description']}',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                                fontSize: 18
                                ),
                            ),
                          ]
                    ),
                    
                    ),
                    ),
                    ), 
                  Padding(
                    padding:const EdgeInsets.fromLTRB(20,12,0,10),
                    child: Row(
                      children: [
                       SizedBox(
                        width: 60,
                        height: 42,
                        child:ElevatedButton(onPressed: (){}, child:const Icon(Icons.shopping_cart,color: Colors.black,),style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                             RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(color: Colors.black)
                                ),
                          ),
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                        ),
                        ),
                       ),
                       const SizedBox(width: 30,),
                       SizedBox(
                        width: 250,
                        height: 42,
                        child: ElevatedButton(onPressed: (){}, child:const Text('Buy Now',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'Montserrat'),),style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                             RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(color: Colors.black)
                                ),
                          ),
                          // backgroundColor: MaterialStateProperty.all(Colors.white),
                        ),
                        ),


                       ),
                       
                      ],
                    ),
                  )

                  ],
                ),
              ),
            )
          ],
        ),
      );
    
  }
}