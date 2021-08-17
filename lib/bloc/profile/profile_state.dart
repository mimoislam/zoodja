part of 'profile_bloc.dart';

@immutable
class ProfileState{
  final bool isPhotoEmpty;
  final bool isNameEmpty;
  final bool isAgeEmpty;
  final bool isGenderEmpty;
  final bool isInterestedEmpty;
  final bool isLocationEmpty;
  final bool isFailure;
  final bool isSubmitting;
  final bool isSuccess;
  bool get isFormValid=> isPhotoEmpty&&isNameEmpty&&isAgeEmpty&&isGenderEmpty&&isInterestedEmpty&&isInterestedEmpty;

  ProfileState(
      { @required this.isPhotoEmpty,
        @required this.isNameEmpty,
        @required this.isAgeEmpty,
        @required this.isGenderEmpty,
        @required this.isInterestedEmpty,
        @required this.isLocationEmpty ,
        @required this.isSubmitting,
        @required   this.isSuccess,
        @required this.isFailure});
  factory ProfileState.empty(){
    return  ProfileState(
        isPhotoEmpty: false,
        isNameEmpty: false,
        isAgeEmpty: false,
        isGenderEmpty: false,
        isInterestedEmpty: false,
        isLocationEmpty: false,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false);
  }
  factory ProfileState.loading(){
    return  ProfileState(
        isPhotoEmpty: false,
        isNameEmpty: false,
        isAgeEmpty: false,
        isGenderEmpty: false,
        isInterestedEmpty: false,
        isLocationEmpty: false,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }
  factory ProfileState.failure(){
    return  ProfileState(
        isPhotoEmpty: false,
        isNameEmpty: false,
        isAgeEmpty: false,
        isGenderEmpty: false,
        isInterestedEmpty: false,
        isLocationEmpty: false,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true);
  }
  factory ProfileState.success(){
    return  ProfileState(
        isPhotoEmpty: false,
        isNameEmpty: false,
        isAgeEmpty: false,
        isGenderEmpty: false,
        isInterestedEmpty: false,
        isLocationEmpty: false,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false);
  }
  ProfileState update({
   bool isPhotoEmpty,
   bool isNameEmpty,
   bool isAgeEmpty,
   bool isGenderEmpty,
   bool isInterestedEmpty,
   bool isLocationEmpty,
  }){
    return copyWith(
      isPhotoEmpty: isPhotoEmpty,
      isNameEmpty: isNameEmpty,
      isAgeEmpty: isAgeEmpty,
      isGenderEmpty: isGenderEmpty,
      isInterestedEmpty: isInterestedEmpty,
      isLocationEmpty: isLocationEmpty,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false);
  }

  ProfileState copyWith(
      {bool isPhotoEmpty,
        bool isNameEmpty,
        bool isAgeEmpty,
        bool isGenderEmpty,
        bool isInterestedEmpty,
        bool isLocationEmpty,
        bool isSubmitting,
        bool isSuccess,
        bool isFailure}) {
    return ProfileState(
        isPhotoEmpty: isPhotoEmpty??this.isPhotoEmpty,
        isNameEmpty: isNameEmpty??this.isNameEmpty,
        isAgeEmpty: isAgeEmpty??this.isAgeEmpty,
        isGenderEmpty: isGenderEmpty??this.isPhotoEmpty,
        isInterestedEmpty: isInterestedEmpty??this.isGenderEmpty,
        isLocationEmpty: isLocationEmpty??this.isLocationEmpty,
        isSubmitting: isSubmitting??this.isSubmitting,
        isSuccess: isSuccess??this.isSuccess,
        isFailure: isFailure??this.isFailure
    );
  }

}