import '../model/Product.dart';
import 'Http.dart';

class ProductRepo{
  List<Product>products=[];
  Http http_reques=Http();
  Future<List<Product>>getData()async{
    dynamic productsAsJson=await http_reques.getHttp();
    for (dynamic json in productsAsJson){
      Product product=Product.fromJson(json);
      products.add(product);

    }
    print(products);
    return products;
  }
}