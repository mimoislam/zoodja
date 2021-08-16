import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/bloc/login/login_bloc.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/pages/signUp.dart';

class LoginForm extends StatefulWidget {
final UserRepository _userRepository;

const LoginForm({@required UserRepository userRepository}):
      assert(userRepository !=null),
      _userRepository=userRepository ;  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  LoginBloc _loginBloc;
  bool  get isPopulated=> _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoggedInButtonEnabled(LoginState state){
    return isPopulated && !state.isSubmitting;
  }
  _onFormSubmitted(){
    print('okay');
    _loginBloc.add(
        LoginWithCredentialsPressed
          (
            email: _emailController.text,
            password: _passwordController.text
        )
    );

  }

  @override
  void initState() {
    _loginBloc=BlocProvider.of<LoginBloc>(context);
    _emailController.addListener( _onEmailChanged);
    _passwordController.addListener(onPasswordChanged);
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
            return SingleChildScrollView(
              child: Container(
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
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: isLoggedInButtonEnabled(state)
                              ?_onFormSubmitted
                              :null,
                          child: Container(
                            width: size.width*0.7,
                            height: size.height*0.05,
                            decoration: BoxDecoration(
                              color: isLoggedInButtonEnabled(state)?Colors.white:
                              Colors.grey,
                              borderRadius: BorderRadius.circular(size.height*0.04),

                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: size.height*0.025,
                                  color: Colors.blue,
                                ),
                              ),
                            ),

                          ),
                        ),
                        SizedBox(height: size.height*0.02,),
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
                              "Are you new ? Get an Account",
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
              ),
            );
          }
      ),
        );
  }



  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));

  }

  void onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));

  }
  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
