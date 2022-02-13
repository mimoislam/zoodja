part of 'verification_bloc.dart';

abstract class VerificationEvent extends Equatable {
  const VerificationEvent();
  @override
  List <Object> get props=>[];
}

class Submitting extends VerificationEvent{
  final String verification;
  final String code ;
  Submitting({@required this.code,@required this.verification});

  @override
  List <Object> get props=>[code,verification];

}