part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable{
  @override
  List <Object> get props=>[];
  const AuthenticationState();
}

class Uninitialised extends AuthenticationState {}

class Authenticated extends AuthenticationState{
  final String userId;

  Authenticated(this.userId);
  List <Object> get props=>[userId];
  String toString()=>"Authenticated $userId";
}
class AuthenticatedButNoSet extends AuthenticationState{
  final String userId;
  AuthenticatedButNoSet(this.userId);
  List <Object> get props=>[userId];


}
class UnAuthenticated extends AuthenticationState{}
