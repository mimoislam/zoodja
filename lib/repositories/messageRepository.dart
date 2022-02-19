
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoodja/models/message.dart';
import 'package:zoodja/models/user.dart';

class MessageRepository{
  final FirebaseFirestore _firestore;
  MessageRepository({ FirebaseFirestore fireStore}):
        _firestore = fireStore ?? FirebaseFirestore.instance;
  Stream<QuerySnapshot> getChats({userId}){
    return _firestore.
    collection("users").
    doc(userId).
    collection("chats").
    orderBy("timestamp",descending: true).
    snapshots();
  }
  Future deleteChat({currentUserId,selectedUserId})async{
    return await _firestore.
    collection("users").
    doc(currentUserId).
    collection("chats").
    doc(selectedUserId).
    delete();
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
      _user.line=value["line"];
      _user.filter=value["filter"];
      _user.withHijab=value["withHijab"];
      _user.love=value["love"];
      _user.hijab=value["hijab"];
      _user.email=value["email"];
      _user.tags= value["tags"].cast<String>();
    });
    return _user;
  }
  Future<Message>getLastMessage({currentUserId,selectedUserId})async{
   Message _message=Message();
   await _firestore.
    collection("users").
    doc(currentUserId).
    collection("chats").
    doc(selectedUserId).
    collection("messages").
    orderBy("timestamp",descending: true).snapshots().first.then((value) async {
       await _firestore
           .collection('messages')
           .doc(value.docs.first.id)
           .get()
           .then((message) {
             _message.text = message['text'];
       _message.photoUrl = message['photoUrl'];
       _message.timestamp = message['timestamp'];
       _message.viewed = message['viewed'];
       _message.selectedUserId = message['senderId'];
       });
   }).onError((error, stackTrace) => _message=null);
  return _message;
  }

}