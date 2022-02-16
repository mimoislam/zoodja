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

                                        //////// finished Here
                                        TextSpan(
                                            text: "ARTICLE 2. ACCÈS, INSCRIPTION ET ABONNEMENT\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text: " L’inscription aux Services est gratuite.\n\n"
                                                "L’acceptation des Conditions d’Utilisation lors de l’inscription formalise la conclusion du contrat d’adhésion aux Services. Elle permet de devenir Membre ou abonné, de découvrir les Services et donne accès aux fonctionnalités gratuites de ces Services.\n\n"
                                                "Les Services sont exclusivement destinés aux adultes de plus de 18 ans.\n\n"
                                                "Si un Membre ou un Abonné a moins de 18 ans, il n’est pas autorisé à utiliser les Services et doit immédiatement en cesser l’utilisation.\n\n"
                                                "En créant un Profil et en utilisant les Services, les Membres et les Abonnés déclarent et certifient ce qui suit :\n\n"
                                                "• Ils ont plus de 18 ans et peuvent conclure un contrat juridiquement contraignant avec Zooidja\n"
                                                "• Ils remplissent les conditions d’inscription énoncées à tout moment.\n"
                                                "• Ils se conforment aux présentes Conditions d’utilisation et à toutes les lois et réglementations applicables en Algérie.\n"
                                                "• Ils se conforment aux Règles de respect de bienveillant en toutes circonstances vis-à-vis de la communauté\n"
                                                "• Ils fournissent des informations correctes, exactes et véridiques ne prêtant pas à confusion. En particulier, ils doivent être sincères et honnêtes dans les réponses qu’ils fournissent sur leur profil et lorsqu’ils interagissent avec d’autres utilisateurs ou avec Zooidja.\n"
                                                "• Ils respectent l’objectif des Services, qui est de permettre de favoriser les annonces pour mariages, rencontres entre personnes à des fins personnelles dans le but du mariage, évènements, activités et sorties qui ont pour but de faire rencontrer les membres ou abonnés dans la vie réelle à des fins de loisirs culturels, sportifs, pédagogiques ou ludiques comme les sorties en groupe, les visites guidées, des ateliers en tout genre comme la cuisine ou le bricolage etc\n"
                                                "• Ils mettent à jour, suspendent ou modifient rapidement leur profil dans le cas où leur situation personnelle change.\n"
                                                "• Ils ne se sont pas vus interdits d’utiliser les Services en vertu des lois applicables en Algérie.\n\n"
                                                "Zooidja se réserve le droit de refuser, suspendre ou résilier l’adhésion à tout moment si un Membre ou un Abonné ne remplit aucune de ces conditions.\n\n"
                                                "Il est précisé qu’un Membre ne peut pas créer plusieurs Comptes avec les mêmes coordonnée (adresse email, numéro de téléphone…).\n\n"
                                                "Une fois inscrit, le Membre complète son Profil, les informations étant fournies à titre facultatif ou obligatoire, le cas échéant. Ces informations sont publiées sur Zooidja et diffusées auprès des autres Membres au travers des Services. La diffusion par le Membre de ses coordonnées personnelles (adresse électronique, adresse postale, téléphone, etc.) est expressément prohibée par Zooidja.\n\n"
                                                "Lorsque les conditions nécessaires à l’inscription sont remplies, chaque Membre dispose d’un identifiant et d’un mot de passe strictement confidentiel et personnel lui permettant d’accéder à son Compte.\n\n"
                                                "Le Membre ou l’Abonné est responsable de l’utilisation des éléments d’identification par des tiers ou des actions ou déclarations faites par l’intermédiaire de son Compte, qu’elles soient frauduleuses ou non, et garantit Zooidja contre toute demande à ce titre, sauf en cas de faute exclusivement imputable à Zooidja ou de défaillance technique de ses Services. Par ailleurs, Zooidja n’a pas pour obligation et ne s’assure pas de l’identité des personnes s’inscrivant aux Services. Si le Membre ou l’Abonné a des raisons de penser qu’une personne utilise ses éléments d’identification ou son Compte, il devra en informer immédiatement Zooidja.\n\n"
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
                                            text:" L’inscription gratuite ne permet pas d’utiliser toutes les fonctionnalités de Zooidja. Selon les Services et sous réserve des éventuelles restrictions définies par Zooidja, les fonctionnalités gratuites incluent notamment la création du Profil, certaines fonctionnalités de recherche, la consultation des Profils des autres Membres et l’inscription aux évènements et autres activités. La communication avec d’autres Membres peut nécessiter la souscription à un service payant.\n\n\n"
                                                "L’accès à certains services est payant. Le Membre a la possibilité de souscrire un à ces services et bénéficier de ses fonctionnalités et avantages.\n\n"
                                                "Pour ce faire, le Membre doit préalablement s’identifier à l’aide de ses coordonnées et de son mot de passe confidentiel. Après avoir choisi l’offre qui le satisfait et son moyen de paiement, le Membre doit valider son paiement. Cette dernière étape formalise la conclusion du contrat d’adhésion aux Services Payants et l’acceptation sans réserve de l’intégralité des Conditions d’Utilisation. Une fois le paiement validé, l’Abonné est dirigé vers une page de confirmation de paiement. Zooidja accuse également réception de l’achat d’un Abonnement par courrier électronique.\n"
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
                                            text:"Zooidja exclue expressément toute responsabilité à l’égard des évènements de toute nature qui pourraient survenir lors de rencontres entre Membres ou Abonnés sur les Services ou lors de rencontres « réelles » entre Membres ou Abonnés à la suite de l’utilisation des Services.\n\n"
                                                "L’objet des Services, en ce inclus les Services Payants, n’est pas la fourniture d’un accès au réseau Internet, ni la fourniture d’un service de communication électronique au public. En conséquence, Zooidja ne contrôle pas l’identité réelle des Membres ou des Abonnés lorsqu’ils se connectent à ses services. Par ailleurs, elle ne contrôle ni ne modèrent de façon exhaustive les contenus de toute nature que les Membres et Abonnés peuvent éditer sur les Services sous leur responsabilité exclusive.\n\n"
                                                "Dans ce cadre, il est rappelé aux Membres et aux Abonnés qu’il leur est interdit de divulguer aux autres Membres ou Abonnés, par l’intermédiaire des Services, toute information permettant leur identification ou leur localisation (nom de famille, adresse postale, email, téléphone…), à l’exception de leur pseudonyme.\n\n"
                                                "En utilisant le Service, les Membres et les Abonnés doivent respecter à tout moment les règles de conduite suivantes et conviennent de ne pas :\n\n"
                                                "• Enfreindre les conditions générales d’utilisation, mises à jour régulièrement.\n"
                                                "• Publier leurs coordonnées personnelles ou diffuser les informations personnelles d’une autre personne (adresse e-mail, adresse postale, numéro de téléphone, etc.) de quelque manière que ce soit (dans une description de profil, sur une photo, etc.)\n"
                                                "• Publier tout contenu qui viole ou enfreint les droits d’autrui, y compris ceux relatifs à la publicité, vie privée, droits d’auteur, marques déposées ou tout autre droit de propriété intellectuelle ou contractuel.\n"
                                                "• Usurper l’identité de toute personne ou entité.\n"
                                                "• Solliciter des mots de passe à quelque fin que ce soit ou des informations d’identification personnelle à des fins commerciales ou illégales auprès d’autres Membres ou Abonnés.\n"
                                                "• Spammer, demander de l’argent ou escroquer un Membre ou un Abonné."
                                                "• Publier tout contenu à caractère haineux, menaçant, sexuellement explicite ou pornographique ; qui incite à la violence ou contient de la nudité ou de la violence explicite ou gratuite ou contraire aux préceptes de l’islam et des valeurs nationales algériennes."
                                                "• Publier tout contenu qui porte atteinte aux valeurs morales et symboles de la nation algérienne.\n"
                                                "• Publier tout contenu qui promeuve le racisme, le sectarisme, la haine ou les dommages physiques de quelque nature que ce soit contre un groupe ou un individu.\n"
                                                "• Malmener, « traquer », intimider, agresser, harceler, maltraiter ou diffamer toute personne.\n"
                                                "• Utiliser les Services à des fins nuisibles ou malveillantes.\n"
                                                "• Utiliser les Services afin de nuire à Zooidja.\n"
                                                "• Utiliser les Services à des fins illégales ou interdites par la loi algérienne applicable dans le présent contrat ainsi que les présentes Conditions d’utilisation.\n"
                                                "• Utiliser tout(e) logiciels, scripts, robots ou tout autre moyen ou processus (notamment des robots d’indexation, des modules d’extension de navigateur et compléments, ou toute autre technologie) visant à accéder, extraire, indexer, fouiller les données ou reproduire ou éluder de quelque façon que ce soit la structure de navigation ou la présentation du Service ou de ses contenus.\n"
                                                "• Utiliser le compte d’un autre utilisateur, partager un compte avec un autre utilisateur ou gérer plusieurs comptes.\n"
                                                "• Créer un autre compte si Zooidja a déjà résilié leur compte, à moins que le Membre ou l’Abonné n’ait l’autorisation de Zooidja.\n"
                                                "• Utiliser les Services de mauvaise foi.\n\n"
                                                "Une violation par un Membre ou un Abonné de l’une de ces règles de conduite constitue une violation grave de ses obligations contractuelles en vertu des présentes Conditions d’utilisation.\n\n"
                                                "Zooidja se réserve le droit de résilier le compte d’un Membre ou d’un Abonné sans aucun remboursement des Services payants en cas de violation des présentes obligations, d’utilisation abusive des Services ou de comportement, action ou communication inapproprié ou illégal survenu dans le cadre de l’utilisation des Services ou non. En outre, Zooidja peut interdire définitivement ou temporairement son accès à l’un de ses Services, Événements ou Activités.\n"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),



                                        TextSpan(
                                            text: "ARTICLE 5. PRIX, MODALITÉS DE PAIEMENT ET DE RENOUVELLEMENT\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Les prix et les modalités de paiement sont décrits sur les offres de services payants de Zooidja.\n\n"
                                                "Vous pouvez mettre à jour votre mode de paiement à tout moment. Zooidja peut également les mettre à jour sur la base d’informations directement fournies par le prestataire de service de paiement.\n\n"
                                                "Ainsi, Zooidja informera l’Abonné, par courrier électronique ou notification de la fin de l’Abonnement initial.\n\n"
                                                "En outre, une information sur l’échéance de l’Abonnement d’un Abonné est fournie aux Abonnés dans la rubrique « Mon Compte », qui leur permet de gérer leur Abonnement et, le cas échéant \n"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),



                                        TextSpan(
                                            text: "ARTICLE 6. PROPRIÉTÉ INTELLECTUELLE\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text: "6.1. Contenus diffusés sur les Services\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Les dénominations des Services, les marques, les logos, les graphismes, les photographies, les animations, les vidéos et les textes contenus sur Zooidja  et dans les Services sont la propriété exclusive de Zooidja et le cas échéant de ses partenaires et ne peuvent être reproduits, utilisés ou représentés sans l’autorisation expresse des sociétés de Zooidja ou de leurs partenaires, sous peine de poursuites judiciaires.\n\n"
                                                "Les droits d’utilisation concédés au Membre et à l’Abonné sont réservés à un usage privé et personnel dans le cadre et pour la durée de l’inscription aux Services. Toute autre utilisation par le Membre ou l’Abonné est interdite.\n\n"
                                                "Le Membre ou l’Abonné s’interdit notamment de modifier, copier, reproduire, télécharger, diffuser, transmettre, exploiter commercialement et/ou distribuer de quelque façon que ce soit les Services, les pages des Sites, ou les codes informatiques des éléments composant les Services et les Sites, sous peine de poursuites judiciaires.\n"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),



                                        TextSpan(
                                            text: "6.2. Contenus diffusés par les Membres et Abonnés\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Le Membre ou l’Abonné concède à Zooidja une licence d’utilisation des droits de propriété intellectuelle attachés aux contenus fournis par lui dans le cadre de son inscription ou Abonnement et de son utilisation des Services ou de la diffusion de son Profil sur les Services. Cette licence comprend notamment le droit pour Zooidja de reproduire, représenter, adapter, traduire, numériser, utiliser aux fins des Services ou de sous-licencier les contenus fournis par le Membre ou l’Abonné (informations, images, description, critères de recherche, etc.), sur tout ou partie des Services et sur l’ensemble des Sites, dans les mailings des sociétés de Zooidja et de manière générale sur tous supports de communication électronique (e-mail, Internet, application mobile) dans le cadre des Services.\n\n"
                                                "Le Membre ou l’Abonné autorise expressément Zooidja à modifier lesdits contenus afin de respecter la charte graphique des Services ou des autres supports de communication visés ci-dessus et/ou de les rendre compatibles avec ses performances techniques ou les formats des supports concernés. Ces droits sont concédés pour le monde entier et pour une durée de 99 ans . Le Membre ou l’Abonné s’interdit de copier, reproduire, ou autrement utiliser les contenus relatifs aux autres Membres et Abonnés autrement que pour les stricts besoins d’utilisation des Services à des fins personnelles et privées.\n"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),


                                        TextSpan(
                                            text: "ARTICLE 7. RESPONSABILITÉ ET GARANTIE\n",
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
                                            text:"7.1.1 Pour utiliser les Services, le Membre ou l’Abonné doit disposer des compétences, des équipements et des logiciels requis pour l’utilisation d’Internet ou des applications mobiles des Services. Zooidja met en place des mesures de sécurité dans le cadre de l’utilisation de ses Services. Pour autant, le Membre ou l’Abonné reconnaît que les caractéristiques et les contraintes d’Internet ne permettent pas de garantir une sécurité absolue sur Internet ou via les applications mobiles.\n\n"
                                                "7.1.2 Le Membre ou l’Abonné doit posséder l’équipement, en ce inclus les logiciels et les paramétrages adéquats, nécessaires au bon fonctionnement des Services : version la plus récente du navigateur Internet, activation des fonctions Java script, réception de cookies de session et acceptation de l’affichage de fenêtres « pop-ups ».\n\n"
                                                "7.1.3 Zooidja ne garantit pas que les Services seront utilisables si le Membre ou l’Abonné utilise un utilitaire de « pop-up killer » ou équivalent ; dans ce cas, cette fonction devra être désactivée préalablement à l’utilisation des Services.\n\n"
                                                "7.1.4 Zooidja ne garantit pas que les Services seront utilisables si le fournisseur d’accès Internet du Membre ou de l’Abonné est défaillant dans l’accomplissement de sa propre prestation. De même, le cas échéant l’utilisation des applications pour smartphones souscrites par le Membre ou l’Abonné directement auprès du fournisseur de l’application suppose que ce dernier dispose d’un smartphone et d’une connexion appropriée.\n\n"
                                                "7.1.5 Zooidja n’est pas responsable d’un dysfonctionnement, d’une impossibilité d’accès ou de mauvaises conditions d’utilisation des Sites et Services imputables à un équipement non adapté, à des dysfonctionnements internes au fournisseur d’accès du Membre ou de l’Abonné, à l’encombrement du réseau Internet, et pour toutes autres raisons extérieures à Zooidja ayant le caractère d’un cas de force majeure.\n\n"
                                                "7.1.6 L’exploitation des Services pourra être momentanément interrompue pour cause de maintenance, de mise à jour ou d’améliorations techniques, ou pour en faire évoluer le contenu et/ou la présentation. Dans la mesure du possible, Zooidja informera les Membres et Abonnés préalablement à une opération de maintenance ou de mise à jour susceptible d’impacter les Services.\n"
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
                                            text:"7.2.1. Les informations fournies par un Membre ou un Abonné à Zooidja doivent être exactes et conformes à la réalité. Les conséquences de leur divulgation sur sa vie et/ou celle des autres Membres et Abonnés sont de la responsabilité exclusive du Membre ou de l’Abonné concerné. Le Membre ou l’Abonné prend l’initiative de divulguer et de diffuser via les Services des informations, données, textes, contenus et images le concernant. En conséquence, il renonce à tout recours à l’encontre de Zooidja, notamment sur le fondement de l’atteinte éventuelle à son droit à l’image, à son honneur, à sa réputation, à l’intimité de sa vie privée, résultant de la diffusion ou de la divulgation d’informations le concernant dans les conditions prévues par la Politique de Confidentialité dans la mesure où le Membre ou l’Abonné a préalablement, librement et explicitement consenti à une telle divulgation du fait de son inscription ou abonnement aux Services, en application des Conditions d’Utilisation.\n\n"
                                                "7.2.2. Zooidja ne peut être tenue pour responsable de l’exactitude ou de l’inexactitude des informations et contenus fournis par les autres Membres, les autres Abonnés et/ou le Membre ou l’Abonné lui-même, ni des conséquences découlant de l’utilisation de ces informations et contenus. De même, Zooidja ne peut être tenue pour responsable des contenus diffusés par un Membre ou un Abonné susceptibles de contrevenir aux droits d’un ou plusieurs autres Membres, Abonnés ou tiers et dont Zooidja rapporterait la preuve qu’elle n’en aurait pas été informée par un Membre, Abonné ou par un tiers ou n’en aurait pas eu une connaissance effective et préalable avant sa diffusion ou qu’il n’aurait pas commis de faute dans l’exécution de ses obligations contractuelles au titre des Conditions d’Utilisation.\n\n"
                                                "7.2.3. La qualité des Services exigée tant par Zooidja que par ses Membres et Abonnés suppose le respect d’une certaine éthique dans l’expression et le comportement des Membres et Abonnés, le respect des droits des tiers, ainsi que le respect des lois et règlements en vigueur. Au service de cette exigence de qualité, de responsabilité individuelle et d’éthique, le Zooidja permet à tout Membre et Abonné de lui signaler tous contenus (photographie, texte, vidéo), comportements ou propos d’un Membre ou d’un Abonné qui lui paraissent porter atteinte aux lois et règlements en vigueur, aux préceptes de l’islam, ou aux symboles de la nation, à l’image ou à l’objet des Services, aux droits d’un tiers ou aux bonnes mœurs.\n\n"
                                                "En conséquence, les Membres et Abonnés reconnaissent et acceptent que les données qu’ils fournissent, ainsi que leurs comportements ou leurs propos via les Services sont susceptibles de faire l’objet d’un signalement par d’autres Membres ou Abonnés et d’une modération et/ou d’un contrôle par le Zooidja, sur la base de critères d’appréciation objectifs. Dans l’hypothèse où ce signalement ou ce contrôle révélerait la violation par un Membre ou par un Abonné des lois et règlements en vigueur ou de ses obligations contractuelles au titre des Conditions d’Utilisation, Zooidja pourra exclure ledit Membre ou Abonné conformément à l’article 9 ci-après. Selon le comportement ou les propos des Membres et Abonnés, l’équipe de surveillance peut prendre la décision de bloquer toute nouvelle inscription par la personne concernée.\n\n"
                                                "7.2.4. Dans le cas où la responsabilité du Zooidja serait recherchée à raison d’un manquement par un Membre ou un Abonné aux obligations qui lui incombent aux termes de la loi ou des Conditions d’Utilisation, ce dernier s’engage à garantir le Zooidja contre tous dommages, frais ou condamnations prononcés à son encontre trouvant leur origine dans le manquement imputé au Membre ou à l’Abonné."
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
                                            text:"Zooidja est uniquement responsable des liens hypertextes qu’elle crée au sein des Sites et Services et n’exerce aucun contrôle des Sites Tiers et des sources externes (sites ou applications mobiles de tiers, réseaux sociaux, etc.) vers lesquels redirigent les liens hypertextes accessibles sur ses Sites et ses Services. Zooidja ne peut être tenue responsable de la mise à disposition de liens dirigeant vers les Sites Externes et ne peut supporter aucune responsabilité quant aux contenus, publicités, produits, fonctionnalités, services ou autres éléments disponibles sur ou à partir de ces Sites Tiers dont il ne lui aurait pas été fait mention, préalablement et effectivement, de leur caractère manifestement illicite, au moyen d’une notification conforme à la règlementation en vigueur. Il est rappelé que la consultation et l’utilisation de Sites Tiers sont régies par les conditions d’utilisation de ceux-ci, et qu’elles s’effectuent sous l’entière responsabilité du Membre ou de l’Abonné.\n\n"
                                                "Toute difficulté relative à un lien doit être signalée à Zooidja  au mail support@zooidja.com"
                                                "\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),




                                        TextSpan(
                                            text: "ARTICLE 8. SUSPENSION DU PROFIL – SUPPRESSION DU COMPTE –\n",
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
                                            text:"Cette section ne s’applique qu’aux Sites pour lesquels cette fonctionnalité est disponible.\n\n"
                                                "Chaque Membre ou Abonné peut à tout moment demander la suspension de son Profil, notamment via la rubrique « Mon Compte » dédiée à cet effet, afin de ne plus être visible sur les Sites et ne plus recevoir de notifications. Cette suspension est temporaire et n’interrompt pas l’Abonnement et les éventuelles Options en cours. Le Membre ou l’Abonné peut réactiver son Profil à tout moment.\n\n"
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
                                            text:"Chaque Membre ou Abonné peut à tout moment mettre fin à son inscription aux Services ou à son Abonnement en demandant la clôture de son Compte auprès de Zooidja, sans frais autres que ceux liés à la transmission de sa demande et sans motif, notamment via la rubrique « Mon Compte », par email, formulaire de contact ou par tout moyen qui pourra lui être indiqué dans cette rubrique. Cette demande sera réputée effectuée le jour ouvré suivant la réception par Zooidja de la demande de clôture du Compte concerné, et l’Abonné ne pourra plus utiliser son Abonnement et les éventuelles Options en cours. Cette demande ne donne pas droit au remboursement à l’Abonné de la période restant à courir jusqu’à l’échéance de son Abonnement et des éventuelles Options en cours. Le Membre ou l’Abonné sera informé par courrier électronique de la suppression de son Compte.\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            )
                                        ),



                                        TextSpan(
                                            text: "8.3 Résiliation par Zooidja\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Sans préjudice des autres dispositions des Conditions d’Utilisation, en cas de manquement d’un Abonné ou Membre à ses obligations, Zooidja pourra supprimer définitivement le ou les Comptes du Membre ou de l’Abonné concerné au sein de l’ensemble des Sites, révoquer l’accès aux Services et à tout autre service fourni par le Zooidja, sans préavis ni mise en demeure. Cette suppression n’emporte le droit au remboursement de l’Abonné. Le Membre ou l’Abonné sera informé par courrier électronique de la suppression de son Compte.\n\n"
                                                "Cette suppression interviendra sans préjudice de tous les dommages et intérêts qui pourraient être réclamés par Zooidja au Membre ou à l’Abonné ou ses ayants droit et représentants légaux en réparation des préjudices subis par Zooidja du fait de tels manquements.\n\n"
                                                "Dans le cas de la fermeture des services Zooidja, pour raison financières, par décision de justice ou pour un cas de force majeur, les comptes seront de facto supprimé ou suspendus et les membres ne pourront en aucun y accéder.\n\n"
                                                "Cette fermeture inclus les services payants souscrits par les membres.\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),



                                        TextSpan(
                                            text: "ARTICLE 9. EVENEMENTS ET AUTRES ACTIVITÉS\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Lorsque des évènements ou Activités sont proposés aux Membres et Abonnés sur les Sites et autres services Zooidja, des conditions générales spécifiques sont applicables. Vous pouvez les consulter sur les pages décrivant les évènements ou Activités.\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),



                                        TextSpan(
                                            text: "ARTICLE 10. DONNÉES PERSONNELLES\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Le Membre ou l’Abonné concède à Zooidja une licence d’utilisation des droits de propriété intellectuelle attachés aux contenus fournis par lui dans le cadre de son inscription ou Abonnement et de son utilisation des Services ou de la diffusion de son Profil sur les Services. Cette licence comprend notamment le droit pour Zooidja de reproduire, représenter, adapter, traduire, numériser, utiliser aux fins des Services ou de sous-licencier les contenus fournis par le Membre ou l’Abonné (informations, images, description, critères de recherche, etc.), sur tout ou partie des Services et sur l’ensemble des Sites, dans les mailings des sociétés de Zooidja et de manière générale sur tous supports de communication électronique (e-mail, Internet, application mobile) dans le cadre des Services.\n\n"
                                                "Cette licence comprend également le droit pour Zooidja d’utiliser les informations fournies par lui dans le cadre de son inscription ou Abonnement à des fins de publicité diffusée par Zooidja ou par un tiers partenaire.\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),




                                        TextSpan(
                                            text: "ARTICLE 11. INTÉGRALITÉ DE LA CONVENTION\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Les Conditions d’Utilisation constituent un contrat régissant les relations entre le Membre ou l’Abonné et Zooidja. Elles annulent et remplacent toutes les dispositions antérieures non expressément visées ou annexées et constituent l’intégralité des droits et obligations de Zooidja, et du Membre ou de l’Abonné relatifs à leur objet.\n\n"
                                                "Si une ou plusieurs stipulations des Conditions d’Utilisation étaient déclarées nulles en application d’une loi, d’un règlement ou à la suite d’une décision définitive d’une juridiction ou autorité compétente, les autres stipulations garderont toute leur force et leur portée, dans la mesure permise par la loi, le règlement ou la décision applicable.\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),




                                        TextSpan(
                                            text: "ARTICLE 12. MODIFICATION DES SERVICES ET DES CONDITIONS D’UTILISATION\n",
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
                                            text:"Zooidja pourra faire évoluer et modifier à tout moment le contenu et/ou les fonctionnalités des Services afin d’en améliorer la qualité. Le Membre ou Abonné sera informé de la nature de ces évolutions ou modifications dès leur mise en ligne sur les Sites directement sur les supports concernés, utilisés par Zooidja ou par e-mail."
                                                "\n\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),




                                        TextSpan(
                                            text: "12.2 Modification des Conditions d’Utilisation\n\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Zooidja pourra modifier à tout moment les Conditions d’Utilisation. Le Membre ou l’Abonné sera informé de ces modifications dès leur mise en ligne directement sur les supports concernés, utilisés par Zooidja ou par e-mail."
                                                "Toute nouvelle inscription ou souscription d’Abonnement est soumise aux Conditions d’Utilisation alors en vigueur.\n\n"
                                                "Les Abonnés inscrits antérieurement à la modification des Conditions d’Utilisation auront le choix entre deux options :\n\n"
                                                "• L’Abonné peut accepter directement les nouvelles Conditions d’Utilisation ; celles-ci lui seront opposables à compter de l’acceptation.\n"
                                                "• L’Abonné peut exiger le maintien des Conditions d’Utilisation qui étaient en vigueur lors de la souscription de son Abonnement, jusqu’à l’échéance de l’Abonnement.\n"
                                                "A défaut de retour de l’Abonné dans le délai d’un (1) mois après leur entrée en vigueur, les Conditions d’Utilisation modifiées seront réputées acceptées par l’Abonné.\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),



                                        TextSpan(
                                            text: "ARTICLE 13. DEMANDE ET RÉCLAMATION\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Pour toute demande ou réclamation relative à un Membre ou Abonné, celui-ci peut contacter Zooidja par courrier postal adressé à Zooidja sis chez Bab 08,  08 rue Didouche Mourad, Alger.\n\n"
                                                "Le Membre ou Abonné peut également contacter le Service Client par courrier électronique ou par téléphone : support@zooidja.com\n"
                                                "\n"
                                            , style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        )
                                        ),



                                        TextSpan(
                                            text: "ARTICLE 14 – DROIT APPLICABLE – LITIGES\n",
                                            style: GoogleFonts.openSans(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        TextSpan(
                                            text:"Ces Conditions d’Utilisation sont régies et s’interprètent conformément au droit Algérien. La langue d’interprétation est le français.\n\n"
                                                "Dans le cas où un accord amiable ne pourrait être trouvé en cas de litige relatif aux Conditions d’Utilisation, les juridictions compétentes seront les tribunaux d’Alger.\n"
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
                                            text:"Les Services fournis par Zooidja aux Membres et Abonnés en application des présentes Conditions d’Utilisation, sont édités par 3 MO SARL domiciliée à Bab 08, 08 rue Didouche Mourad, Alger.\n\n"
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

