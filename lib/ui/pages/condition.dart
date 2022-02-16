import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/ui/constats.dart';


class Condition extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double top=MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: top+20,left: 10,right: 10),
          child:RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Conditions d’Utilisation \n",
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    color: text_color,
                    fontWeight: FontWeight.bold
                  )
                ),
                TextSpan(
                    text: "(Conditions d’Utilisation révisées en date du 08/01/2022)\n",
                    style: GoogleFonts.openSans(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                    )
                ),
                TextSpan(
                    text: "PRÉAMBULE\n",
                    style: GoogleFonts.openSans(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    )
                ),

                TextSpan(
                    text: "Les présentes Conditions d’Utilisation sont conclues entre la société 3 MO éditeur du site et application Zooidja ainsi que les services que le site et l’application proposent,"
                        "ci-après dénommé « Zooidja », et toute personne ayant la qualité de Membre ou"
                        "Abonné au site, applications ainsi qu’aux services que le site et l’application"
                        "proposent (ci-après dénommé « abonné » ou « membre » au singulier, féminin ou"
                        "pluriel.\n"
                        "Zooidja fournie, sur les réseaux de communications électroniques, un ensemble de"
                        "services ayant pour objet de favoriser les annonces pour mariages, rencontres entre"
                        "personnes à des fins personnelles dans le but du mariage, évènements, activités et"
                        "sorties  qui ont pour but de faire rencontrer les membres ou abonnés dans la vie"
                        "réelle à des fins de loisirs culturels, sportifs, pédagogiques ou ludiques comme les"
                        "sorties en groupe, les visites guidées, des ateliers en tout genre comme la cuisine ou"
                        "le bricolage, photo, vidéo.. etc ci-après dénommés « Services ».\n"
                        "Pour chacun des Services, certaines fonctionnalités sont accessibles gratuitement"
                        "par les Membres et d’autres fonctionnalités sont payantes.\n"
                        "En créant un compte, le Membre ou l’Abonné reconnaît qu’il est pleinement informé"
                        "et lié par toutes les dispositions des Conditions d’utilisation, et par toutes conditions"
                        "supplémentaires divulguées et acceptées par le Membre ou l’Abonné lors de la"
                        "création d’un compte et l’utilisation des services, celles-ci constituant un accord entre"
                        "ledit Membre ou Abonné et Zooidja. Dans le cas où un Membre ou un Abonné"
                        "n’accepte pas d’être lié par l’ensemble des modalités de ces Conditions d’utilisation,"
                        "il doit cesser d’utiliser les services.\n"
                        "Les Conditions d’Utilisation sont la propriété de Zooidja. En conséquence, toute"
                        "diffusion, exploitation, représentation, reproduction ou autre utilisation, totale ou"
                        "partielle, sur tout support, des Conditions d’Utilisation à des fins autres que"
                        "strictement personnelles et non professionnelles, est soumise à l’autorisation"
                        "préalable de Zooidja. A défaut de cette autorisation, le contrevenant s’expose aux"
                        "poursuites pénales et civiles prévues par la loi.\n",
                    style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                    )
                ),
                TextSpan(
                    text: "ARTICLE 1. DÉFINITIONS\n",
                    style: GoogleFonts.openSans(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    )
                ),
                TextSpan(
                    text: " « Abonnement » désigne un forfait payant donnant accès à un ou plusieurs services payants, sur une période limitée spécifiée dans l’Abonnement concerné souscrit par un Abonné.\n"
                        "« Membre » désigne un utilisateur d’un ou plusieurs Services ayant créé un compte Zooidja.\n"
                        "« Abonné » désigne un utilisateur d’un ou plusieurs Services ayant créé un compte Zooidja.\n"
                        "« Évènements », « Activités », « Sorties » désigne, indifféremment tout évènement, gratuit ou payant, permettant aux Membres et Abonnés et, le cas échéant à leurs Invités de se rencontrer dans la vie réelle à des fins de loisirs culturels, sportifs, pédagogiques ou ludiques.\n"
                        "« Option », « Service Payant » désigne tout Service exceptionnel nécessitant un accès payant.\n"
                        "« Profil » désigne un espace mis à disposition d’un Membre ou Abonné, comprenant la description qu’un Membre ou Abonné fait de lui-même en incluant des caractéristiques, photos et vidéos et qui est accessible à d’autres Membres et Abonnés.\n"
                        "« Compte » désigne l’interface strictement personnelle accessible aux Membres et aux Abonnés, leur permettant de s’identifier sur Zooidja, de bénéficier des Services auxquels ils se sont inscrits, de renseigner et de modifier leur Profil et, le cas échéant, de renouveler ou modifier l’Abonnement.\n"
                        "« Site », « Application » désigne tout support utilisé par Zooidja (Site internet, application etc…) pour proposer ses services objet des présentes conditions générales.\n"
                        "« Services » désigne l’ensemble des services, payants ou gratuits, accessibles aux Membres ou aux Abonnés, proposés par Zooidja.\n"
                        "« Conditions d’Utilisation » désigne le présent contrat.\n"
                        "\n",
                    style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                    )
                ),

              ]
            ),
          ) ,
        ),
      ),
    );
  }
}
