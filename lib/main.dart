import 'package:flutter/material.dart';
import 'controller/loginRegister/login.dart';
import 'controller/loginRegister/loginRegisterRoot.dart';
import 'package:motoclub/pages/home.dart';
import 'package:motoclub/controller/route.dart';
import 'package:motoclub/controller/authentication.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Bikers Club',
      home: RootPage(auth: new Auth()),
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return PageTransition(child: Home(), type: PageTransitionType.scale);
            break;
          case '/login':
            return PageTransition(child: Login(), type: PageTransitionType.scale);
            break;
          default:
            return null;
        }
      },
    );
  }
}
