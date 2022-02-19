import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/bloc/verification/verification_bloc.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class VerifyForm extends StatefulWidget {
  final UserRepository _userRepository;

  const VerifyForm({@required UserRepository userRepository}):
        assert(userRepository !=null),
        _userRepository=userRepository ;
  @override
  _VerifyFormState createState() => _VerifyFormState();
}

class _VerifyFormState extends State<VerifyForm> {
  final TextEditingController _verificationController=TextEditingController();

  VerificationBloc _verificationBloc;
bool isLoading=false;

  @override
  void initState() {
    _verificationBloc=BlocProvider.of<VerificationBloc>(context);
    super.initState();
    _listen();
  }
  _listen ()async{
    await SmsAutoFill().listenForCode();
  }
  @override
  void dispose() {
    SmsAutoFill().unregisterListener();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return BlocListener<VerificationBloc,VerificationState>(
      listener: (BuildContext context,VerificationState state){
        if(state.isFailure){

          Timer(Duration(seconds: 2), () {
            BlocProvider.of<AuthenticationBloc>(context).add(ToOnBoarding());
          });
          return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Login Failed'),
                  Icon(Icons.error)
                ],
              ),
              duration: Duration(seconds: 1),
            ),
          );

        }
        if(state.isSubmitting){
          print('isSubmitting');
          isLoading=true;
          setState(() {

          });
          return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logging In ......'),
                  CircularProgressIndicator()
                ],
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
        if (state.isSuccess){
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<VerificationBloc,VerificationState>(
          bloc: _verificationBloc,
          builder: (BuildContext context,VerificationState state){
            return isLoading
                ?Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        Colors.blueGrey,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Logging In ......")
                  ],
                ),
              ),
            )

                  : SingleChildScrollView(

              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height*0.15,),
                    Center(
                      child: Text(AppLocalizations.of(context).true_Love_Stories_never_have_endings,textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(fontSize: size.width*0.06, color: text_color, fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            width: size.width*0.3,
                            child: Divider(height: size.height*0.03,
                              color: text_color,


                            ),
                          ),
                          Container(
                            width: size.width*0.3,
                            child: Text(AppLocalizations.of(context).code,textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontSize: size.width*0.07, color: text_color,fontWeight: FontWeight.w300 ),),

                          ),
                          Container(
                            width: size.width*0.3,
                            child: Divider(height: size.height*0.05,
                              color: text_color,

                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height*0.05,),
                    Container(
                      width: size.width*0.8,
                      child: Divider(height: size.height*0.05,
                        color: Colors.white,

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(size.height*0.02),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        color: text_color2.withOpacity(0.4),

                        child:    PinFieldAutoFill(
                          decoration: UnderlineDecoration(
                            textStyle: TextStyle(fontSize: 20, color: Colors.black),
                            colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                          ),
                          currentCode: "000000",
                          codeLength: 6,
                          controller: _verificationController,
                          onCodeSubmitted: (code) {
                            _verificationBloc.add(Submitting(code:  _verificationController.text,verification:_verificationBloc.verification ));

                          },
                          onCodeChanged: (code) {
                            if (code.length == 6) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                          },
                        ),
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.all(size.height*0.02),
                      child: GestureDetector(
                        onTap: ()async{

                          _verificationBloc.add(Submitting(code:  _verificationController.text,verification:_verificationBloc.verification ));
                        },
                        child: Container(
                          width: size.width*0.7,
                          height: size.height*0.1,
                          decoration: BoxDecoration(
                            color: Colors.red
                            ,
                            borderRadius: BorderRadius.circular(size.height*0.04),

                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).verifier,
                              style: GoogleFonts.openSans(
                                fontSize: size.height*0.025,
                                color: Colors.white,
                              ),
                            ),
                          ),

                        ),
                      ),
                    )


                  ]),

            );
          }
      ),
    );
  }
}

