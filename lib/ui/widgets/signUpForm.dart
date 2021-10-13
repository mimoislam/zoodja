
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/bloc/signup/sign_up_bloc.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
class SignUpForm extends StatefulWidget {
  final UserRepository _userRepository;

  const SignUpForm({@required UserRepository userRepository}):
        assert(userRepository !=null),
        _userRepository=userRepository ;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final TextEditingController _phoneController=TextEditingController();
  final TextEditingController _verificationController=TextEditingController();
  SignUpBloc _signUpBloc;
  UserRepository get _userRepository=>widget._userRepository;

bool show=false;
  bool isSignUpButtonEnabled(SignUpState state){

  }

  @override
  void initState() {
    _signUpBloc=BlocProvider.of<SignUpBloc>(context);

    super.initState();
  }
   _onFormSubmitted()async{
    await _userRepository.verifyPhoneNumber("+213"+_phoneController.text);
    if(_userRepository.verification==""){

      return ;
    }
    show=true;
    setState(() {
    });
    print(_userRepository.verification);
  }

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return BlocListener<SignUpBloc,SignUpState>(
        bloc: _signUpBloc,
        listener: (BuildContext context,SignUpState state) {
            if(state.isFailure){
              return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SignUp Failed'),
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
                      Text('Signing Up ......'),
                      CircularProgressIndicator()
                    ],
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            }
            if (state.isSuccess){

              BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
              Navigator.of(context).pop();

            }
            if (state.isFailure){
              print('isf');
            }
        },
        child: BlocBuilder<SignUpBloc,SignUpState>(
          bloc: _signUpBloc,
          builder: (BuildContext context,SignUpState state){
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:Container(
                width: size.width,
                height: size.height,
                child: ListView(
                  children: [
                    SizedBox(height: 20,),
                    Center(
                      child: Text('True Love Stories never have endings',textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(fontSize: size.width*0.07, color: text_color, fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            width: size.width*0.3,
                            child: Divider(height: size.height*0.05,
                              color: text_color,


                            ),
                          ),
                          Container(
                            width: size.width*0.3,
                            child: Text('Sign Up',textAlign: TextAlign.center,
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
                    SizedBox(height:30,),

                    show==false?Padding(
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

                    ):
                    Padding(
                      padding: EdgeInsets.all(size.height*0.02),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        color: text_color2.withOpacity(0.4),

                        child: TextFormField(
                          controller: _verificationController,
                          autovalidateMode: AutovalidateMode.always,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Verification Code',
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

                    SizedBox(height: 100,),
                    show==false?Padding(
                      padding: EdgeInsets.all(size.height*0.02),
                      child: GestureDetector(
                        onTap:
                            _onFormSubmitted
                            ,
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
                              "Sign Up",
                              style: GoogleFonts.openSans(
                                fontSize: size.height*0.025,
                                color: Colors.white,
                              ),
                            ),
                          ),

                        ),
                      ),
                    )
                        : Padding(
                      padding: EdgeInsets.all(size.height*0.02),
                      child: GestureDetector(
                        onTap:
                        ()async{
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _userRepository.verification, smsCode: _verificationController.text);
                          print(credential);
                         await _userRepository.signInWithCredential(credential);
                          _signUpBloc.add(

                              SignUpWithCredentialsPressed
                                (
                                  phone: "+213"+_phoneController.text
                              )
                          );

                         }
                            ,
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
                              "Verifie",
                              style: GoogleFonts.openSans(
                                fontSize: size.height*0.025,
                                color: Colors.white,
                              ),
                            ),
                          ),

                        ),
                      ),
                    )
                  ],
                ),
              ) ,
            );
          },
        ),
        );
  }

}
