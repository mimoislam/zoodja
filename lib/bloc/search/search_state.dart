part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];

}

class InitialSearchState extends SearchState {
}

class LoadingState extends SearchState{}
class LoadUserState extends SearchState{
  final currentUser;
  final List <User> users;
  LoadUserState({this.users, this.currentUser});
  List<Object> get props => [users,currentUser];

  LoadUserState update({  User user ,User currentUser}){
    return copyWith( user: user,currentUser: currentUser);
  }

  LoadUserState copyWith(
      {User user,User currentUser}) {
    users.add(user);
    return LoadUserState(
      users: users,
      currentUser: currentUser
    );
  }

}
