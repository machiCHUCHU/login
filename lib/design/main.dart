import 'package:flutter/material.dart';
import 'package:login/design/login.dart';

void main(){
  runApp(const myHome());
}

class myHome extends StatelessWidget {
  const myHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
