import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:zoodja/models/user.dart';
import 'package:zoodja/repositories/searchRepository.dart';
import 'package:zoodja/repositories/userRepository.dart';

part 'search_event.dart';
part 'search_state.dart';
class SearchBloc extends Bloc<SearchEvent, SearchState> {

  SearchRepository _searchRepository;

  SearchBloc({@required SearchRepository searchRepository }):
        assert(searchRepository!=null),
        _searchRepository=searchRepository, super(InitialSearchState())
  ;

  SearchState get initialState => InitialSearchState();
  Stream<SearchState> mapEventToState(
      SearchEvent event,
      ) async* {
    if(event is SelectUserEvent){
      yield* _mapSelectToState(
          currentUserId:event.currentUserId,
          selectedUserId :event.selectedUserId,
          name:event.name,
          photoUrl:event.photoUrl
      );
    }
    if(event is PassUserEvent){
      yield* _mapPassToState(
        currentUserId:event.currentUserId,
        selectedUserId :event.selectedUserId,
      );
    }
    if(event is LoadUserEvent){
    yield* _mapLoadUserToState(currentUserId:event.userId,users:event.users);
}
  }

 Stream<SearchState> _mapSelectToState({String currentUserId, String selectedUserId, String name, String photoUrl}) async*{
    yield LoadingState();

    User user=await _searchRepository.chooseUser(currentUserId, selectedUserId, name, photoUrl);
    User currentUser=await _searchRepository.getUserInterests(currentUserId);

    yield LoadUserState(users: [user],currentUser: currentUser);

  }

  Stream<SearchState> _mapPassToState({String currentUserId, String selectedUserId}) async*{
    yield LoadingState();
    User user=await _searchRepository.passUser(currentUserId, selectedUserId);
    User currentUser=await _searchRepository.getUserInterests(currentUserId);
    yield LoadUserState(users: [user],currentUser: currentUser);

  }

  Stream<SearchState>_mapLoadUserToState({String currentUserId,List<User>users})async*{
    yield LoadingState();
    User user=await _searchRepository.getUser(currentUserId);
    User currentUser=await _searchRepository.getUserInterests(currentUserId);
    yield LoadUserState(users: [user],currentUser: currentUser);
  }
}
