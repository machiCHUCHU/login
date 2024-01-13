import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:login/design/login.dart';
import 'package:login/item.dart';
import 'package:login/item_edit.dart';
import 'package:login/product_edit.dart';
import 'package:login/product_show.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/api_response.dart';
import '../model/user.dart';
import '../services/user_services.dart';
import '../user/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _brgyController = TextEditingController();

  bool loading = false;

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

  Future<void> _saveAndRedirectToHome(User user) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token ?? '');
    await prefs.setInt('userId', user.id ?? 0);

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => UserPage()), (route) => false);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 150,
                    ),

                //name textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Name'
                        ),
                        validator: (String? value) {
                          if(value == null || value.isEmpty){
                            return 'Please enter your name!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                //email textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email'
                        ),
                        validator: (String? value) {
                          if(value == null || value.isEmpty || value.length<6){
                            return 'Please enter your email!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                    //password textfield
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password'
                            ),
                            validator: (String? value) {
                              if(value == null || value.isEmpty || value.length<6){
                                return 'Please enter a password!';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                //region textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _regionController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Region'
                        ),
                        validator: (String? value) {
                          if(value == null || value.isEmpty || value.length<6){
                            return 'Please enter your region!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                //province textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _provinceController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Province'
                        ),
                        validator: (String? value) {
                          if(value == null || value.isEmpty || value.length<6){
                            return 'Please enter your province!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                //city textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'City/Municipality'
                        ),
                        validator: (String? value) {
                          if(value == null || value.isEmpty || value.length<6){
                            return 'Please enter your city/municipality!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                //brgy textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _brgyController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Barangay'
                        ),
                        validator: (String? value) {
                          if(value == null || value.isEmpty || value.length<6){
                            return 'Please enter your barangay!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                //sign-up button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Center(
                      child: SizedBox(
                        height: 50,
                        width: 375,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              )
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              setState(() {
                                loading = true;
                                registerUser();
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => const LoginPage()
                                    )
                                );
                              });
                            }
                          },
                        ),
                      )
                  ),
                ),
                SizedBox(height: 25,),


            ],
          ),
        )
    )
    ),
    )
    );
  }
}
