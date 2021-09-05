import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
  }
 Stream<AuthenticationState> _mapStartedToState()async* {
    try{
      final isSignedIn = await userRepository.isSignedIn();
      if(isSignedIn){
        final uid = await userRepository.getUser();
        final isFirstTime=await userRepository.isFirstTime(uid);
        if(!isFirstTime){
          yield AuthenticatedButNoSet(uid);
        }else{
          yield Authenticated(uid);
        }
      }else{
        yield UnAuthenticated();
      }
    }catch(e){
      yield UnAuthenticated();

    }
 }

  Stream<AuthenticationState> _mapLoggedInToState() async*{
    final isFirstTime=await userRepository.isFirstTime(await userRepository.getUser());
    if(!isFirstTime){
      yield AuthenticatedButNoSet(await userRepository.getUser());
    }else{
      yield Authenticated(await userRepository.getUser());
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState()async* {
        yield UnAuthenticated();
        userRepository.signout();
  }
}
