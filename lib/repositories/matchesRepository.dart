import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoodja/models/user.dart';

class MatchesRepository{
  final FirebaseFirestore _firestore;
  MatchesRepository({ FirebaseFirestore fireStore}):
        _firestore = fireStore ?? FirebaseFirestore.instance;

  Stream <QuerySnapshot>getMatchedList(userId){
    return _firestore.
    collection("users").
    doc(userId).
    collection("matchedList").
    snapshots();
  }
  Stream <QuerySnapshot>getSelectedList(userId){
    return _firestore.
    collection("users").
    doc(userId).
    collection("selectedList").snapshots();
  }

  Future<User> getUserDetails(userId)async{
    User _user=User();
    await _firestore.
    collection("users").
    doc(userId).
    get().then((value) {
      _user.uid=value.id;
      _user.name=value["name"];
      _user.age=value["age"];
      _user.photo=value["photourl"];
      _user.gender=value["gender"];
      _user.interestedIn=value["interestedIn"];

    });
    return _user;
  }
  openChat({currentUserId,selectedUserId})async{
    await _firestore.
    collection("users").
    doc(currentUserId).
    collection("chats").
    doc(selectedUserId).
    set({
      "timestamp":DateTime.now()
    });
    await _firestore.
    collection("users").
    doc(selectedUserId).
    collection("chats").
    doc(currentUserId).
    set({
      "timestamp":DateTime.now()
    });

    await _firestore.
    collection("users").
    doc(currentUserId).
    collection("matchedList").
    doc(selectedUserId).
    delete();


    await _firestore.
    collection("users").
    doc(selectedUserId).
    collection("matchedList").
    doc(currentUserId).
    delete();
  }
  void deleteUser({currentUserId,selectedUserId})async{
    await _firestore.
    collection("users").
    doc(selectedUserId).
    collection("matchedList").
    doc(currentUserId).
    delete();
  }

  selectUser({currentUserId,
    selectedUserId,
    currentUserName,
    currentUserPhotoUrl,
    selectUserName,
    selectUserPhotoUrl})async{
    deleteUser(currentUserId: currentUserId,selectedUserId: selectedUserId);
    await _firestore.
    collection("users").
    doc(currentUserId).
    collection("matchedList").
    doc(selectedUserId).set({
      "name":selectedUserId,
      "photourl":selectUserPhotoUrl,
    });
    return await _firestore.
    collection("users").
    doc(currentUserId).
    collection("matchedList").
    doc(selectedUserId).set({
      "name":selectedUserId,
      "photourl":selectUserPhotoUrl,
    });


  }
}