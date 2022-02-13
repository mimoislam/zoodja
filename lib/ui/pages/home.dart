
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/pages/login.dart';
import 'package:zoodja/ui/pages/onBording.dart';
import 'package:zoodja/ui/pages/profile.dart';
import 'package:zoodja/ui/pages/splash.dart';
import 'package:zoodja/ui/pages/verify.dart';
import 'package:zoodja/ui/widgets/tabs.dart';

class Home extends StatelessWidget {
  final UserRepository _userRepository;
   Home({@required UserRepository userRepository}):
        assert(userRepository !=null),
        _userRepository=userRepository ;



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:BlocBuilder<AuthenticationBloc,AuthenticationState>(
        builder: (context,state){
  if (state is Uninitialised){
    return Splash();
  }if(state is Authenticated){
    return Tabs(userId: state.userId,);
  }if(state is AuthenticatedButNoSet){
    return Profile(userRepository: _userRepository,userId: state.userId,);
  }
  if(state is UnAuthenticated) {
    return Login(userRepository: _userRepository);
  }
  if (state is Confirm){

    return Verify(userRepository: _userRepository,verification: state.verification,);
  }
  if (state is OnBoarding){
    return OnBoardingScreen(userRepository: _userRepository);

  }

  else
    return Container();

},
    ) ,);
  }
}
