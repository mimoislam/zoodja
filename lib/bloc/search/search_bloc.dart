import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:zoodja/models/user.dart';
import 'package:zoodja/repositories/searchRepository.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/widgets/photo.dart';

part 'search_event.dart';
part 'search_state.dart';
class SearchBloc extends Bloc<SearchEvent, SearchState> {

  SearchRepository _searchRepository;
  List <Widget> list=[];
  List <User> listUsers=[];
  List <String> listUsersID=[];
  User currentUser;
  changeRefine()async{
    await _searchRepository.updateRefine(currentUser.uid);
    currentUser.refine=true;
  }
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
      yield* _mapLoadUserToState(currentUserId:event.userId,);
    }


  }

  Stream<SearchState> _mapSelectToState({String currentUserId, String selectedUserId, String name, String photoUrl}) async*{

   if(list.length==0){
     yield LoadingState();

   }
   await _searchRepository.chooseUser(
         currentUserId, selectedUserId, name, photoUrl);

   if(currentUser==null)
      currentUser = await _searchRepository.getUserInterests(currentUserId);
   List<User> user=await _searchRepository.getUser(userId: currentUserId,usersId: listUsersID,currentUser: currentUser);
   listUsers=listUsers+user;
   List<String>usersId = user.map((item) => item.uid).toList();

   List<Widget> usersPhotos = user.map((item) => PhotoWidget(photoLink: item.photo)).toList();

   listUsersID=listUsersID+usersId;
   list=list+usersPhotos;
     yield LoadUserState( currentUser: currentUser);

  }

  Stream<SearchState> _mapPassToState({String currentUserId, String selectedUserId}) async*{
    if(list.length==0){
      yield LoadingState();
    }    await _searchRepository.passUser(currentUserId, selectedUserId);

    if(currentUser==null)
     currentUser=await _searchRepository.getUserInterests(currentUserId);

    List<User> user=await _searchRepository.getUser(userId: currentUserId,usersId: listUsersID,currentUser: currentUser);
    listUsers=listUsers+user;
    List<String>usersId = user.map((item) => item.uid).toList();
    List<Widget> usersPhotos = user.map((item) => PhotoWidget(photoLink: item.photo)).toList();

    listUsersID=listUsersID+usersId;
    list=list+usersPhotos;
    yield LoadUserState(currentUser: currentUser);

  }

  Stream<SearchState>_mapLoadUserToState({String currentUserId})async*{
    yield LoadingState();




    if(currentUser==null)
     currentUser=await _searchRepository.getUserInterests(currentUserId);

    List<User> user=await _searchRepository.getUser(userId: currentUserId,usersId: listUsersID,currentUser: currentUser);

    listUsers=listUsers+user;
    List<String>usersId = user.map((item) => item.uid).toList();
    List<Widget> usersPhotos = user.map((item) => PhotoWidget(photoLink: item.photo)).toList();

    listUsersID=listUsersID+usersId;
    list=list+usersPhotos;

    yield LoadUserState(currentUser: currentUser);
  }
}