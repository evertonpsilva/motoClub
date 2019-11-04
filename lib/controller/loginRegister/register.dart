import 'package:flutter/material.dart';
import 'package:motoclub/widgets/gradientButton.dart';
import 'package:page_transition/page_transition.dart';
import 'package:motoclub/controller/loginRegister/login.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("aa"),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFfbfbfb),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 85,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.09,),
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
                    Text("Vamos começar!", style: TextStyle(color: Colors.black, fontFamily: 'Arvo',fontWeight: FontWeight.w800, fontSize: 23),),
                    Text("Preencha os dados para criar sua conta", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14),),
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
                          hintText: "Nome",
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
                          prefixIcon: Icon(Icons.mail_outline, color: Colors.black,),
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
                            borderRadius: BorderRadius.all(Radius.circular(30))
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
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirmar senha",
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
                          ),
                          prefixIcon: Icon(Icons.lock_open, color: Colors.black,),
                          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10)
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: GradientButton(
                        onPressed: (){},
                        child: Text("CRIAR",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
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
                padding: EdgeInsets.only(top: 30, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Já possui uma conta? "),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text("Faça o login!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),),
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