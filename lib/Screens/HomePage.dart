import 'package:ecommerce_app/Screens/ProductScreen.dart';
import 'package:ecommerce_app/logic/Http.dart';
import 'package:ecommerce_app/logic/ProductRepo.dart';
import 'package:ecommerce_app/model/Product.dart';
import 'package:ecommerce_app/widget/ProductItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Global Variables/Global.dart';
import '../constant/constant.dart';
import 'Cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  List<Product> searchedProducts = [];
  ProductRepo productRepo = ProductRepo();
  final searchTextController=TextEditingController();
  void getData() async {
    products = await productRepo.getData();
    try {
      setState(() {});
    } catch (e) {}
  }

  void searchedForProducts(String title) {
    searchedProducts = products
        .where((product) => product.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
    setState(() { });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            Global.dark ? BackgroundColorDark : BackgroundColorLight,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart()
                  ));
            },
                icon: Icon(Icons.shopping_cart)
            )
          ],
          backgroundColor: Purple,
          title: Container(
            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: searchTextController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              onChanged: (value) {
                searchedForProducts(value);
              },
            ),
          ),
        ),
        //check if we got data befor displaying
        body: products.length == 0
            ? Center(
                child: CircularProgressIndicator(
                  color: Purple,
                ),
              )
            : SafeArea(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount:searchTextController.text.isEmpty? products.length
                      :searchedProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        ((MediaQuery.of(context).size.width - 1 - 10) / 2) /
                            280,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: ProductItem(
                          product:searchTextController.text.isEmpty? products[index]
                              :searchedProducts[index]
                      ),
                      onTap: () async{
                        bool liked = await checkProductLiked(
                            searchTextController.text.isEmpty? products[index]
                            :searchedProducts[index]
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context)=>
                                ProductScreen(
                                product:  searchTextController.text.isEmpty? products[index]
                                    :searchedProducts[index],
                                liked: liked,
                              )

                            ));

                      },
                    );
                  },
                ),
              ));
  }
}
Future<bool> checkProductLiked(Product product) async {
  DocumentSnapshot<Map<String, dynamic>>? data =
  await FirebaseFirestore.instance
      .collection(favouratiesCollection)
      .doc(Global.email)
      .get();

  if (data?.data()?.keys.contains(product.id.toString()) == true) {
    return true;
  } else {
    return false;
  }
}
