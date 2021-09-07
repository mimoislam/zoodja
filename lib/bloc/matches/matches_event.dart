part of 'matches_bloc.dart';

abstract class MatchesEvent extends Equatable {
  const MatchesEvent();
  List<Object> get props => [];

}

class LoadListsEvent extends MatchesEvent{
  final String userId;

  LoadListsEvent({this.userId});
  List<Object> get props => [userId];


}
class AcceptUserEvent extends MatchesEvent {
  final String currentUser,currentUserName,currentUserPhotoUrl,selectedUser,selectedUserName,selectedUserPhotoUrl;

  AcceptUserEvent(
      {this.currentUser,
      this.currentUserName,
      this.currentUserPhotoUrl,
      this.selectedUser,
      this.selectedUserName,
      this.selectedUserPhotoUrl});
  List<Object> get props => [currentUser,currentUserName,currentUserPhotoUrl,
    selectedUser,selectedUserName,selectedUserPhotoUrl];


}
class DeleteUserEvent extends MatchesEvent {

  final String currentUser,selectedUser;

  DeleteUserEvent({this.currentUser, this.selectedUser});
  List<Object> get props => [currentUser,
    selectedUser];
}
class OpenChatEvent extends MatchesEvent {

  final String currentUser,selectedUser;

  OpenChatEvent({this.currentUser, this.selectedUser});
  List<Object> get props => [currentUser,
    selectedUser];
}