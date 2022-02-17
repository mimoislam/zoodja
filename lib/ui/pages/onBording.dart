import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/bloc/login/login_bloc.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/pages/condition.dart';
import 'package:zoodja/ui/widgets/loginForm.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OnBoardingScreen extends StatefulWidget {
  final UserRepository _userRepository;
  OnBoardingScreen({@required UserRepository userRepository}):
        assert(userRepository !=null),
        _userRepository=userRepository ;

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(

        body:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),

              Image.asset("assets/boarding.png",height: size.height*0.6,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Condition(userId: "0"),));
                  },
                  child: RichText(text: TextSpan(
                      children: [
                        TextSpan(text: AppLocalizations.of(context).by_tapping,style: GoogleFonts.openSans(color: text_color)),
                        TextSpan(text: AppLocalizations.of(context).terms_of_Service,

                            style: GoogleFonts.openSans(color: text_color,decoration: TextDecoration.underline)),
                       ]
                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Center(
                child: GestureDetector(
                  onTap: (){
                    BlocProvider.of<AuthenticationBloc>(context).add(ToOnBoarding());

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical:15),
                    decoration: BoxDecoration(
                        color: Color(0xffFE3C72),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text(AppLocalizations.of(context).find_your_perfect_match,style: GoogleFonts.openSans(color: Colors.white,fontSize: 16),),
                  ),
                ),
              ),
              SizedBox(height: 50,),

            ],
          ),
        )
    );
  }
}

