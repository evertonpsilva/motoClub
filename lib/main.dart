import 'package:flutter/material.dart';
import 'controller/loginRegister/login.dart';
import 'controller/loginRegister/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bikers Club',
      home: Login(),
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
