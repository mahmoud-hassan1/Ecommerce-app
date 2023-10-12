import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Global Variables/Global.dart';
import '../constant/constant.dart';
import '../model/Product.dart';
import '../widget/ProductItem.dart';
import 'ProductScreen.dart';
import 'package:lottie/lottie.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.dark ? BackgroundColorDark : BackgroundColorLight,
      appBar: AppBar(
          backgroundColor: Purple,
        centerTitle: true,
        title: Text("Favorites"),

      ),

      //check if we got data befor displaying
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(favouratiesCollection).snapshots(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            if(getWidgets(context, snapshot).length==0){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Products found",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Global.dark?Colors.white
                                  :Purple
                          ),
                        ),
                        Icon(
                          Icons.heart_broken_outlined,
                          color: Global.dark?Colors.white
                              :Purple
                        )
                      ],
                    ),
                    Container(
                        height: 100,
                        width: 100,
                        child: Lottie.asset("assets/images/wQF10e0MDS.json")
                    )
                  ],
                ),
              );
            }
            else{
            return SafeArea(
                child: GridView(
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: ((MediaQuery.of(context).size.width - 1 - 10) / 2) / 280,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  children: getWidgets(context, snapshot),
                ));
          }} else {
            return const Center(child: CircularProgressIndicator(
              color: Purple,
            ));
          }
        },
      ),
    );
  }
}

List<Widget> getWidgets(BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
  List<Widget> products = [];

  for (var document in snapshot.data!.docs) {
    if (document.id == Global.email) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      data.forEach((s, d) {
        products.add(
          GestureDetector(
            child: ProductItem(product: Product.fromJson(d)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(liked: true, product: Product.fromJson(d))));
            },
          ),
        );
      });
    }
  }
  return products;
}

