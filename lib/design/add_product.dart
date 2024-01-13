import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login/services/product_services.dart';
import 'package:login/styles.dart';
import 'package:login/model/product.dart';
import 'package:login/model/api_response.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({super.key});

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pictureController = TextEditingController();
  late var _pid;

  Future<void> itemUser() async {

    ApiResponse response = await product(
        _nameController.text,
        _priceController.text,
        _descriptionController.text,
        _pictureController.text
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
        title: Text('Add products'),
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
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: textBoxStyle("Enter product", "Product Name"),
                ),
                Divider(),
                TextFormField(
                  controller: _priceController,
                  decoration: textBoxStyle("Enter price", "Price"),
                ),
                Divider(),
                TextFormField(
                  controller: _descriptionController,
                  obscureText: true,
                  decoration: textBoxStyle("Enter description", "Description"),
                ),
                Divider(),
                TextFormField(
                  controller: _pictureController,
                  obscureText: true,
                  decoration: textBoxStyle("Enter picture link", "Picture Link"),
                ),
                Divider(),
                const SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          itemUser();
                        });
                      }
                    }, child: const Text('Submit')
                )
              ],
            ),
          )
      ),
    );
  }
}
