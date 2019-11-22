import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motoclub/controller/loginRegister/login.dart';
import 'package:motoclub/pages/home.dart';

class RouteLogin extends StatefulWidget {
  @override
  _RouteStateLogin createState() => _RouteStateLogin();
}

class _RouteStateLogin extends State<RouteLogin> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future<FirebaseUser> _verifyIfIsLogged() async{
    final FirebaseUser user = await _auth.currentUser();
    if(user == null){
      Future.delayed(Duration(milliseconds: 1500), (){
        Navigator.pushNamed(context, "/login");
      });
    }
    return user;
  }

  Widget route;

  @override
  void initState(){
    super.initState();

    _verifyIfIsLogged().then((user){
      if(user.uid != null || user.uid.isNotEmpty){
        Future.delayed(Duration(milliseconds: 1500), (){
          Navigator.pushNamed(context, "/home");
        });
      }else{
        Future.delayed(Duration(milliseconds: 1500), (){
          Navigator.pushNamed(context, "/login");
        });
      }
    }).catchError((error){
      print("erro" + error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(70)
          ),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        ),
      ),
    );
  }
}