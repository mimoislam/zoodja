import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:zoodja/models/message.dart';
import 'package:http/http.dart' as http;
import 'package:zoodja/ui/constats.dart';


class MessagingRepository{
  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firestore;
  String uuid=Uuid().v4();
  MessagingRepository({FirebaseAuth firebaseAuth, FirebaseStorage fireStore}):
        _firebaseStorage = firebaseAuth ?? FirebaseStorage.instance,
        _firestore = fireStore ?? FirebaseFirestore.instance;


  sendMessage({Message message})async{
    UploadTask uploadTask;
    DocumentReference messageRef=_firestore.collection("messages").doc();
    CollectionReference senderRef=_firestore.
    collection("users").
    doc(message.senderId).
    collection("chats").
    doc(message.selectedUserId).
    collection("messages");


    CollectionReference sendUserRef= _firestore
        .collection("users")
        .doc(message.selectedUserId)
        .collection("chats")
        .doc(message.senderId)
        .collection("messages");

    if(message.photo!=null){
      Reference photoRef=_firebaseStorage
          .ref()
          .child("messages")
          .child(messageRef.id)
          .child(uuid);
      uploadTask=photoRef.putFile(message.photo);
      await uploadTask.then((photo) async {
        await photo.ref.getDownloadURL().then((value) async{
          await messageRef.set({
            "senderName":message.senderName,
            "senderId":message.senderId,
            "text":null,
            "photoUrl":value,
            "timestamp":DateTime.now(),
            "viewed":false,
          });
        });
      });
    senderRef.doc(messageRef.id).set({
      "timestamp":DateTime.now(),
    });

      sendUserRef.doc(messageRef.id).set({
        "timestamp":DateTime.now(),
      });

    _firestore.collection("users").doc(message.senderId).collection("chats").doc(message.selectedUserId).update({
      "timestamp":DateTime.now(),
    });

      _firestore.collection("users").doc(message.selectedUserId).collection("chats").doc(message.senderId).update({
        "timestamp":DateTime.now(),
      });
    }
    if(message.text!=null){
      await messageRef.set({
        "senderName":message.senderName,
        "senderId":message.senderId,
        "text":message.text,
        "photoUrl":null,
        "timestamp":DateTime.now(),
        "viewed":false,
      });
      senderRef.doc(messageRef.id).set({
        "timestamp":DateTime.now(),
      });

      sendUserRef.doc(messageRef.id).set({
        "timestamp":DateTime.now(),
      });
      await  _firestore.collection("users").doc(message.senderId).collection("chats").doc(message.selectedUserId).update({
        "timestamp":DateTime.now(),
      });
     await  _firestore.collection("users").doc(message.selectedUserId).collection("chats").doc(message.senderId).update({
        "timestamp":DateTime.now(),
      });
    }
    String token;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(message.selectedUserId)
        .get().then((value) {

      token=value["tokens"];

    });

    await sendPushMessage(token);

  }

  Future<void> sendPushMessage(token) async {
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
        body: constructForMessage(token),
      );
    } catch (e) {
      print(e);
    }
  }
  Stream<QuerySnapshot>getMessages({currentUserId,selectedUserId}){
    return _firestore
        .collection("users")
        .doc(currentUserId)
        .collection("chats")
        .doc(selectedUserId)
        .collection("messages")
        .orderBy("timestamp",descending:false)
        .snapshots();
  }
  Future<Message>getMessageDetail({messageId})async{
    Message message=Message();
    await _firestore
        .collection("messages")
        .doc(messageId)
        .get()
        .then((value) {
          message.senderId=value["senderId"];
          message.senderName=value["senderName"];
          message.timestamp=value["timestamp"];
          message.text=value["text"];
          message.photoUrl=value["photoUrl"];
    });
    return message;
  }

}