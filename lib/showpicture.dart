import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/product_edit.dart';
import 'package:login/product_id_show.dart';
import 'package:login/product_parse.dart';
import 'package:login/register.dart';
import 'package:login/services/product_services.dart';
import 'package:login/styles.dart';

import '../model/api_response.dart';
import 'package:http/http.dart' as http;

import '../model/product.dart';
import '../variables.dart';

class PictureShow extends StatefulWidget {
  const PictureShow({super.key});



  @override
  State<PictureShow> createState() => _PictureShowState();
}

class _PictureShowState extends State<PictureShow> {
  Product product = Product();
  ProductSelect productSelect = ProductSelect();
  ProductPicture productPicture = ProductPicture();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _idController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
        ),
        body: Container(
          child: FutureBuilder<List>(
            future: productPicture.getAllPicture(),
            builder: (context, snapshot){
              print(snapshot.data);
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, i){
                      return Card(
                        child: ListTile(
                          title: Image.network(snapshot.data![i]['picture']),
                          subtitle: Text(
                            snapshot.data![i]['id'].toString(),
                            style: TextStyle(
                                fontSize: 30
                            ),
                          ),
                        ),
                      );
                    }
                );
              }else{
                return const Center(
                  child: Text('No data found'),
                );
              }
            },
          ),
        )




    );
  }
}
