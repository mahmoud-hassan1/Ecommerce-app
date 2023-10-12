import 'package:ecommerce_app/model/Product.dart';
import 'package:flutter/cupertino.dart';

class ImageList extends StatefulWidget {
  final Function refresh;
  final Product product;
  const ImageList({Key? key, required this.product, required this.refresh}) : super(key: key);

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  String? thumpnail;
  void performAction(){


        widget.refresh(thump: thumpnail);



  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:widget.product.images.length ,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){


                    thumpnail=widget.product.images[index];
                    performAction();



              },
              child: Container(
                width: 150,
                child: ClipRRect(
                  child:FadeInImage.assetNetwork(
                    placeholder: "assets/images/a47aebcb-8131-42a4-bcb1-09ae5e04efeb.gif",
                    image:widget.product.images[index],fit: BoxFit.fill,

                  ),

                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
