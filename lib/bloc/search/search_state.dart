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
  final User currentUser;

  LoadUserState({ this.currentUser});
  List<Object> get props => [currentUser];


}