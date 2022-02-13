import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:zoodja/repositories/userRepository.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  UserRepository _userRepository;
  String verification;
  VerificationBloc({@required UserRepository userRepository,@required String verification }):
        assert(userRepository!=null),
        _userRepository=userRepository,
        verification=verification,
      super(VerificationState.empty())
  ;


  @override
  Stream<VerificationState> mapEventToState(VerificationEvent event) async*{
    if (event is Submitting) {
      yield* _submitToState(event.code,event.verification);
    }
  }

  Stream<VerificationState>_submitToState(String code,String verification1)async* {
    yield VerificationState.loading();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verification1, smsCode: code);
    print(credential);
    try{
      await _userRepository.signInWithCredential(credential);
      yield VerificationState.success();
      print("object1");

    }catch(e){
      print(e);
      print("error verification");
      yield VerificationState.failure();
    }
  }
}
