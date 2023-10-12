import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import '../Global Variables/Global.dart';
import '../constant/constant.dart';
import '../logic/helper.dart';
import '../model/Product.dart';
import '../widget/AddtoCart.dart';
import '../widget/ImageList.dart';
import '../widget/RatingBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ProductScreen extends StatefulWidget {
  String? thumpnail;
  final Product product;
  bool liked;

  ProductScreen({Key? key, required this.product, required this.liked}) {
    thumpnail = product.thumbnail;
  }

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int count = 0;
  bool isloading = false;

  void _refresh({String? thump}) {
    setState(() {
      widget.thumpnail = thump;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: Global.dark ? BackgroundColorDark : BackgroundColorLight,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Global.dark ? Colors.white : Colors.black,
          elevation: 0,
          title: Text(
            "Product Details",
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_sharp,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            splashColor: Color.fromRGBO(0, 128, 128, 80),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  setState(() {
                    widget.liked = !widget.liked;
                    isloading = true;
                  });
                  if (widget.liked) {
                    await sendProductToFavouraties(context, widget.product);
                  } else {
                    await deleteProductFromFavouraties(context, widget.product);
                  }
                  setState(() {
                    isloading = false;
                  });
                },
                icon: widget.liked ? Icon(
                  Icons.favorite,
                  color: Color.fromRGBO(189, 0, 0, 1.0),
                )
                    : Icon(
                  Icons.favorite_border_outlined,
                  color: Global.dark ? Colors.white : Colors.black,
                )),
          ],
        ),
        bottomNavigationBar: AddtoCart(product: widget.product ,),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //thumpnail
                Container(
                  margin: EdgeInsets.all(15),
                  height: 200,
                  width: double.infinity,
                  child: ClipRRect(
                    child: Image.network(
                      widget.thumpnail!,
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // the rest of screan
                Container(
                  decoration: BoxDecoration(
                      color: Global.dark ? Color.fromRGBO(66, 66, 66, 160) : Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                  width: double.infinity,
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      //title and price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.title,
                              style: TextStyle(color: Global.dark ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(color: Purple, borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "\$${widget.product.price}",
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      //description
                      Text(
                        widget.product.description,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Global.dark ? Colors.grey.shade50 : Colors.grey, fontSize: 15),
                      ),

                      ImageList(product: widget.product, refresh: _refresh),

                      Ratingbar(rating: widget.product.rating),

                      //stock
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Stock:${widget.product.stock}",
                            style: TextStyle(
                              color: Global.dark ? Colors.grey.shade50 : Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> sendProductToFavouraties(BuildContext context, Product product) async {
  try {
    await FirebaseFirestore.instance.collection(favouratiesCollection).doc(Global.email).update({product.id.toString(): product.toJson()});
  } catch (e) {
    try {
      await FirebaseFirestore.instance.collection(favouratiesCollection).doc(Global.email).set({product.id.toString(): product.toJson()});
    } catch (e) {
      showSnackBar(context, 'Error, Try again');
    }
  }
}

Future<void> deleteProductFromFavouraties(BuildContext context, Product product) async {
  final updates = <String, dynamic>{
    product.id.toString(): FieldValue.delete(),
  };
  FirebaseFirestore.instance.collection(favouratiesCollection).doc(Global.email).update(updates);
}


// zeyad@gmail.com

// 662300
