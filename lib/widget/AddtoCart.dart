import 'package:ecommerce_app/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import '../Global Variables/Global.dart';
import '../constant/constant.dart';
import '../logic/helper.dart';

class AddtoCart extends StatefulWidget {
  final Product product;
  const AddtoCart({Key? key, required this.product,}) : super(key: key);

  @override
  State<AddtoCart> createState() => _AddtoCartState();
}

class _AddtoCartState extends State<AddtoCart> {
  int count=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Global.dark?Color.fromRGBO(66, 66, 66, 130)
            :Colors.grey.shade200,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.only(
          topRight:Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding:EdgeInsets.all(2),
            width: 150,
            height: 52,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Global.dark? Colors.grey.shade400
                    :Colors.black12,
                borderRadius: BorderRadius.circular(25)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(onPressed: (){
                  count>0?setState(() {
                    count--;
                  }
                  ):SizedBox();

                },
                  child: Icon(Icons.remove),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  color:Purple,

                  height: double.infinity,
                  minWidth: 50,
                ),
                Text(
                  "$count",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                MaterialButton(onPressed: (){

                  count<widget.product.stock?setState(() {
                    count++;
                  }):SizedBox();

                },
                  child: Icon(Icons.add),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  color:Purple,
                  height: double.infinity,
                  minWidth: 50,
                ),
              ],
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Container(
              height: 65,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Purple,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: MaterialButton(
                onPressed: (){

                 if(count>0){
                   showSnackBar(context, "Add to Cart successfully");
                   Global.cartProducts.add(Tuple2<int, Product>(count, widget.product));
                 }
                     else
                       showSnackBar(context, "Erorr while adding to cart");
                },
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade200
                  ),

                ),


              ),
            ),
          ),

        ],
      ),
    );
  }
}
