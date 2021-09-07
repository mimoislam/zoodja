part of 'matches_bloc.dart';

abstract class MatchesState extends Equatable {
  const MatchesState();
  List<Object> get props => [];

}

class LoadingState extends MatchesState {}

class LoadUserState extends MatchesState {
  final Stream<QuerySnapshot> matchedList;
  final Stream<QuerySnapshot> selectedList;

  LoadUserState({this.matchedList, this.selectedList});

  List<Object> get props => [matchedList,selectedList];

}
