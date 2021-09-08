import 'package:flutter/material.dart';

void pageTurn(Widget widget,context){
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget,));

}