import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/bloc/login/login_bloc.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/pages/signUp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginForm extends StatefulWidget {
final UserRepository _userRepository;

const LoginForm({@required UserRepository userRepository}):
      assert(userRepository !=null),
      _userRepository=userRepository ;  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _phoneController=TextEditingController();

  LoginBloc _loginBloc;
  bool  get isPopulated=> _phoneController.text.isNotEmpty ;
  bool isReCAPTCHA=false;

  _onFormSubmitted()async{
    try{
      setState(() {
        isReCAPTCHA=true;
      });
      await userRepository.verifyPhoneNumber("+213"+_phoneController.text,(){
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
      },(s)async{
        final signature = await SmsAutoFill().getAppSignature;
        BlocProvider.of<AuthenticationBloc>(context).add(ConfirmEvent(s));

        isReCAPTCHA=false;

      });

    }catch(e){
      BlocProvider.of<AuthenticationBloc>(context).add(ToOnBoarding());
    }




  }

  @override
  void initState() {
    _loginBloc=BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  UserRepository get userRepository => widget._userRepository;
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;

    return BlocListener<LoginBloc,LoginState>(
        listener: (BuildContext context,LoginState state){
          if(state.isFailure){
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Login Failed'),
                    Icon(Icons.error)
                  ],
                ),
                duration: Duration(seconds: 2),
              ),
            );

          }
          if(state.isSubmitting){
            print('isSubmitting');
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
            print('isSuccess');
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          }
        },
      child: BlocBuilder<LoginBloc,LoginState>(
          bloc: _loginBloc,
          builder: (BuildContext context,LoginState state){
            return
            isReCAPTCHA

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
            Text("Please Waiting ...")
            ],
            ),
            ),
            )
                :SingleChildScrollView(

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
                          child: Text(AppLocalizations.of(context).sign_In,textAlign: TextAlign.center,
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
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(size.height*0.02),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          color: text_color2.withOpacity(0.4),

                          child: TextFormField(
                            controller: _phoneController,
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefix: Text("+213"),
                              labelText: 'Phone Number',
                              labelStyle: GoogleFonts.openSans(
                                  color: text_color2,
                                  fontSize: size.height*0.02
                              ),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),

                      ),


                    ],
                  ),


                  Padding(
                    padding: EdgeInsets.all(size.height*0.02),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _onFormSubmitted,

                          child: Container(
                            width: size.width*0.7,
                            height: size.height*0.1,
                            decoration: BoxDecoration(
                              color: Color(0xff3B5998),
                              borderRadius: BorderRadius.circular(size.height*0.04),

                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: size.height*0.025,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          ),
                        ),
                        SizedBox(height: size.height*0.1,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context){
                                    return SignUp(userRepository: userRepository);
                                  }
                                )
                            );
                          },
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).are_you_new,
                              style: TextStyle(
                                fontSize: size.height*0.025,
                                color: Colors.blue,
                              ),
                            ),
                          ),

                        )
                      ],
                    ),
                  )


                ]),

            );
          }
      ),
        );
  }



  @override
  void dispose() {
    super.dispose();
  }
}
