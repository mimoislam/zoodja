import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/ui/constats.dart';

class Splash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size=  MediaQuery.of(context).size;
    return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image:AssetImage("assets/Login.png",),
              ),
            ),
          )
    )
         ;
  }
}
