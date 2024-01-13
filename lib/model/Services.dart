import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Product.dart';

class Services {
  static const ROOT = 'http://192.168.56.1:8000/api/product/';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';


  static Future<List<Product>> getProduct() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.get(Uri.parse(ROOT));
      print('getProduct Response: ${response.body}');
      print(response.statusCode);
      print(200 == response.statusCode);
      if (200 == response.statusCode) {
        List<Product> list = parseResponse(response.body);
        print(list.length);
        return list;
      } else {
        return <Product>[];
      }
    } catch (e) {
      return <Product>[];
    }
  }

  static List<Product> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    print(parsed);
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }


  static Future<bool> addProduct(String name, String price, String description) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['name'] = name;
      map['price'] = price;
      map['description'] = description;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('addProduct Response: ${response.body}');
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  static Future<bool> updateProduct(String pid, String name, String price, String description) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['pid'] = pid;
      map['name'] = name;
      map['price'] = price;
      map['description'] = description;
      final response = await http.put(Uri.parse(ROOT + pid), body: map);
      print('updateProduct Response: ${response.body}');
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  static Future<bool> deleteProduct(String pid) async {
    try {
      final response = await http.delete(Uri.parse(ROOT + pid));
      print('deleteProduct Response: ${response.body}');
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}