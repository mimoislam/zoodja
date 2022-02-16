part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends  Equatable {
  const AuthenticationEvent();
  @override
  List <Object> get props=>[];

}

class AppStarted extends AuthenticationEvent{}

class LoggedIn extends AuthenticationEvent{}
class GotoCreation extends AuthenticationEvent{
  final String userId;
  GotoCreation(this.userId);
  List <Object> get props=>[userId];
}

class LoggedOut extends AuthenticationEvent{}
class ToOnBoarding extends AuthenticationEvent{}
class ConfirmEvent  extends AuthenticationEvent{
  final String verification;
  ConfirmEvent(this.verification);
  List <Object> get props=>[verification];
}
