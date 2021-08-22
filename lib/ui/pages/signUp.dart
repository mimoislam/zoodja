import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoodja/bloc/signup/sign_up_bloc.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/widgets/signUpForm.dart';

class SignUp extends StatefulWidget {
  final UserRepository _userRepository;

  const SignUp({@required UserRepository userRepository}):
        assert(userRepository !=null),
        _userRepository=userRepository ;
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  SignUpBloc _signUpBloc;
  UserRepository get _userRepository =>widget._userRepository;


  @override
  void initState() {
    _signUpBloc=SignUpBloc(userRepository: _userRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD

=======
      appBar: AppBar(
        title: Text('Sign Up',style: TextStyle(fontSize: 36),),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
>>>>>>> 87ba94ecb173ca7d4b667afe7ae2b79ed8c4cc90
      body: BlocProvider<SignUpBloc>(
        create: (context)=>SignUpBloc(userRepository: _userRepository),
        child: SignUpForm(userRepository: _userRepository,),
      ),
    );
  }
}
