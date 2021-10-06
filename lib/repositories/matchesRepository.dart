import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoodja/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:zoodja/ui/constats.dart';

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
      _user.location=value["location"];
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
    collection("matchedmatchedList").
    doc(currentUserId).
    delete();
    await _firestore.
    collection("users").
    doc(currentUserId).
    collection("selectedList").
    doc(selectedUserId).
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
      "name":selectUserName,
      "photourl":selectUserPhotoUrl,
    });
    String token;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(selectedUserId)
        .get().then((value) {

      token=value["tokens"];

    });

    await sendLikedNotification(token);
    return await _firestore.
    collection("users").
    doc(selectedUserId).
    collection("matchedList").
    doc(currentUserId).set({
      "name":currentUserName,
      "photourl":currentUserPhotoUrl,
    });


  }

  sendLikedNotification(String token)async {
    if (token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':"key=AAAAzsv-U_o:APA91bHzogfxjbR4gS_5TvlIAqWnupWfRamYjKWshe3zEkheaVWjZdP9jJO1s4mn7Qj-xDpfSxQDQ7q3O7ShJJtKpbKAO4jPA-0jjeF3tHo3_eq1yIL27OCn9ssMhXZ4UrC0zMBA3aLa"
        },
        body: constructForMatch(token),
      );
    } catch (e) {
      print(e);
    }
  }
}