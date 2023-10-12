import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Global Variables/Global.dart';
import '../constant/constant.dart';
import '../logic/helper.dart';

class Purshase extends StatelessWidget {
  final Function refresh;
  final int total;
  const Purshase({Key? key, required this.total, required this.refresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Global.dark?Color.fromRGBO(66, 66, 66, 130)
            :Colors.grey.shade200,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.only(
          topRight:Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(

          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          "Total : $total",
                          style:TextStyle(

                            color:Global.dark? Colors.grey.shade200
                                :Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,



                        ),
                      ),
                    ),
                  ),

                ],
              ),

            ),
            SizedBox(width: 10,),
            Expanded(
              child: Container(
                height: 65,
                width: double.infinity,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Purple,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: MaterialButton(
                  onPressed: (){
                    showSnackBar(context, "Purshase complete");
                    Global.cartProducts.clear();
                    refresh();
                  },
                  child: Text(
                    "Purshase",
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
      ),
    );
  }
}
