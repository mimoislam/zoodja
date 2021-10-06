import 'package:flutter/material.dart';
Widget iconWidget(icon,onTap,size,color){
  return GestureDetector(

    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(size*0.4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size),
        color: color,
      ),
        child: Icon(icon,size: 20,color: Colors.white,)
    ),
  );
}