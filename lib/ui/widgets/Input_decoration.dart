import 'package:flutter/material.dart';

InputDecoration inputDecoration(label){
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide:BorderSide(
        color: Colors.transparent,

      ),

    ),
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),

    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 1,
      ),
    ),
    labelText: label,
  );
}