import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {

  String label;
  TextEditingController controller = TextEditingController();
  Icon prefixIcon;
  bool obscureText;
  TextInputType type;
  Function validator;
  Function onSaved;

  LoginInput({this.label,this.controller, this.prefixIcon, this.obscureText = false, this.type, this.validator, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: TextFormField(
        validator: validator == null ? (value){
          if(value.isEmpty){
            return "Campo não pode ser vazio";
          }
        } : validator,
        controller: controller,
        keyboardType: type,
        onSaved: onSaved == null ? (String noth){} : onSaved,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
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
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10)
        ),
      ),
    );
  }
}