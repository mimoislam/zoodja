part of 'login_bloc.dart';


@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();


  @override
  List <Object> get props=>[];

}

class EmailChanged extends LoginEvent{
  final String email;

  EmailChanged({@required this.email});
  @override
  List <Object> get props=>[email];

  @override
  String toString()=>'Email Changed {email: $email}';
}
class PasswordChanged extends LoginEvent{
  final String password;

  PasswordChanged({@required this.password});
  @override
  List <Object> get props=>[password];

  @override
  String toString()=>'Password Changed {email: $password}';
}

class Submitted extends LoginEvent{
  final  String email;
  final String password;

    Submitted({this.email, this.password});
  @override
  List <Object> get props=>[email,password];
}
class LoginWithCredentialsPressed extends LoginEvent{


  LoginWithCredentialsPressed();
  @override
  List <Object> get props=>[];
}

