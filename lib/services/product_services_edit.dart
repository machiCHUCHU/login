import 'dart:convert';
import '../model/api_response.dart';
import 'package:http/http.dart' as http;

import '../model/product.dart';
import '../variables.dart';

Future<ApiResponse> product(String name, String price, String description) async {

  ApiResponse apiResponse = ApiResponse();
  int? pid;

  try{

    final response = await http.post(

        Uri.parse('$ipaddress/product/$pid'),
        headers: {'Accept': 'application/json'},
        body: {
          'name':name,
          'price':price,
          'description':description,
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
        apiResponse.error = "Something went wrong.";
        break;
    }

  } catch(e){
    apiResponse.error = "Something went wrong.";
  }

  return apiResponse;

}