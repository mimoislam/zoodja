import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:meta/meta.dart';
import 'package:zoodja/repositories/userRepository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required UserRepository userRepository}):
        assert(userRepository!=null),
        this.userRepository=userRepository, super(Uninitialised());

  AuthenticationState get initialState => Uninitialised();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();

    }else if(event is LoggedOut){
      yield*_mapLoggedOutToState();
    }
    else if (event is ToOnBoarding){
      yield* _mapToLogin();

    }
    else if (event is ConfirmEvent){
      yield* _mapConfirmToState(event.verification);
    }
    else if (event is GotoCreation){
      yield* _mapConditionToState(userId:event.userId);
    }
  }
 Stream<AuthenticationState> _mapStartedToState()async* {
    try{
      final isSignedIn = await userRepository.isSignedIn();
      if(true){
        //final uid = await userRepository.getUser();
        final uid = "zAuL7EScPpaX5O3AwByhro6DhwX2";
        final isFirstTime=await userRepository.isFirstTime(uid);
        if(false){
          yield AuthenticatedButNoSet1(uid);
        }else{
          String token = await FirebaseMessaging.instance.getToken();
          await userRepository.saveTokenToDatabase(token,uid);
          yield Authenticated(uid);
        }
      }else{
        yield OnBoarding();
      }
    }catch(e){
      print(e);
      yield UnAuthenticated();
    }
 }

  Stream<AuthenticationState> _mapLoggedInToState() async*{
    String uid=await userRepository.getUser();
    final isFirstTime=await userRepository.isFirstTime(uid);
    if(!isFirstTime){
      yield AuthenticatedButNoSet1(await userRepository.getUser());
    }else{
      String token = await FirebaseMessaging.instance.getToken();
      await userRepository.saveTokenToDatabase(token,uid);
      yield Authenticated(await userRepository.getUser());
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState()async* {
        yield UnAuthenticated();
        userRepository.signout();
  }

  Stream<AuthenticationState> _mapConfirmToState(String verification) async*{
    yield Confirm(verification);
  }

  Stream<AuthenticationState> _mapToLogin() async*{
    yield UnAuthenticated();
  }

  Stream<AuthenticationState>_mapConditionToState({String userId}) async*{
    yield AuthenticatedButNoSet(userId);

  }
}
