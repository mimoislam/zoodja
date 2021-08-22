import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/ui/constats.dart';

class Splash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size=  MediaQuery.of(context).size;
    return Scaffold(
          body: Stack(
            children: [
              // Container(
              //
              //     child: Image.asset("assets/dzd.png")),
              Container(
                height: MediaQuery.of(context).size.height,
              width:MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        const Color(0xffF77931),
                        const Color(0xFFF84268),
                      ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                      stops: [0.0, 1.0],
                      ),
                ),

              ),
              Container(
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
                  child: Image.asset("assets/dzd.png")),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/logo.png",height: 100,),
                  Container(
                    width: size.width,
                    child: Center(
                      child: Text(
                              'ZOODJA',
                              style: GoogleFonts.poppins(color: Colors.white,fontSize: size.width*0.15),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    child: Center(
                      child: Text(
                        'Trouver votre paire',
                        style: GoogleFonts.poppins(color: Colors.white,fontSize: size.width*0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
