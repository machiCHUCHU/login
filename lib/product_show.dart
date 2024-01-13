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

class ProductShow extends StatefulWidget {
  const ProductShow({super.key});



  @override
  State<ProductShow> createState() => _ProductShowState();
}

class _ProductShowState extends State<ProductShow> {
Product product = Product();
  ProductSelect productSelect = ProductSelect();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _priceController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
final TextEditingController _idController = TextEditingController();


Future<void> itemEdit(String id) async {

  ApiResponse response = await deleteProduct(
      "$id",
    "hide"
  );
  if(response.error == null){
    print(response.data);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response.data}'))
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('${response.error}')
        )
    );
  }

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
        ),
        body: Form(
          key: _formKey,
          child: FutureBuilder<List>(
            future: productSelect.getAllProduct(),
            builder: (context, snapshot){
              print(snapshot.data);
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, i){
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                              snapshot.data![i]['picture'],
                            height: 50,
                            width: 50,
                          ),
                          trailing: SizedBox(
                            width: 100,
                            height: 50,
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                          Navigator.of(context).push(
                          MaterialPageRoute(
                          builder: (context) => TryApp(
                          snapshot.data![i]['id'].toString(),
                          snapshot.data![i]['name'].toString(),
                          snapshot.data![i]['price'].toString(),
                              snapshot.data![i]['description'].toString(),
                              snapshot.data![i]['picture'].toString(),
                          )
                          )
                          );
                          }, icon: Icon(Icons.edit)),
                                IconButton(onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    setState(() {
                                      itemEdit(snapshot.data![i]['id'].toString(),);
                                    });
                                  }
                                }, icon: Icon(Icons.delete)),
                              ],
                            ),
                          ),
                          title: Text(
                            snapshot.data![i]['name'].toString(),
                            style: TextStyle(
                                fontSize: 30
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data![i]['description'],
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
