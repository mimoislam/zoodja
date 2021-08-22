import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoodja/bloc/login/login_bloc.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/widgets/loginForm.dart';

class Login extends StatelessWidget {
  final UserRepository _userRepository;
  const Login({@required UserRepository userRepository}):
        assert(userRepository !=null),
        _userRepository=userRepository ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login In',style: TextStyle(fontSize: 36),),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context)=>LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository,),
      ),
    );
  }
}
