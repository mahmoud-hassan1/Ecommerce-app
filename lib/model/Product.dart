import 'package:ecommerce_app/model/product.dart';

class Product{
   dynamic rating;
   int id,price,stock,discountPercentage;
  final String title,description,brand,category,thumbnail;
  final List<dynamic> images;
  Product(  {required this.rating,required this.id,required this.price,required this.stock,required this.brand,required this.category,required this.thumbnail,required this.images,required this.discountPercentage, required this.description, required this.title}){
  }

  Product.fromJson(Map <String,dynamic>json):
        id=json["id"],
        price=json["price"],
        discountPercentage = (json["discountPercentage"] ?? 0.0).toInt(), 
        rating=json["rating"],
        stock=json["stock"],
        title=json["title"],
        description=json["description"],
        brand=json["brand"],
        category=json["category"],
        thumbnail=json["thumbnail"],
        images=json["images"];
     Map<String, dynamic> toJson() {
       return {
         "id": id,
         "price": price,
         "discountPercentage": discountPercentage,
         "rating": rating,
         "stock": stock,
         "title": title,
         "description": description,
         "brand": brand,
         "category": category,
         "thumbnail": thumbnail,
         "images": images,
       };
     }

}