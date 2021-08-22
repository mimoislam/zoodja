import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/pages/signUp.dart';
import 'package:zoodja/ui/pages/splash.dart';
import 'package:zoodja/ui/widgets/tabs.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserRepository _userRepository=UserRepository();
  AuthenticationBloc _authenticationBloc;


  @override
  void initState() {
    _authenticationBloc=AuthenticationBloc(userRepository: _userRepository);
    Timer(Duration(milliseconds: 4000), () {
      _authenticationBloc.add(AppStarted());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context)=>_authenticationBloc,
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
          home: BlocBuilder(
            bloc: _authenticationBloc,
            builder: (BuildContext context,AuthenticationState state){
                if (state is Uninitialised){
                  return Splash();
                }else{
                  return SignUp(userRepository: _userRepository);
                }
            },
          ),
    ),
    );
  }
}
