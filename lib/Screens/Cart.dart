import 'package:ecommerce_app/widget/CartItem.dart';
import 'package:ecommerce_app/widget/Purshase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import '../Global Variables/Global.dart';
import '../constant/constant.dart';
import '../logic/helper.dart';
import '../model/Product.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  void refresh(){
    setState(() {});
  }
  int total=0;
  @override
  Widget build(BuildContext context) {
    total=0;
  for(Tuple2<int,Product> product in Global.cartProducts){
    total+=product.item1*product.item2.price;
  }
    return Scaffold(
      backgroundColor: Global.dark?BackgroundColorDark
          :BackgroundColorLight,
      appBar: AppBar(
        backgroundColor: Purple,
        title: Text("Cart"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        //list view with fixed seperated sizedbox
        child: ListView.separated(
          //what it will seperat with ?
        separatorBuilder: (context, index) => const SizedBox(
          height: 15.0,
        ),
        itemCount: Global.cartProducts.length,
        //dismissible to remove item by going lift or right
        itemBuilder: (context, index) =>Dismissible(
            //removing
            onDismissed: (direction) async {
              Global.cartProducts.removeAt(index);
              setState(() {});
            },
            key: UniqueKey(),
            //background while removing
            background: Container(
              color: Color.fromRGBO(189, 0, 0, 1.0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Delete Product ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            child: CartItem(index: index,)
        ),
          ),

      ),
      bottomNavigationBar: Purshase(refresh: refresh,total: total,)
    );
  }
}
