import 'package:ecommerce_app/constant/constant.dart';
import 'package:ecommerce_app/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Global Variables/Global.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key,required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title;
    product.title.length>16?
     title=product.title.substring(0,14)+".."

    :title=product.title;


    return Container(
      height:280 ,
        width: double.infinity  ,
        margin:EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10) ,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            //color: Color.fromRGBO(240,240,250,1),
            color: Global.dark? Purple
            :Color.fromRGBO(156, 156, 156,100),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Global.dark?Colors.white10
                    :Colors.black26,
                blurRadius: 5,
                spreadRadius: 1,
            ),
          ],
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          //image with header and foter
          Container(
            height: 170,
            child: ClipRRect(
                child: GridTile(
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/a47aebcb-8131-42a4-bcb1-09ae5e04efeb.gif",
                      image: product.thumbnail,fit: BoxFit.fill,
                    ),


                  //header with alignment
                  header: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 45,
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(189, 0, 0, 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "-${product.discountPercentage}%",
                          style: TextStyle(
                              color: FontColorDark,
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                  ),


                  //footer with alignment
                  footer: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 65,
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color:Global.dark?Color.fromRGBO(225, 232, 235,15)
                          :Color.fromRGBO(227, 227, 227,1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${product.rating}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Icon(Icons.star,color: Color.fromRGBO(255, 193, 7,1),)
                        ],
                      ),
                    ),
                  ),
                ),
                borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(height: 15,),


          Text(title,
              style: TextStyle(
                color: Global.dark? FontColorDark
                  :Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold

          ),
            softWrap:   false,
              overflow: TextOverflow.clip
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${product.price}\$",
                  style: TextStyle(
                    color: Global.dark? FontColorDark
                      :Colors.black,
                    fontSize: 20

                  )
              ),

            ],
          )
        ],
      ),
    );
  }
}
