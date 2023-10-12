import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Global Variables/Global.dart';
import '../constant/constant.dart';

class CartItem extends StatelessWidget {
  final int index;
  const CartItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
          color: Global.dark? Purple
              :Color.fromRGBO(156, 156, 156,100),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Global.dark?Colors.white10
                :Colors.black12,
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${Global.cartProducts[index].item1}",
              style: TextStyle(
                  color: Global.dark? FontColorDark
                      :Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(width: 6,),
            Container(
              height: 100,
              width: 100,
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
              ),
              child:  ClipRRect(
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/a47aebcb-8131-42a4-bcb1-09ae5e04efeb.gif",
                  image: Global.cartProducts[index].item2.thumbnail,
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(width: 5,),
            Expanded(
              child: Text(
                Global.cartProducts[index].item2.title,
                style: TextStyle(
                    color: Global.dark? FontColorDark
                        :Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold

                ),

                overflow: TextOverflow.clip,
              ),
            ),

            Text("${Global.cartProducts[index].item1*Global.cartProducts[index].item2.price}\$",
              style: TextStyle(
                  color: Global.dark? FontColorDark
                      :Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),


            )
          ],
        ),
      ),
    );
  }
}
