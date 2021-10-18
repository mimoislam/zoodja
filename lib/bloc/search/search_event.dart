part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
@override
List<Object> get props => [];

}

class LoadUserEvent extends SearchEvent{
  final String userId;
  final List <User> users;
  LoadUserEvent({this.userId,this.users});
  @override
  List<Object> get props => [userId,users];
}
class LoadedUserEvent extends SearchEvent{
  final String userId;
  LoadedUserEvent({this.userId});
  @override
  List<Object> get props => [userId];
}
class ChangeUserEvent extends SearchEvent{
  final String userId;
  ChangeUserEvent({this.userId});
  @override
  List<Object> get props => [userId];
}
class SelectUserEvent extends SearchEvent{
  final String currentUserId,selectedUserId,name,photoUrl;

  SelectUserEvent({this.currentUserId, this.selectedUserId, this.name, this.photoUrl});
  @override
  List<Object> get props => [currentUserId,selectedUserId,name,photoUrl];
}
class PassUserEvent extends SearchEvent{
  final String currentUserId,selectedUserId;
  PassUserEvent({this.currentUserId, this.selectedUserId});
  @override
  List<Object> get props => [currentUserId,selectedUserId];
}