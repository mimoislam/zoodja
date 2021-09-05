import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoodja/bloc/profile/profile_bloc.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/widgets/profileForm.dart';

class Profile extends StatelessWidget {
  final UserRepository _userRepository;
  final String userId;
  const Profile({@required UserRepository userRepository,@required String userId}):
        assert(userRepository !=null &&userId!=null),
        _userRepository=userRepository ,userId=userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(userRepository: _userRepository),
          child: ProfileForm(userRepository: _userRepository,),
        ),
      ),
    ),
    );
  }
}
