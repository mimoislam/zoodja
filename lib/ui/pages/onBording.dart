import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/login/login_bloc.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/widgets/loginForm.dart';


class OnBoardingScreen extends StatefulWidget {
  final UserRepository _userRepository;
  OnBoardingScreen({@required UserRepository userRepository}):
        assert(userRepository !=null),
        _userRepository=userRepository ;

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool clicked;

  @override
  void initState() {
    clicked=false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:clicked? BlocProvider<LoginBloc>(
          create: (context)=>LoginBloc(userRepository: widget._userRepository),
          child: LoginForm(userRepository: widget._userRepository,),
        ):SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),

              Image.asset("assets/boarding.png",height: 250,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "By tapping Log In, you agree with our",style: GoogleFonts.openSans(color: text_color)),
                      TextSpan(text: " Terms of Service",style: GoogleFonts.openSans(color: text_color,decoration: TextDecoration.underline)),
                      TextSpan(text: " and ",style: GoogleFonts.openSans(color: text_color)),
                      TextSpan(text: "Privacy Policy",style: GoogleFonts.openSans(color: text_color,decoration: TextDecoration.underline))
                    ]
                ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  clicked=true;
                  setState(() {

                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical:15),
                  decoration: BoxDecoration(
                      color: Color(0xffFE3C72),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Text("Find your perfect match",style: GoogleFonts.openSans(color: Colors.white,fontSize: 16),),
                ),
              )
            ],
          ),
        )
    );
  }
}
