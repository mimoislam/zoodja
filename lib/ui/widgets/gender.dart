import 'package:flutter/material.dart';
import 'package:zoodja/ui/constats.dart';
Widget genderWidget(icon,text,size,selected,onTap,value){
  return GestureDetector(
    onTap: onTap,
    child:  Column(
      children: [

        Container(
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),

            decoration: BoxDecoration(
              color: text_color2.withOpacity(0.4),
            ),
            child: Text(text,style: TextStyle(          color:selected ==value?Colors.white:Color(0xff8969AE)),))
      ],
    ),
  );
}