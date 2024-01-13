import 'dart:io';

import 'package:flutter/material.dart';
import 'services/product_services.dart';
import 'styles.dart';
import 'model/product.dart';
import 'product_parse.dart';
import 'model/api_response.dart';

class Product1 extends StatefulWidget {
  var id;
  var stat;

  Product1(this.id, this.stat, {super.key});

  @override
  State<Product1> createState() => _Product1State();
}

class _Product1State extends State<Product1> {

  int editID = 0;
  Product product = Product();
  ProductSelect productSelect = ProductSelect();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _idController = TextEditingController();


  Future<void> itemEdit() async {

    ApiResponse response = await deleteProduct(
      widget.id,
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
    setState(() {
      _loading = !_loading;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit products'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(5.0),
          child: Form(
            key: _formKey,
            child:
                Column(
                  children: [
                    const SizedBox(height: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              itemEdit();
                            });
                          }
                        }, child: const Text('Submit')
                    )
                  ],
            )
          )
      ),
    );
  }
}
