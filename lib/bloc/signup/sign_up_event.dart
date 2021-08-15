part of 'sign_up_bloc.dart';


@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();


  @override
  List <Object> get props=>[];

}

class EmailChanged extends SignUpEvent{
  final String email;

  EmailChanged({@required this.email});
  @override
  List <Object> get props=>[email];

  @override
  String toString()=>'Email Changed {email: $email}';
}
class PasswordChanged extends SignUpEvent{
  final String password;

  PasswordChanged({@required this.password});
  @override
  List <Object> get props=>[password];

  @override
  String toString()=>'Password Changed {email: $password}';
}

class Submitted extends SignUpEvent{
  final  String email;
  final String password;

  Submitted({this.email, this.password});
  @override
  List <Object> get props=>[email,password];
}
class SignUpWithCredentialsPressed extends SignUpEvent{
  final String email;
  final String password;

  SignUpWithCredentialsPressed({@required this.email,@required this.password});
  @override
  List <Object> get props=>[email,password];
}

