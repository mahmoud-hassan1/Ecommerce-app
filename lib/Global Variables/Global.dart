

import 'package:ecommerce_app/model/Product.dart';
import 'package:tuple/tuple.dart';
class Global{
  static List<Tuple2<int,Product>>cartProducts=[];
  static bool dark=false;
  static String? email;
  static String?username;
}