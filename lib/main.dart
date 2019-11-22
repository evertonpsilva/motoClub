import 'package:flutter/material.dart';
import 'controller/loginRegister/login.dart';
import 'controller/loginRegister/register.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motoclub/pages/home.dart';
import 'package:motoclub/controller/route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Bikers Club',
      home: RouteLogin(),
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login' : (context) => Login(),
        '/home' : (context) => Home(),
      },
    );
  }
}
