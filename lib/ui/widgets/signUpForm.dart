
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
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _userNameController=TextEditingController();
  SignUpBloc _signUpBloc;
  UserRepository get _userRepository=>widget._userRepository;

  bool  get isPopulated=> _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignUpState state){

    return isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _signUpBloc=BlocProvider.of<SignUpBloc>(context);

    _emailController.addListener( _onEmailChanged);
    _passwordController.addListener(onPasswordChanged);
    super.initState();
  }
   _onFormSubmitted(){
    _signUpBloc.add(
        SignUpWithCredentialsPressed
          (
          email: _emailController.text,
          password: _passwordController.text
          )
    );

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
              print('isSuccess');
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
                    Padding(
                      padding: EdgeInsets.all(size.height*0.02),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                        color: text_color2.withOpacity(0.4),
                        child: TextFormField(
                          controller: _userNameController,

                          decoration: InputDecoration(
                            labelText: 'User Name',
                            labelStyle: GoogleFonts.openSans(
                                color: text_color2,
                                fontSize: size.height*0.03
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),

                    ),

                    Padding(
                      padding: EdgeInsets.all(size.height*0.02),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                        color: text_color2.withOpacity(0.4),

                        child: TextFormField(
                          controller: _emailController,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (_){
                            return !state.isEmailValid?'Invalid Email':null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: GoogleFonts.openSans(
                              color: text_color2,
                              fontSize: size.height*0.03
                            ),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.all(size.height*0.02),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                        color: text_color2.withOpacity(0.4),
                        child: TextFormField(
                          controller: _passwordController,
                          autocorrect: false,
                          obscureText: true,

                          autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (_) {
                              return !state.isPasswordValid
                                  ? "Invalid Password"
                                  : null;
                            },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: GoogleFonts.openSans(
                                color: text_color2,
                                fontSize: size.height*0.03
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.all(size.height*0.02),
                      child: GestureDetector(
                        onTap: isSignUpButtonEnabled(state)
                            ?_onFormSubmitted
                            :null,
                        child: Container(
                          width: size.width*0.7,
                          height: size.height*0.1,
                          decoration: BoxDecoration(
                            color: isSignUpButtonEnabled(state)?Colors.red:
                                Colors.blue,
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
                  ],
                ),
              ) ,
            );
          },
        ),
        );
  }

  void _onEmailChanged() {
    _signUpBloc.add(EmailChanged(email: _emailController.text));

  }

  void onPasswordChanged() {
    _signUpBloc.add(PasswordChanged(password: _passwordController.text));

  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
