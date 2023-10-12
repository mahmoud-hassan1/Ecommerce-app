import 'package:dio/dio.dart';
class Http{
  final dio = Dio();

  Future<dynamic> getHttp() async {
    final response = await dio.get("https://dummyjson.com/products");
    return response.data["products"];
  }
}