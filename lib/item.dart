import 'dart:io';

import 'package:flutter/material.dart';
import 'services/product_services.dart';
import 'styles.dart';
import 'model/product.dart';

import 'model/api_response.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

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
