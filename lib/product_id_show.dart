import 'package:flutter/material.dart';
import 'package:login/product_parse.dart';
import 'package:login/services/product_services.dart';
import 'package:login/styles.dart';

import 'model/Product.dart';
import 'model/api_response.dart';

class TryApp extends StatefulWidget {
  var id;
  var name;
  var price;
  var desc;
  var pic;

  TryApp(this.id,this.name, this.price, this.desc, this.pic,{super.key});

  @override
  State<TryApp> createState() => _TryAppState();
}

class _TryAppState extends State<TryApp> {

  int editID = 0;
  Product product = Product();
  ProductSelect productSelect = ProductSelect();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pictureController = TextEditingController();


  Future<void> itemEdit() async {

    ApiResponse response = await editProduct(
      widget.id,
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
              child: Column(
                children: [
                  Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: textBoxStyle("Enter product", widget.name),
                      ),
                      TextFormField(
                        controller: _priceController,
                        decoration: textBoxStyle("Enter price", widget.price),
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: textBoxStyle("Enter description", widget.desc),
                      ),
                      TextFormField(
                        controller: _pictureController,
                        decoration: textBoxStyle("Enter description", widget.pic),
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
                                itemEdit();
                              });
                            }
                          }, child: const Text('Submit')
                      )
                    ],
                  ),
                ],
              )
          )
      ),
    );
  }
}
