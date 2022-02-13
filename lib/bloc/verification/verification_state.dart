part of 'verification_bloc.dart';


@immutable
class VerificationState{
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  VerificationState(
      {
        @required this.isSubmitting,
        @required   this.isSuccess,
        @required this.isFailure});
  factory VerificationState.empty(){
    return VerificationState(

        isSubmitting: false,
        isSuccess: false,
        isFailure: false);
  }
  factory VerificationState.loading(){
    return VerificationState(
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }
  factory VerificationState.failure(){
    return VerificationState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true);
  }
  factory VerificationState.success(){
    return VerificationState(
        isSubmitting: false,
        isSuccess: true,
        isFailure: false);
  }


  VerificationState copyWith(
      {bool isEmailValid,
        bool isPasswordValid,
        bool isSubmitEnable,
        bool isSubmitting,
        bool isSuccess,
        bool isFailure}) {
    return VerificationState(
        isSubmitting: isSubmitting??this.isSubmitting,
        isSuccess: isSuccess??this.isSuccess,
        isFailure: isFailure??this.isFailure
    );
  }
}