
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    print('okay');
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
            }
        },
        child: BlocBuilder<SignUpBloc,SignUpState>(
          bloc: _signUpBloc,
          builder: (BuildContext context,SignUpState state){
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:Container(
                color: backgroundColor,
                width: size.width,
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('Chill',
                        style: TextStyle(fontSize: size.width*0.2, color: Colors.white,),),
                    ),
                    Container(
                      width: size.width*0.8,
                      child: Divider(height: size.height*0.05,
                        color: Colors.white,

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(size.height*0.02),
                      child: TextFormField(
                        controller: _emailController,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (_){
                          return !state.isEmailValid?'Invalid Email':null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: size.height*0.03
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,width: 1),
                          ),
                        ),
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.all(size.height*0.02),
                      child: TextFormField(
                        controller: _passwordController,
                        autocorrect: false,
                        obscureText: true,

                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (_){
                          return !state.isPasswordValid?'Invalid Password':null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: size.height*0.03
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,width: 1),
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
                          height: size.height*0.05,
                          decoration: BoxDecoration(
                            color: isSignUpButtonEnabled(state)?Colors.white:
                                Colors.grey,
                            borderRadius: BorderRadius.circular(size.height*0.04),

                          ),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: size.height*0.025,
                                color: Colors.blue,
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
