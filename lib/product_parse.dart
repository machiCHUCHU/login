import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/product.dart';
import 'model/api_response.dart';
import 'variables.dart';

Product product = Product();
class ProductSelect{

    String baseUrl = "http://192.168.43.242:9000/api/product_show/";

  Future<List> getAllProduct() async{
    try{
      var response = await http.get(Uri.parse(baseUrl));

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        return Future.error("Server error");
      }
    }
    catch(e){
      return Future.error(e);
    }
  }
}

class ProductPicture{

  String baseUrl = "http://192.168.137.73:9000/api/picshow/";

  Future<List> getAllPicture() async{
    try{
      var response = await http.get(Uri.parse(baseUrl));

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        return Future.error("Server error");
      }
    }
    catch(e){
      return Future.error(e);
    }
  }
}

















/*class ProductSelectId{

  String baseUrl = "http://127.0.0.1:8000/api/product_show/";

  Future<List> getProduct() async{
    try{
      var response = await http.get(Uri.parse('baseUrl'));

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        return Future.error("Server error");
      }
    }
    catch(e){
      return Future.error(e);
    }
  }
}

class ProductUpdate{

  String baseUrl = "http://127.0.0.1:8000/api/product_update/12";

  Future<List> updateProduct() async{
    try{
      var response = await http.post(Uri.parse(baseUrl));

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        return Future.error("Server error");
      }
    }
    catch(e){
      return Future.error(e);
    }
  }
}

 */