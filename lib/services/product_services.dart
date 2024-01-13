import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';

import '../model/api_response.dart';
import 'package:http/http.dart' as http;

import '../model/product.dart';
import '../variables.dart';

//input response GOOD
Future<ApiResponse> product(String name, String price, String description, String picture) async {
  String? pid;
  ApiResponse apiResponse = ApiResponse();

  try{

    final response = await http.post(
        Uri.parse('$ipaddress/product'),
        headers: {'Accept': 'application/json',
        },
        body: {
          'name':name,
          'price':price,
          'description':description,
          'picture':picture,
        }
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['response'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['message'];
        apiResponse.error = errors;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
    }

  } catch(e){
    apiResponse.error = "Something went wrong.";
  }

  return apiResponse;

}

//update response GOOD
Future<ApiResponse> editProduct(String id,String name, String price, String description, String picture) async {
  ApiResponse apiResponse = ApiResponse();


  try {
    final response = await http.put(Uri.parse('$ipaddress/product_update/$id'),
        headers: {
          'Accept': 'application/json',
        }, body: {
          'name': name,
          'price': price,
          'description': description,
          'picture': picture
        }
        );

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = "unauthorized";
        break;
      case 500:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
    }
  }
  catch (e){
    apiResponse.error = "serverError$e";
  }
  return apiResponse;
}

//testing delete
Future<ApiResponse> deleteProduct(String id, String status) async {
  ApiResponse apiResponse = ApiResponse();


  try {
    final response = await http.put(Uri.parse('$ipaddress/product_delete/$id'),
        headers: {
          'Accept': 'application/json',
        }, body: {
          'id': id,
          'status': status
        }
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = "unauthorized";
        break;
      case 500:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
    }
  }
  catch (e){
    apiResponse.error = "serverError$e";
  }
  return apiResponse;
}


//testing show...
Future<ApiResponse> showProduct() async {
  ApiResponse apiResponse = ApiResponse();


  try {
      final response = await http.get(Uri.parse('$ipaddress/product_show/'));

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = "unauthorized";
        break;
      case 500:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
    }
  }
  catch (e){
    apiResponse.error = "serverError$e";
  }
  return apiResponse;
}

//testing adding picture...
  Future<ApiResponse> addPhoto(XFile picture) async {
  ApiResponse apiResponse = ApiResponse();

  try{

    final response = await http.post(
        Uri.parse('$ipaddress/picture_add'),
        headers: {'Accept': 'application/json',
        },
        body: {
          'picture':picture,
        }
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['response'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['message'];
        apiResponse.error = errors;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
    }

  } catch(e){
    apiResponse.error = "$e";
  }

  return apiResponse;

}