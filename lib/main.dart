import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/bloc/blocDelegate.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/pages/home.dart';
void main() async{
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final UserRepository userRepository=UserRepository();
      Bloc.observer = SimpleBlocDelegate();
      runApp(
          BlocProvider(create: (context) => AuthenticationBloc(userRepository: userRepository)..add(AppStarted()) ,
          child: Home(userRepository:userRepository),
          ));
}

