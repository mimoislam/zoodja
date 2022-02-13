import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoodja/bloc/verification/verification_bloc.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/widgets/loginForm.dart';
import 'package:zoodja/ui/widgets/verifyForm.dart';


class Verify extends StatelessWidget {
  final UserRepository _userRepository;
  final String verification;
  const Verify({@required UserRepository userRepository,@required String verification}):
        assert(userRepository !=null),
        _userRepository=userRepository ,
        verification=verification ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<VerificationBloc>(
        create: (context)=>VerificationBloc(userRepository: _userRepository,verification:verification ),
        child: VerifyForm(userRepository: _userRepository,),
      ),
    );
  }
}
