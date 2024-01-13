import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:login/design/product_inventory.dart';
import 'package:login/design/signup.dart';
import 'package:login/item.dart';
import 'package:login/item_edit.dart';
import 'package:login/product_edit.dart';
import 'package:login/product_show.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/api_response.dart';
import '../model/user.dart';
import '../services/user_services.dart';
import '../user/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  bool loading = false;

  Future<void> loginUser() async {

    ApiResponse response = await login(txtEmail.text, txtPassword.text);

    if(response.error == null){
      _saveAndRedirectToHome(response.data as User);
    } else {

      setState(() {
        loading = false;
      });

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

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Inventory()), (route) => false);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: const Icon(
                      Icons.shopping_cart,
                      size: 100,
                    ),
                  ),
                  const SizedBox(height: 75,),
                  //shop name
                  Text(
                    'ShopName',
                    style: GoogleFonts.bebasNeue(
                        fontSize: 54
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    'Welcome Shoppers',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  const SizedBox(height: 50,),

                  //email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          controller: txtEmail,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email'
                          ),
                          validator: (String? value) {
                            if(value == null || value.isEmpty){
                              return 'Please enter your password!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          controller: txtPassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password'
                          ),
                          validator: (String? value) {
                            if(value == null || value.isEmpty || value.length<6){
                              return 'Please enter your password!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  //sign-in button
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
                            child: const Text(
                              'Sign In',
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
                                  loginUser();

                                });

                              }
                            },
                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 25,),

                  //registration link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have account yet?'),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const RegisterPage()
                                )
                            );
                          },
                          child: const Text('Register')),
                    ],
                  )
                ],
              ),
            )
          )
        ),
      )
    );
  }
}
