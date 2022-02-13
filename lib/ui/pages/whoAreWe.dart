import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhoAreWe extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double top =MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top:top,),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: double.infinity,
                height: 50,
                decoration:  BoxDecoration(
                    color: Color(0xff213A50)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("Who Are we",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.white),),
                        Container(
                          width: 45,
                          height: 3,
                          color: Color(0xff20A39E),
                        )
                      ]
                      ,
                    ),

                  ],
                ),

              ),

              Container(
                margin: EdgeInsets.only(bottom: 30),
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Text("Zooidja est un ensemble de sites, applications et autres services, fournis par la société 3 MO sur les réseaux de communications électroniques, ayant pour objet de"
                "favoriser les annonces pour mariages, rencontres entre personnes à des fins"
                "personnelles dans le but du mariage, évènements, activités et sorties  qui ont pour"
                "but de faire rencontrer les membres ou abonnés dans la vie réelle à des fins de"
                "loisirs culturels, sportifs, pédagogiques ou ludiques comme les sorties en groupe, les"
                "visites guidées, des ateliers en tout genre comme la cuisine ou le bricolage, photo vidéo. Cette liste de services étant non exhaustive peut être enrichie à tout moment."
                    "Pour toute question, vous pouvez contacter Zooidja sur support@zooidja.com",
                  style: GoogleFonts.openSans(color: Color(0xff18516E),fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
