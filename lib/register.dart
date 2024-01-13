import 'package:flutter/material.dart';
import 'services/user_services.dart';
import 'styles.dart';

import 'model/api_response.dart';

class Register extends StatefulWidget {
  const Register( {super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _brgyController = TextEditingController();

  Future<void> registerUser() async {

    ApiResponse response = await register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _regionController.text,
        _provinceController.text,
        _cityController.text,
      _brgyController.text
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
        title: Text('Register User'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(5.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: textBoxStyle("Enter your name", "Name"),
                  ),
                  Divider(),
                  TextFormField(
                    controller: _emailController,
                    decoration: textBoxStyle("Enter your email", "Email"),
                  ),
                  Divider(),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: textBoxStyle("Enter your password", "Password"),
                  ),
                  Divider(),
                  TextFormField(
                    controller: _regionController,
                    obscureText: false,
                    decoration: textBoxStyle("Enter your region", "Region"),
                  ),
                  Divider(),
                  TextFormField(
                    controller: _provinceController,
                    obscureText: false,
                    decoration: textBoxStyle("Enter your province", "Province"),
                  ),
                  Divider(),
                  TextFormField(
                    controller: _cityController,
                    obscureText: false,
                    decoration: textBoxStyle("Enter your city/municipality", "City/Municipality"),
                  ),
                  Divider(),
                  TextFormField(
                    controller: _brgyController,
                    obscureText: false,
                    decoration: textBoxStyle("Enter your barangay", "Barangay"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            registerUser();
                          });
                        }
                      }, child: const Text('Submit')
                  )
                ],
              ),
            )
        ),
      )
    );
  }
}
