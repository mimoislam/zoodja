import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zoodja/ui/validator.dart';
part 'login_event.dart';
part  'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({@required UserRepository userRepository }):
  assert(userRepository!=null),
  _userRepository=userRepository, super(LoginState.empty())
  ;

  LoginState get initialState => LoginState.empty();


  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> events,
      TransitionFunction<LoginEvent, LoginState> transitionFn) {
    final nonDebounceStream =events.where((event) {
      return (event is !EmailChanged || event is !PasswordChanged);
    });
    final debounceStream = events.where((event){
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), transitionFn);

  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is EmailChanged){
      yield* _mapEmailChangedToState(event.email);
    }else if(event is PasswordChanged){
      yield*  _mapPasswordChangedToState(event.password);
    }
    else if(event is LoginWithCredentialsPressed){
      yield* _mapLoginWithCredentialsPressedToState();
    }

  }

 Stream<LoginState> _mapEmailChangedToState(String email) async*{
    yield  state.update(isEmailValid: Validators.isValidEmail(email));
 }

  Stream<LoginState> _mapPasswordChangedToState(String password) async*{
    yield  state.update(isPasswordValid: Validators.isValidPassword(password));

  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState()async* {
    yield LoginState.loading();
    try{
      // bool exs=await _userRepository.LoginWithPhoneAndPassword(phone, password);
      yield LoginState.success();
    }
    catch(e){
          LoginState.failure();
    }
  }
}
