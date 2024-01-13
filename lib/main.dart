import 'package:flutter/material.dart';
import 'package:login/item.dart';
import 'package:login/product_picture.dart';

import 'package:login/product_show.dart';
import 'package:login/showpicture.dart';
import 'model/api_response.dart';
import 'register.dart';
import 'services/user_services.dart';
import 'styles.dart';
import 'user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/user.dart';

void main() {
  runApp(const MyLogin());
}

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

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
    await prefs.setString('username', user.name ?? '');

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => UserPage()), (route) => false);

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                  TextFormField(
                    controller: txtEmail,
                    decoration: textBoxStyle("Enter your email", "Email"),
                    validator: (String? value) {
                      if(value == null || value.isEmpty){
                        return 'Please enter your password!';
                      }
                      return null;
                    },
                  ),
                const Divider(),
                TextFormField(
                  controller: txtPassword,
                  obscureText: true,
                  decoration: textBoxStyle("Enter your password", "Password"),
                  validator: (String? value) {
                    if(value == null || value.isEmpty || value.length<6){
                      return 'Please enter your password!';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            loading = true;
                            loginUser();
                          });
                        }
                      },
                    ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Register()
                      )
                    );
                  },
                    child: const Text('Register')),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => AddProduct()
                          )
                      );
                    },
                    child: const Text('Add item')),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ProductShow()
                          )
                      );
                    },
                    child: const Text('Show item')),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => AddPicture()
                          )
                      );
                    },
                    child: const Text('Add picture')),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => PictureShow()
                          )
                      );
                    },
                    child: const Text('Show picture')),
              ],
            ),
          ),
        ),
    );
  }

}

