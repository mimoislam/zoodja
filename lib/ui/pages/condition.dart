import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/ui/constats.dart';


class Condition extends StatefulWidget {
    final String userId;
    Condition({@required String userId}):
            assert(userId !=null),
            userId=userId ;
  @override
  _ConditionState createState() => _ConditionState();
}

class _ConditionState extends State<Condition> {
    bool isChecked = true;

    @override
    Widget build(BuildContext context) {
        double top=MediaQuery.of(context).padding.top;
        Color getColor(Set<MaterialState> states) {
            const Set<MaterialState> interactiveStates = <MaterialState>{
                MaterialState.pressed,
                MaterialState.hovered,
                MaterialState.focused,
            };
            if (states.any(interactiveStates.contains)) {
                return Colors.blue;
            }
            return text_color;
        }

        return Scaffold(
            body: SingleChildScrollView(
                child: Column(
                    children: [
                        Container(
                            padding: EdgeInsets.only(top: top+20,left: 10,right: 10),
                            child:RichText(
                                text: TextSpan(
                                    children: [
                                        TextSpan(
                                            text: "Conditions dâ€™Utilisation \n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 20,
                                                color: text_color,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text: "(Conditions dâ€™Utilisation rĂ©visĂ©es en date du 08/01/2022)\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600
                                            )
                                        ),
                                        TextSpan(
                                            text: "PRĂ‰AMBULE\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),

                                        TextSpan(
                                            text: "Les prĂ©sentes Conditions dâ€™Utilisation sont conclues entre la sociĂ©tĂ© 3 MO Ă©diteur du site et application Zooidja ainsi que les services que le site et lâ€™application proposent,"
                                                "ci-aprĂ¨sÂ dĂ©nommĂ© Â«Â ZooidjaÂ Â», et toute personne ayant la qualitĂ© de Membre ou"
                                                "AbonnĂ© au site, applications ainsi quâ€™aux services que le site et lâ€™application"
                                                "proposent (ci-aprĂ¨s dĂ©nommĂ© Â«Â abonnĂ©Â Â» ou Â«Â membreÂ Â» au singulier, fĂ©minin ou"
                                                "pluriel.\n"
                                                "Zooidja fournie, sur les rĂ©seaux de communications Ă©lectroniques, un ensemble de"
                                                "services ayant pour objet de favoriser les annonces pour mariages, rencontres entre"
                                                "personnes Ă  des fins personnelles dans le but du mariage, Ă©vĂ¨nements, activitĂ©s et"
                                                "sortiesÂ  qui ont pour but de faire rencontrer les membres ou abonnĂ©s dans la vie"
                                                "rĂ©elle Ă  des fins de loisirs culturels, sportifs, pĂ©dagogiques ou ludiques comme les"
                                                "sorties en groupe, les visites guidĂ©es, des ateliers en tout genre comme la cuisine ou"
                                                "le bricolage, photo, vidĂ©o.. etc ci-aprĂ¨s dĂ©nommĂ©s Â«Â ServicesÂ Â».\n"
                                                "Pour chacun des Services, certaines fonctionnalitĂ©s sont accessibles gratuitement"
                                                "par les Membres et dâ€™autres fonctionnalitĂ©s sont payantes.\n"
                                                "En crĂ©ant un compte, le Membre ou lâ€™AbonnĂ© reconnaĂ®t quâ€™il est pleinement informĂ©"
                                                "et liĂ© par toutes les dispositions des Conditions dâ€™utilisation, et par toutes conditions"
                                                "supplĂ©mentaires divulguĂ©es et acceptĂ©es par le Membre ou lâ€™AbonnĂ© lors de la"
                                                "crĂ©ation dâ€™un compte et lâ€™utilisation des services, celles-ci constituant un accord entre"
                                                "ledit Membre ou AbonnĂ© et Zooidja. Dans le cas oĂ¹ un Membre ou un AbonnĂ©"
                                                "nâ€™accepte pas dâ€™Ăªtre liĂ© par lâ€™ensemble des modalitĂ©s de ces Conditions dâ€™utilisation,"
                                                "il doit cesser dâ€™utiliser les services.\n"
                                                "Les Conditions dâ€™Utilisation sont la propriĂ©tĂ© de Zooidja. En consĂ©quence, toute"
                                                "diffusion, exploitation, reprĂ©sentation, reproduction ou autre utilisation, totale ou"
                                                "partielle, sur tout support, des Conditions dâ€™Utilisation Ă  des fins autres que"
                                                "strictement personnelles et non professionnelles, est soumise Ă  lâ€™autorisation"
                                                "prĂ©alable de Zooidja. A dĂ©faut de cette autorisation, le contrevenant sâ€™expose aux"
                                                "poursuites pĂ©nales et civiles prĂ©vues par la loi.\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),
                                        TextSpan(
                                            text: "ARTICLE 1. DĂ‰FINITIONS\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text: " Â« Abonnement Â» dĂ©signe un forfait payant donnant accĂ¨s Ă  un ou plusieurs services payants, sur une pĂ©riode limitĂ©e spĂ©cifiĂ©e dans lâ€™Abonnement concernĂ© souscrit par un AbonnĂ©.\n"
                                                "Â« Membre Â» dĂ©signe un utilisateur dâ€™un ou plusieurs Services ayant crĂ©Ă© un compte Zooidja.\n"
                                                "Â« AbonnĂ© Â» dĂ©signe un utilisateur dâ€™un ou plusieurs Services ayant crĂ©Ă© un compte Zooidja.\n"
                                                "Â« Ă‰vĂ¨nements Â», Â« ActivitĂ©s Â», Â« Sorties Â» dĂ©signe, indiffĂ©remment tout Ă©vĂ¨nement, gratuit ou payant, permettant aux Membres et AbonnĂ©s et, le cas Ă©chĂ©ant Ă  leurs InvitĂ©s de se rencontrer dans la vie rĂ©elle Ă  des fins de loisirs culturels, sportifs, pĂ©dagogiques ou ludiques.\n"
                                                "Â« Option Â», Â« Service Payant Â» dĂ©signe tout Service exceptionnel nĂ©cessitant un accĂ¨s payant.\n"
                                                "Â« Profil Â» dĂ©signe un espace mis Ă  disposition dâ€™un Membre ou AbonnĂ©, comprenant la description quâ€™un Membre ou AbonnĂ© fait de lui-mĂªme en incluant des caractĂ©ristiques, photos et vidĂ©os et qui est accessible Ă  dâ€™autres Membres et AbonnĂ©s.\n"
                                                "Â« Compte Â» dĂ©signe lâ€™interface strictement personnelle accessible aux Membres et aux AbonnĂ©s, leur permettant de sâ€™identifier sur Zooidja, de bĂ©nĂ©ficier des Services auxquels ils se sont inscrits, de renseigner et de modifier leur Profil et, le cas Ă©chĂ©ant, de renouveler ou modifier lâ€™Abonnement.\n"
                                                "Â« Site Â», Â« Application Â» dĂ©signe tout support utilisĂ© par Zooidja (Site internet, application etcâ€¦) pour proposer ses services objet des prĂ©sentes conditions gĂ©nĂ©rales.\n"
                                                "Â« Services Â» dĂ©signe lâ€™ensemble des services, payants ou gratuits, accessibles aux Membres ou aux AbonnĂ©s, proposĂ©s par Zooidja.\n"
                                                "Â« Conditions dâ€™Utilisation Â» dĂ©signe le prĂ©sent contrat.\n"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),

                                        //////// finished Here
                                        TextSpan(
                                            text: "ARTICLE 2. ACCĂˆS, INSCRIPTION ET ABONNEMENT\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text: " Lâ€™inscription aux Services est gratuite.\n\n"
                                                "Lâ€™acceptation des Conditions dâ€™Utilisation lors de lâ€™inscription formalise la conclusion du contrat dâ€™adhĂ©sion aux Services. Elle permet de devenir Membre ou abonnĂ©, de dĂ©couvrir les Services et donne accĂ¨s aux fonctionnalitĂ©s gratuites de ces Services.\n\n"
                                                "Les Services sont exclusivement destinĂ©s aux adultes de plus de 18 ans.\n\n"
                                                "Si un Membre ou un AbonnĂ© a moins de 18 ans, il nâ€™est pas autorisĂ© Ă  utiliser les Services et doit immĂ©diatement en cesser lâ€™utilisation.\n\n"
                                                "En crĂ©ant un Profil et en utilisant les Services, les Membres et les AbonnĂ©s dĂ©clarent et certifient ce qui suit :\n\n"
                                                "â€¢ Ils ont plus de 18 ans et peuvent conclure un contrat juridiquement contraignant avec Zooidja\n"
                                                "â€¢ Ils remplissent les conditions dâ€™inscription Ă©noncĂ©es Ă  tout moment.\n"
                                                "â€¢ Ils se conforment aux prĂ©sentes Conditions dâ€™utilisation et Ă  toutes les lois et rĂ©glementations applicables en AlgĂ©rie.\n"
                                                "â€¢ Ils se conforment aux RĂ¨gles de respect de bienveillant en toutes circonstances vis-Ă -vis de la communautĂ©\n"
                                                "â€¢ Ils fournissent des informations correctes, exactes et vĂ©ridiques ne prĂªtant pas Ă  confusion. En particulier, ils doivent Ăªtre sincĂ¨res et honnĂªtes dans les rĂ©ponses quâ€™ils fournissent sur leur profil et lorsquâ€™ils interagissent avec dâ€™autres utilisateurs ou avec Zooidja.\n"
                                                "â€¢ Ils respectent lâ€™objectif des Services, qui est de permettre de favoriser les annonces pour mariages, rencontres entre personnes Ă  des fins personnelles dans le but du mariage, Ă©vĂ¨nements, activitĂ©s et sorties qui ont pour but de faire rencontrer les membres ou abonnĂ©s dans la vie rĂ©elle Ă  des fins de loisirs culturels, sportifs, pĂ©dagogiques ou ludiques comme les sorties en groupe, les visites guidĂ©es, des ateliers en tout genre comme la cuisine ou le bricolage etc\n"
                                                "â€¢ Ils mettent Ă  jour, suspendent ou modifient rapidement leur profil dans le cas oĂ¹ leur situation personnelle change.\n"
                                                "â€¢ Ils ne se sont pas vus interdits dâ€™utiliser les Services en vertu des lois applicables en AlgĂ©rie.\n\n"
                                                "Zooidja se rĂ©serve le droit de refuser, suspendre ou rĂ©silier lâ€™adhĂ©sion Ă  tout moment si un Membre ou un AbonnĂ© ne remplit aucune de ces conditions.\n\n"
                                                "Il est prĂ©cisĂ© quâ€™un Membre ne peut pas crĂ©er plusieurs Comptes avec les mĂªmes coordonnĂ©e (adresse email, numĂ©ro de tĂ©lĂ©phoneâ€¦).\n\n"
                                                "Une fois inscrit, le Membre complĂ¨te son Profil, les informations Ă©tant fournies Ă  titre facultatif ou obligatoire, le cas Ă©chĂ©ant. Ces informations sont publiĂ©es sur Zooidja et diffusĂ©es auprĂ¨s des autres Membres au travers des Services. La diffusion par le Membre de ses coordonnĂ©es personnelles (adresse Ă©lectronique, adresse postale, tĂ©lĂ©phone, etc.) est expressĂ©ment prohibĂ©e par Zooidja.\n\n"
                                                "Lorsque les conditions nĂ©cessaires Ă  lâ€™inscription sont remplies, chaque Membre dispose dâ€™un identifiant et dâ€™un mot de passe strictement confidentiel et personnel lui permettant dâ€™accĂ©der Ă  son Compte.\n\n"
                                                "Le Membre ou lâ€™AbonnĂ© est responsable de lâ€™utilisation des Ă©lĂ©ments dâ€™identification par des tiers ou des actions ou dĂ©clarations faites par lâ€™intermĂ©diaire de son Compte, quâ€™elles soient frauduleuses ou non, et garantit Zooidja contre toute demande Ă  ce titre, sauf en cas de faute exclusivement imputable Ă  Zooidja ou de dĂ©faillance technique de ses Services. Par ailleurs, Zooidja nâ€™a pas pour obligation et ne sâ€™assure pas de lâ€™identitĂ© des personnes sâ€™inscrivant aux Services. Si le Membre ou lâ€™AbonnĂ© a des raisons de penser quâ€™une personne utilise ses Ă©lĂ©ments dâ€™identification ou son Compte, il devra en informer immĂ©diatement Zooidja.\n\n"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),


                                        TextSpan(
                                            text: "ARTICLE 3. SERVICES PAYANTS \n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:" Lâ€™inscription gratuite ne permet pas dâ€™utiliser toutes les fonctionnalitĂ©s de Zooidja. Selon les Services et sous rĂ©serve des Ă©ventuelles restrictions dĂ©finies par Zooidja, les fonctionnalitĂ©s gratuites incluent notamment la crĂ©ation du Profil, certaines fonctionnalitĂ©s de recherche, la consultation des Profils des autres Membres et lâ€™inscription aux Ă©vĂ¨nements et autres activitĂ©s. La communication avec dâ€™autres Membres peut nĂ©cessiter la souscription Ă  un service payant.\n\n\n"
                                                "Lâ€™accĂ¨s Ă  certains services est payant. Le Membre a la possibilitĂ© de souscrire un Ă  ces services et bĂ©nĂ©ficier de ses fonctionnalitĂ©s et avantages.\n\n"
                                                "Pour ce faire, le Membre doit prĂ©alablement sâ€™identifier Ă  lâ€™aide de ses coordonnĂ©es et de son mot de passe confidentiel. AprĂ¨s avoir choisi lâ€™offre qui le satisfait et son moyen de paiement, le Membre doit valider son paiement. Cette derniĂ¨re Ă©tape formalise la conclusion du contrat dâ€™adhĂ©sion aux Services Payants et lâ€™acceptation sans rĂ©serve de lâ€™intĂ©gralitĂ© des Conditions dâ€™Utilisation. Une fois le paiement validĂ©, lâ€™AbonnĂ© est dirigĂ© vers une page de confirmation de paiement. Zooidja accuse Ă©galement rĂ©ception de lâ€™achat dâ€™un Abonnement par courrier Ă©lectronique.\n"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),

                                        TextSpan(
                                            text: "ARTICLE 4. COMMUNICATION ENTRE LES MEMBRES\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Zooidja exclue expressĂ©ment toute responsabilitĂ© Ă  lâ€™Ă©gard des Ă©vĂ¨nements de toute nature qui pourraient survenir lors de rencontres entre Membres ou AbonnĂ©s sur les Services ou lors de rencontres Â« rĂ©elles Â» entre Membres ou AbonnĂ©s Ă  la suite de lâ€™utilisation des Services.\n\n"
                                                "Lâ€™objet des Services, en ce inclus les Services Payants, nâ€™est pas la fourniture dâ€™un accĂ¨s au rĂ©seau Internet, ni la fourniture dâ€™un service de communication Ă©lectronique au public. En consĂ©quence, Zooidja ne contrĂ´le pas lâ€™identitĂ© rĂ©elle des Membres ou des AbonnĂ©s lorsquâ€™ils se connectent Ă  ses services. Par ailleurs, elle ne contrĂ´le ni ne modĂ¨rent de faĂ§on exhaustive les contenus de toute nature que les Membres et AbonnĂ©s peuvent Ă©diter sur les Services sous leur responsabilitĂ© exclusive.\n\n"
                                                "Dans ce cadre, il est rappelĂ© aux Membres et aux AbonnĂ©s quâ€™il leur est interdit de divulguer aux autres Membres ou AbonnĂ©s, par lâ€™intermĂ©diaire des Services, toute information permettant leur identification ou leur localisation (nom de famille, adresse postale, email, tĂ©lĂ©phoneâ€¦), Ă  lâ€™exception de leur pseudonyme.\n\n"
                                                "En utilisant le Service, les Membres et les AbonnĂ©s doivent respecter Ă  tout moment les rĂ¨gles de conduite suivantes et conviennent de ne pas :\n\n"
                                                "â€¢ Enfreindre les conditions gĂ©nĂ©rales dâ€™utilisation, mises Ă  jour rĂ©guliĂ¨rement.\n"
                                                "â€¢ Publier leurs coordonnĂ©es personnelles ou diffuser les informations personnelles dâ€™une autre personne (adresse e-mail, adresse postale, numĂ©ro de tĂ©lĂ©phone, etc.) de quelque maniĂ¨re que ce soit (dans une description de profil, sur une photo, etc.)\n"
                                                "â€¢ Publier tout contenu qui viole ou enfreint les droits dâ€™autrui, y compris ceux relatifs Ă  la publicitĂ©, vie privĂ©e, droits dâ€™auteur, marques dĂ©posĂ©es ou tout autre droit de propriĂ©tĂ© intellectuelle ou contractuel.\n"
                                                "â€¢ Usurper lâ€™identitĂ© de toute personne ou entitĂ©.\n"
                                                "â€¢ Solliciter des mots de passe Ă  quelque fin que ce soit ou des informations dâ€™identification personnelle Ă  des fins commerciales ou illĂ©gales auprĂ¨s dâ€™autres Membres ou AbonnĂ©s.\n"
                                                "â€¢ Spammer, demander de lâ€™argent ou escroquer un Membre ou un AbonnĂ©."
                                                "â€¢ Publier tout contenu Ă  caractĂ¨re haineux, menaĂ§ant, sexuellement explicite ou pornographique ; qui incite Ă  la violence ou contient de la nuditĂ© ou de la violence explicite ou gratuite ou contraire aux prĂ©ceptes de lâ€™islam et des valeurs nationales algĂ©riennes."
                                                "â€¢ Publier tout contenu qui porte atteinte aux valeurs morales et symboles de la nation algĂ©rienne.\n"
                                                "â€¢ Publier tout contenu qui promeuve le racisme, le sectarisme, la haine ou les dommages physiques de quelque nature que ce soit contre un groupe ou un individu.\n"
                                                "â€¢ Malmener, Â« traquer Â», intimider, agresser, harceler, maltraiter ou diffamer toute personne.\n"
                                                "â€¢ Utiliser les Services Ă  des fins nuisibles ou malveillantes.\n"
                                                "â€¢ Utiliser les Services afin de nuire Ă  Zooidja.\n"
                                                "â€¢ Utiliser les Services Ă  des fins illĂ©gales ou interdites par la loi algĂ©rienne applicable dans le prĂ©sent contrat ainsi que les prĂ©sentes Conditions dâ€™utilisation.\n"
                                                "â€¢ Utiliser tout(e) logiciels, scripts, robots ou tout autre moyen ou processus (notamment des robots dâ€™indexation, des modules dâ€™extension de navigateur et complĂ©ments, ou toute autre technologie) visant Ă  accĂ©der, extraire, indexer, fouiller les donnĂ©es ou reproduire ou Ă©luder de quelque faĂ§on que ce soit la structure de navigation ou la prĂ©sentation du Service ou de ses contenus.\n"
                                                "â€¢ Utiliser le compte dâ€™un autre utilisateur, partager un compte avec un autre utilisateur ou gĂ©rer plusieurs comptes.\n"
                                                "â€¢ CrĂ©er un autre compte si Zooidja a dĂ©jĂ  rĂ©siliĂ© leur compte, Ă  moins que le Membre ou lâ€™AbonnĂ© nâ€™ait lâ€™autorisation de Zooidja.\n"
                                                "â€¢ Utiliser les Services de mauvaise foi.\n\n"
                                                "Une violation par un Membre ou un AbonnĂ© de lâ€™une de ces rĂ¨gles de conduite constitue une violation grave de ses obligations contractuelles en vertu des prĂ©sentes Conditions dâ€™utilisation.\n\n"
                                                "Zooidja se rĂ©serve le droit de rĂ©silier le compte dâ€™un Membre ou dâ€™un AbonnĂ© sans aucun remboursement des Services payants en cas de violation des prĂ©sentes obligations, dâ€™utilisation abusive des Services ou de comportement, action ou communication inappropriĂ© ou illĂ©gal survenu dans le cadre de lâ€™utilisation des Services ou non. En outre, Zooidja peut interdire dĂ©finitivement ou temporairement son accĂ¨s Ă  lâ€™un de ses Services, Ă‰vĂ©nements ou ActivitĂ©s.\n"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),



                                        TextSpan(
                                            text: "ARTICLE 5. PRIX, MODALITĂ‰S DE PAIEMENT ET DE RENOUVELLEMENT\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Les prix et les modalitĂ©s de paiement sont dĂ©crits sur les offres de services payants de Zooidja.\n\n"
                                                "Vous pouvez mettre Ă  jour votre mode de paiement Ă  tout moment. Zooidja peut Ă©galement les mettre Ă  jour sur la base dâ€™informations directement fournies par le prestataire de service de paiement.\n\n"
                                                "Ainsi, Zooidja informera lâ€™AbonnĂ©, par courrier Ă©lectronique ou notification de la fin de lâ€™Abonnement initial.\n\n"
                                                "En outre, une information sur lâ€™Ă©chĂ©ance de lâ€™Abonnement dâ€™un AbonnĂ© est fournie aux AbonnĂ©s dans la rubrique Â« Mon Compte Â», qui leur permet de gĂ©rer leur Abonnement et, le cas Ă©chĂ©ant \n"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),



                                        TextSpan(
                                            text: "ARTICLE 6. PROPRIĂ‰TĂ‰ INTELLECTUELLE\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text: "6.1. Contenus diffusĂ©s sur les Services\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Les dĂ©nominations des Services, les marques, les logos, les graphismes, les photographies, les animations, les vidĂ©os et les textes contenus sur Zooidja  et dans les Services sont la propriĂ©tĂ© exclusive de Zooidja et le cas Ă©chĂ©ant de ses partenaires et ne peuvent Ăªtre reproduits, utilisĂ©s ou reprĂ©sentĂ©s sans lâ€™autorisation expresse des sociĂ©tĂ©s de Zooidja ou de leurs partenaires, sous peine de poursuites judiciaires.\n\n"
                                                "Les droits dâ€™utilisation concĂ©dĂ©s au Membre et Ă  lâ€™AbonnĂ© sont rĂ©servĂ©s Ă  un usage privĂ© et personnel dans le cadre et pour la durĂ©e de lâ€™inscription aux Services. Toute autre utilisation par le Membre ou lâ€™AbonnĂ© est interdite.\n\n"
                                                "Le Membre ou lâ€™AbonnĂ© sâ€™interdit notamment de modifier, copier, reproduire, tĂ©lĂ©charger, diffuser, transmettre, exploiter commercialement et/ou distribuer de quelque faĂ§on que ce soit les Services, les pages des Sites, ou les codes informatiques des Ă©lĂ©ments composant les Services et les Sites, sous peine de poursuites judiciaires.\n"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),



                                        TextSpan(
                                            text: "6.2. Contenus diffusĂ©s par les Membres et AbonnĂ©s\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Le Membre ou lâ€™AbonnĂ© concĂ¨de Ă  Zooidja une licence dâ€™utilisation des droits de propriĂ©tĂ© intellectuelle attachĂ©s aux contenus fournis par lui dans le cadre de son inscription ou Abonnement et de son utilisation des Services ou de la diffusion de son Profil sur les Services. Cette licence comprend notamment le droit pour Zooidja de reproduire, reprĂ©senter, adapter, traduire, numĂ©riser, utiliser aux fins des Services ou de sous-licencier les contenus fournis par le Membre ou lâ€™AbonnĂ© (informations, images, description, critĂ¨res de recherche, etc.), sur tout ou partie des Services et sur lâ€™ensemble des Sites, dans les mailings des sociĂ©tĂ©s de Zooidja et de maniĂ¨re gĂ©nĂ©rale sur tous supports de communication Ă©lectronique (e-mail, Internet, application mobile) dans le cadre des Services.\n\n"
                                                "Le Membre ou lâ€™AbonnĂ© autorise expressĂ©ment Zooidja Ă  modifier lesdits contenus afin de respecter la charte graphique des Services ou des autres supports de communication visĂ©s ci-dessus et/ou de les rendre compatibles avec ses performances techniques ou les formats des supports concernĂ©s. Ces droits sont concĂ©dĂ©s pour le monde entier et pour une durĂ©e de 99 ans . Le Membre ou lâ€™AbonnĂ© sâ€™interdit de copier, reproduire, ou autrement utiliser les contenus relatifs aux autres Membres et AbonnĂ©s autrement que pour les stricts besoins dâ€™utilisation des Services Ă  des fins personnelles et privĂ©es.\n"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),


                                        TextSpan(
                                            text: "ARTICLE 7. RESPONSABILITĂ‰ ET GARANTIE\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),


                                        TextSpan(
                                            text: "7.1. Fonctionnement des Sites et des Services\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"7.1.1 Pour utiliser les Services, le Membre ou lâ€™AbonnĂ© doit disposer des compĂ©tences, des Ă©quipements et des logiciels requis pour lâ€™utilisation dâ€™Internet ou des applications mobiles des Services. Zooidja met en place des mesures de sĂ©curitĂ© dans le cadre de lâ€™utilisation de ses Services. Pour autant, le Membre ou lâ€™AbonnĂ© reconnaĂ®t que les caractĂ©ristiques et les contraintes dâ€™Internet ne permettent pas de garantir une sĂ©curitĂ© absolue sur Internet ou via les applications mobiles.\n\n"
                                                "7.1.2 Le Membre ou lâ€™AbonnĂ© doit possĂ©der lâ€™Ă©quipement, en ce inclus les logiciels et les paramĂ©trages adĂ©quats, nĂ©cessaires au bon fonctionnement des Services : version la plus rĂ©cente du navigateur Internet, activation des fonctions Java script, rĂ©ception de cookies de session et acceptation de lâ€™affichage de fenĂªtres Â« pop-ups Â».\n\n"
                                                "7.1.3 Zooidja ne garantit pas que les Services seront utilisables si le Membre ou lâ€™AbonnĂ© utilise un utilitaire de Â« pop-up killer Â» ou Ă©quivalent ; dans ce cas, cette fonction devra Ăªtre dĂ©sactivĂ©e prĂ©alablement Ă  lâ€™utilisation des Services.\n\n"
                                                "7.1.4 Zooidja ne garantit pas que les Services seront utilisables si le fournisseur dâ€™accĂ¨s Internet du Membre ou de lâ€™AbonnĂ© est dĂ©faillant dans lâ€™accomplissement de sa propre prestation. De mĂªme, le cas Ă©chĂ©ant lâ€™utilisation des applications pour smartphones souscrites par le Membre ou lâ€™AbonnĂ© directement auprĂ¨s du fournisseur de lâ€™application suppose que ce dernier dispose dâ€™un smartphone et dâ€™une connexion appropriĂ©e.\n\n"
                                                "7.1.5 Zooidja nâ€™est pas responsable dâ€™un dysfonctionnement, dâ€™une impossibilitĂ© dâ€™accĂ¨s ou de mauvaises conditions dâ€™utilisation des Sites et Services imputables Ă  un Ă©quipement non adaptĂ©, Ă  des dysfonctionnements internes au fournisseur dâ€™accĂ¨s du Membre ou de lâ€™AbonnĂ©, Ă  lâ€™encombrement du rĂ©seau Internet, et pour toutes autres raisons extĂ©rieures Ă  Zooidja ayant le caractĂ¨re dâ€™un cas de force majeure.\n\n"
                                                "7.1.6 Lâ€™exploitation des Services pourra Ăªtre momentanĂ©ment interrompue pour cause de maintenance, de mise Ă  jour ou dâ€™amĂ©liorations techniques, ou pour en faire Ă©voluer le contenu et/ou la prĂ©sentation. Dans la mesure du possible, Zooidja informera les Membres et AbonnĂ©s prĂ©alablement Ă  une opĂ©ration de maintenance ou de mise Ă  jour susceptible dâ€™impacter les Services.\n"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),



                                        TextSpan(
                                            text: "7.2. Informations et contenus fournis par les Membres\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"7.2.1. Les informations fournies par un Membre ou un AbonnĂ© Ă  Zooidja doivent Ăªtre exactes et conformes Ă  la rĂ©alitĂ©. Les consĂ©quences de leur divulgation sur sa vie et/ou celle des autres Membres et AbonnĂ©s sont de la responsabilitĂ© exclusive du Membre ou de lâ€™AbonnĂ© concernĂ©. Le Membre ou lâ€™AbonnĂ© prend lâ€™initiative de divulguer et de diffuser via les Services des informations, donnĂ©es, textes, contenus et images le concernant. En consĂ©quence, il renonce Ă  tout recours Ă  lâ€™encontre de Zooidja, notamment sur le fondement de lâ€™atteinte Ă©ventuelle Ă  son droit Ă  lâ€™image, Ă  son honneur, Ă  sa rĂ©putation, Ă  lâ€™intimitĂ© de sa vie privĂ©e, rĂ©sultant de la diffusion ou de la divulgation dâ€™informations le concernant dans les conditions prĂ©vues par la Politique de ConfidentialitĂ© dans la mesure oĂ¹ le Membre ou lâ€™AbonnĂ© a prĂ©alablement, librement et explicitement consenti Ă  une telle divulgation du fait de son inscription ou abonnement aux Services, en application des Conditions dâ€™Utilisation.\n\n"
                                                "7.2.2. Zooidja ne peut Ăªtre tenue pour responsable de lâ€™exactitude ou de lâ€™inexactitude des informations et contenus fournis par les autres Membres, les autres AbonnĂ©s et/ou le Membre ou lâ€™AbonnĂ© lui-mĂªme, ni des consĂ©quences dĂ©coulant de lâ€™utilisation de ces informations et contenus. De mĂªme, Zooidja ne peut Ăªtre tenue pour responsable des contenus diffusĂ©s par un Membre ou un AbonnĂ© susceptibles de contrevenir aux droits dâ€™un ou plusieurs autres Membres, AbonnĂ©s ou tiers et dont Zooidja rapporterait la preuve quâ€™elle nâ€™en aurait pas Ă©tĂ© informĂ©e par un Membre, AbonnĂ© ou par un tiers ou nâ€™en aurait pas eu une connaissance effective et prĂ©alable avant sa diffusion ou quâ€™il nâ€™aurait pas commis de faute dans lâ€™exĂ©cution de ses obligations contractuelles au titre des Conditions dâ€™Utilisation.\n\n"
                                                "7.2.3. La qualitĂ© des Services exigĂ©e tant par Zooidja que par ses Membres et AbonnĂ©s suppose le respect dâ€™une certaine Ă©thique dans lâ€™expression et le comportement des Membres et AbonnĂ©s, le respect des droits des tiers, ainsi que le respect des lois et rĂ¨glements en vigueur. Au service de cette exigence de qualitĂ©, de responsabilitĂ© individuelle et dâ€™Ă©thique, le Zooidja permet Ă  tout Membre et AbonnĂ© de lui signaler tous contenus (photographie, texte, vidĂ©o), comportements ou propos dâ€™un Membre ou dâ€™un AbonnĂ© qui lui paraissent porter atteinte aux lois et rĂ¨glements en vigueur, aux prĂ©ceptes de lâ€™islam, ou aux symboles de la nation, Ă  lâ€™image ou Ă  lâ€™objet des Services, aux droits dâ€™un tiers ou aux bonnes mÅ“urs.\n\n"
                                                "En consĂ©quence, les Membres et AbonnĂ©s reconnaissent et acceptent que les donnĂ©es quâ€™ils fournissent, ainsi que leurs comportements ou leurs propos via les Services sont susceptibles de faire lâ€™objet dâ€™un signalement par dâ€™autres Membres ou AbonnĂ©s et dâ€™une modĂ©ration et/ou dâ€™un contrĂ´le par le Zooidja, sur la base de critĂ¨res dâ€™apprĂ©ciation objectifs. Dans lâ€™hypothĂ¨se oĂ¹ ce signalement ou ce contrĂ´le rĂ©vĂ©lerait la violation par un Membre ou par un AbonnĂ© des lois et rĂ¨glements en vigueur ou de ses obligations contractuelles au titre des Conditions dâ€™Utilisation, Zooidja pourra exclure ledit Membre ou AbonnĂ© conformĂ©ment Ă  lâ€™article 9 ci-aprĂ¨s. Selon le comportement ou les propos des Membres et AbonnĂ©s, lâ€™Ă©quipe de surveillance peut prendre la dĂ©cision de bloquer toute nouvelle inscription par la personne concernĂ©e.\n\n"
                                                "7.2.4. Dans le cas oĂ¹ la responsabilitĂ© du Zooidja serait recherchĂ©e Ă  raison dâ€™un manquement par un Membre ou un AbonnĂ© aux obligations qui lui incombent aux termes de la loi ou des Conditions dâ€™Utilisation, ce dernier sâ€™engage Ă  garantir le Zooidja contre tous dommages, frais ou condamnations prononcĂ©s Ă  son encontre trouvant leur origine dans le manquement imputĂ© au Membre ou Ă  lâ€™AbonnĂ©."
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),




                                        TextSpan(
                                            text: "7.3. Liens et ressources externes\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Zooidja est uniquement responsable des liens hypertextes quâ€™elle crĂ©e au sein des Sites et Services et nâ€™exerce aucun contrĂ´le des Sites Tiers et des sources externes (sites ou applications mobiles de tiers, rĂ©seaux sociaux, etc.) vers lesquels redirigent les liens hypertextes accessibles sur ses Sites et ses Services. Zooidja ne peut Ăªtre tenue responsable de la mise Ă  disposition de liens dirigeant vers les Sites Externes et ne peut supporter aucune responsabilitĂ© quant aux contenus, publicitĂ©s, produits, fonctionnalitĂ©s, services ou autres Ă©lĂ©ments disponibles sur ou Ă  partir de ces Sites Tiers dont il ne lui aurait pas Ă©tĂ© fait mention, prĂ©alablement et effectivement, de leur caractĂ¨re manifestement illicite, au moyen dâ€™une notification conforme Ă  la rĂ¨glementation en vigueur. Il est rappelĂ© que la consultation et lâ€™utilisation de Sites Tiers sont rĂ©gies par les conditions dâ€™utilisation de ceux-ci, et quâ€™elles sâ€™effectuent sous lâ€™entiĂ¨re responsabilitĂ© du Membre ou de lâ€™AbonnĂ©.\n\n"
                                                "Toute difficultĂ© relative Ă  un lien doit Ăªtre signalĂ©e Ă  Zooidja  au mail support@zooidja.com"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),




                                        TextSpan(
                                            text: "ARTICLE 8. SUSPENSION DU PROFIL â€“ SUPPRESSION DU COMPTE â€“\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text: "8.1 Suspension du Profil\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Cette section ne sâ€™applique quâ€™aux Sites pour lesquels cette fonctionnalitĂ© est disponible.\n\n"
                                                "Chaque Membre ou AbonnĂ© peut Ă  tout moment demander la suspension de son Profil, notamment via la rubrique Â« Mon Compte Â» dĂ©diĂ©e Ă  cet effet, afin de ne plus Ăªtre visible sur les Sites et ne plus recevoir de notifications. Cette suspension est temporaire et nâ€™interrompt pas lâ€™Abonnement et les Ă©ventuelles Options en cours. Le Membre ou lâ€™AbonnĂ© peut rĂ©activer son Profil Ă  tout moment.\n\n"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),




                                        TextSpan(
                                            text: "8.2 Suppression du Compte\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Chaque Membre ou AbonnĂ© peut Ă  tout moment mettre fin Ă  son inscription aux Services ou Ă  son Abonnement en demandant la clĂ´ture de son Compte auprĂ¨s de Zooidja, sans frais autres que ceux liĂ©s Ă  la transmission de sa demande et sans motif, notamment via la rubrique Â« Mon Compte Â», par email, formulaire de contact ou par tout moyen qui pourra lui Ăªtre indiquĂ© dans cette rubrique. Cette demande sera rĂ©putĂ©e effectuĂ©e le jour ouvrĂ© suivant la rĂ©ception par Zooidja de la demande de clĂ´ture du Compte concernĂ©, et lâ€™AbonnĂ© ne pourra plus utiliser son Abonnement et les Ă©ventuelles Options en cours. Cette demande ne donne pas droit au remboursement Ă  lâ€™AbonnĂ© de la pĂ©riode restant Ă  courir jusquâ€™Ă  lâ€™Ă©chĂ©ance de son Abonnement et des Ă©ventuelles Options en cours. Le Membre ou lâ€™AbonnĂ© sera informĂ© par courrier Ă©lectronique de la suppression de son Compte.\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),



                                        TextSpan(
                                            text: "8.3 RĂ©siliation par Zooidja\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Sans prĂ©judice des autres dispositions des Conditions dâ€™Utilisation, en cas de manquement dâ€™un AbonnĂ© ou Membre Ă  ses obligations, Zooidja pourra supprimer dĂ©finitivement le ou les Comptes du Membre ou de lâ€™AbonnĂ© concernĂ© au sein de lâ€™ensemble des Sites, rĂ©voquer lâ€™accĂ¨s aux Services et Ă  tout autre service fourni par le Zooidja, sans prĂ©avis ni mise en demeure. Cette suppression nâ€™emporte le droit au remboursement de lâ€™AbonnĂ©. Le Membre ou lâ€™AbonnĂ© sera informĂ© par courrier Ă©lectronique de la suppression de son Compte.\n\n"
                                                "Cette suppression interviendra sans prĂ©judice de tous les dommages et intĂ©rĂªts qui pourraient Ăªtre rĂ©clamĂ©s par Zooidja au Membre ou Ă  lâ€™AbonnĂ© ou ses ayants droit et reprĂ©sentants lĂ©gaux en rĂ©paration des prĂ©judices subis par Zooidja du fait de tels manquements.\n\n"
                                                "Dans le cas de la fermeture des services Zooidja, pour raison financiĂ¨res, par dĂ©cision de justice ou pour un cas de force majeur, les comptes seront de facto supprimĂ© ou suspendus et les membres ne pourront en aucun y accĂ©der.\n\n"
                                                "Cette fermeture inclus les services payants souscrits par les membres.\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),



                                        TextSpan(
                                            text: "ARTICLE 9. EVENEMENTS ET AUTRES ACTIVITĂ‰S\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Lorsque des Ă©vĂ¨nements ou ActivitĂ©s sont proposĂ©s aux Membres et AbonnĂ©s sur les Sites et autres services Zooidja, des conditions gĂ©nĂ©rales spĂ©cifiques sont applicables. Vous pouvez les consulter sur les pages dĂ©crivant les Ă©vĂ¨nements ou ActivitĂ©s.\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),



                                        TextSpan(
                                            text: "ARTICLE 10. DONNĂ‰ES PERSONNELLES\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Le Membre ou lâ€™AbonnĂ© concĂ¨de Ă  Zooidja une licence dâ€™utilisation des droits de propriĂ©tĂ© intellectuelle attachĂ©s aux contenus fournis par lui dans le cadre de son inscription ou Abonnement et de son utilisation des Services ou de la diffusion de son Profil sur les Services. Cette licence comprend notamment le droit pour Zooidja de reproduire, reprĂ©senter, adapter, traduire, numĂ©riser, utiliser aux fins des Services ou de sous-licencier les contenus fournis par le Membre ou lâ€™AbonnĂ© (informations, images, description, critĂ¨res de recherche, etc.), sur tout ou partie des Services et sur lâ€™ensemble des Sites, dans les mailings des sociĂ©tĂ©s de Zooidja et de maniĂ¨re gĂ©nĂ©rale sur tous supports de communication Ă©lectronique (e-mail, Internet, application mobile) dans le cadre des Services.\n\n"
                                                "Cette licence comprend Ă©galement le droit pour Zooidja dâ€™utiliser les informations fournies par lui dans le cadre de son inscription ou Abonnement Ă  des fins de publicitĂ© diffusĂ©e par Zooidja ou par un tiers partenaire.\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),




                                        TextSpan(
                                            text: "ARTICLE 11. INTĂ‰GRALITĂ‰ DE LA CONVENTION\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Les Conditions dâ€™Utilisation constituent un contrat rĂ©gissant les relations entre le Membre ou lâ€™AbonnĂ© et Zooidja. Elles annulent et remplacent toutes les dispositions antĂ©rieures non expressĂ©ment visĂ©es ou annexĂ©es et constituent lâ€™intĂ©gralitĂ© des droits et obligations de Zooidja, et du Membre ou de lâ€™AbonnĂ© relatifs Ă  leur objet.\n\n"
                                                "Si une ou plusieurs stipulations des Conditions dâ€™Utilisation Ă©taient dĂ©clarĂ©es nulles en application dâ€™une loi, dâ€™un rĂ¨glement ou Ă  la suite dâ€™une dĂ©cision dĂ©finitive dâ€™une juridiction ou autoritĂ© compĂ©tente, les autres stipulations garderont toute leur force et leur portĂ©e, dans la mesure permise par la loi, le rĂ¨glement ou la dĂ©cision applicable.\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),




                                        TextSpan(
                                            text: "ARTICLE 12. MODIFICATION DES SERVICES ET DES CONDITIONS Dâ€™UTILISATION\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text: "12.1 Modification des Services\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Zooidja pourra faire Ă©voluer et modifier Ă  tout moment le contenu et/ou les fonctionnalitĂ©s des Services afin dâ€™en amĂ©liorer la qualitĂ©. Le Membre ou AbonnĂ© sera informĂ© de la nature de ces Ă©volutions ou modifications dĂ¨s leur mise en ligne sur les Sites directement sur les supports concernĂ©s, utilisĂ©s par Zooidja ou par e-mail."
                                                "\n\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),




                                        TextSpan(
                                            text: "12.2 Modification des Conditions dâ€™Utilisation\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Zooidja pourra modifier Ă  tout moment les Conditions dâ€™Utilisation. Le Membre ou lâ€™AbonnĂ© sera informĂ© de ces modifications dĂ¨s leur mise en ligne directement sur les supports concernĂ©s, utilisĂ©s par Zooidja ou par e-mail."
                                                "Toute nouvelle inscription ou souscription dâ€™Abonnement est soumise aux Conditions dâ€™Utilisation alors en vigueur.\n\n"
                                                "Les AbonnĂ©s inscrits antĂ©rieurement Ă  la modification des Conditions dâ€™Utilisation auront le choix entre deux options :\n\n"
                                                "â€¢ Lâ€™AbonnĂ© peut accepter directement les nouvelles Conditions dâ€™Utilisation ; celles-ci lui seront opposables Ă  compter de lâ€™acceptation.\n"
                                                "â€¢ Lâ€™AbonnĂ© peut exiger le maintien des Conditions dâ€™Utilisation qui Ă©taient en vigueur lors de la souscription de son Abonnement, jusquâ€™Ă  lâ€™Ă©chĂ©ance de lâ€™Abonnement.\n"
                                                "A dĂ©faut de retour de lâ€™AbonnĂ© dans le dĂ©lai dâ€™un (1) mois aprĂ¨s leur entrĂ©e en vigueur, les Conditions dâ€™Utilisation modifiĂ©es seront rĂ©putĂ©es acceptĂ©es par lâ€™AbonnĂ©.\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),



                                        TextSpan(
                                            text: "ARTICLE 13. DEMANDE ET RĂ‰CLAMATION\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Pour toute demande ou rĂ©clamation relative Ă  un Membre ou AbonnĂ©, celui-ci peut contacter Zooidja par courrier postal adressĂ© Ă  Zooidja sis chez Bab 08,  08 rue Didouche Mourad, Alger.\n\n"
                                                "Le Membre ou AbonnĂ© peut Ă©galement contacter le Service Client par courrier Ă©lectronique ou par tĂ©lĂ©phone : support@zooidja.com\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),



                                        TextSpan(
                                            text: "ARTICLE 14 â€“ DROIT APPLICABLE â€“ LITIGES\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Ces Conditions dâ€™Utilisation sont rĂ©gies et sâ€™interprĂ¨tent conformĂ©ment au droit AlgĂ©rien. La langue dâ€™interprĂ©tation est le franĂ§ais.\n\n"
                                                "Dans le cas oĂ¹ un accord amiable ne pourrait Ăªtre trouvĂ© en cas de litige relatif aux Conditions dâ€™Utilisation, les juridictions compĂ©tentes seront les tribunaux dâ€™Alger.\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),




                                        TextSpan(
                                            text: "ARTICLE 15. QUI SOMMES-NOUS ?\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Les Services fournis par Zooidja aux Membres et AbonnĂ©s en application des prĂ©sentes Conditions dâ€™Utilisation, sont Ă©ditĂ©s par 3 MO SARL domiciliĂ©e Ă  Bab 08, 08 rue Didouche Mourad, Alger.\n\n"
                                                "Pour toute question, vous pouvez contacter Zooidja sur support@zooidja.com\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),

                                    ]
                                ),
                            ) ,
                        ),
                        widget.userId!="0"?Row(
                            children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                    value: isChecked,
                                    onChanged: (bool value) {
                                        isChecked = value;
                                        setState(() {

                                        });
                                    },
                                ),
                                Text("Do You accept This Condition ?",style: GoogleFonts.openSans(fontSize: 15,fontWeight: FontWeight.bold),)
                            ],
                        ):Container(),
                        widget.userId!="0"?GestureDetector(
                            onTap: (){
                              if(isChecked)
                              BlocProvider.of<AuthenticationBloc>(context).add(GotoCreation(widget.userId));
                            else
                                BlocProvider.of<AuthenticationBloc>(context).add(ToOnBoarding());

                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                                decoration: BoxDecoration(
                                    color: text_color,
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: Text("Next",style: GoogleFonts.openSans(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                            ),
                        ):Container(),
                        SizedBox(height: 20,)
                    ],
                ),
            ),
        );
    }
}

