import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/design/add_product.dart';
import 'package:login/product_edit.dart';
import 'package:login/product_id_show.dart';
import 'package:login/product_parse.dart';
import 'package:login/services/product_services.dart';
import 'package:login/styles.dart';

import '../model/api_response.dart';
import 'package:http/http.dart' as http;

import '../model/product.dart';
import '../variables.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});



  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  Product product = Product();
  ProductSelect productSelect = ProductSelect();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _idController = TextEditingController();


  Future<void> itemEdit(String id) async {

    ApiResponse response = await deleteProduct(
        id,
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
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text("Products", style: TextStyle(fontWeight: FontWeight.w600),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))
          ),
          actions: [
            IconButton(onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const NewProduct()
                  )
              );
            }, icon: Icon(Icons.add), iconSize: 30,)
          ],
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        color: Colors.black87,
                        child: ListTile(
                          leading: Image.network(
                            snapshot.data![i]['picture'],
                            height: 50,
                            width: 50,
                          ),
                          trailing: SizedBox(
                            width: 100,
                            height: 30,
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
                                }, icon: Icon(Icons.edit),
                                color: Colors.white,),
                                IconButton(onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    setState(() {
                                      itemEdit(snapshot.data![i]['id'].toString(),);
                                    });
                                  }
                                }, icon: Icon(Icons.delete),
                                color: Colors.white,),
                              ],
                            ),
                          ),
                          title: Text(
                            snapshot.data![i]['name'].toString(),
                            style: TextStyle(
                                fontSize: 20,
                              color: Colors.white
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data![i]['description'],
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                            ),
                          ),
                        ),
                      );
                    }
                );
              }else{
                return const Center(
                  child: Text('No data found', style: TextStyle(color: Colors.white),),
                );
              }
            },
          ),
        )




    );
  }
}
