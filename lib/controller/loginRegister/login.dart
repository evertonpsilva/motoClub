import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motoclub/controller/loginRegister/register.dart';
import 'package:motoclub/widgets/gradientButton.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFfbfbfb),
          ),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.09,),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Image.asset("images/logo.png",width: 210,),
                    Text("Born to Ride, Ride to Live", style: TextStyle(color: Colors.black, fontFamily: 'Arvo',fontWeight: FontWeight.w800, fontSize: 23),),
                  ],
                ),
              ),
              Form(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "E-mail",
                          hintStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          prefixIcon: Icon(Icons.person_outline, color: Colors.black,),
                          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10)
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Senha",
                          hintStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          prefixIcon: Icon(Icons.lock_open, color: Colors.black,),
                          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10)
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Text("Esqueceu sua senha?"),
                        onTap: (){},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: GradientButton(
                        onPressed: (){},
                        child: Text("ENTRAR",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.grey[800],
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                child: Text("Ou faça login usando"),
                padding: EdgeInsets.only(top: 30, bottom: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 130,
                    child: RaisedButton(
                      elevation: 1,
                      child: Row( 
                        children:[
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              FontAwesomeIcons.facebookF, 
                              size: 16, 
                              color: Colors.white,
                            ),
                          ),
                          Text("Facebook",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)
                        ],
                      ),
                      onPressed: (){},
                      color: Color(0xFF385c8e),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  Container(
                    width: 130,
                    child: RaisedButton(
                      elevation: 1,
                      child: Row( 
                        children:[
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              FontAwesomeIcons.google, 
                              size: 16, 
                              color: Colors.white,
                            ),
                          ),
                          Text("Google",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)
                        ],
                      ),
                      onPressed: (){},
                      color: Color(0xFFf14436),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Não possui uma conta? "),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                      },
                      child: Text("Registrar-se agora!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}