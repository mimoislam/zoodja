import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as Img;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
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

  DocumentReference getMessageRef(){
    DocumentReference messageRef= _firestore.collection("messages").doc();
    return messageRef;
  }

  sendMessage({Message message,DocumentReference messageRef})async{
    UploadTask uploadTask;
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
      File img;

      Img.Image image = Img.decodeImage(message.photo.readAsBytesSync());
      image=Img.copyResize(image, width: 500);
      Directory root  = await getTemporaryDirectory();
      String directoryPath = root.path+'/bozzetto_camera';
      await Directory(directoryPath).create(recursive: true);
      String filePath = '$directoryPath/${DateTime.now()}.jpg';
      img=new File(filePath)
        ..writeAsBytesSync(Img.encodePng(image));
      uploadTask =
          photoRef
              .putFile(img);
      await uploadTask.then((photo) async {
        await photo.ref.getDownloadURL().then((value) async{
          img.delete();
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
    print("message.selectedUserId");
    print(message.selectedUserId);
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
          'Authorization':Authorization },
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
        .orderBy("timestamp",descending: true).limit(10)
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
          message.isSend=true;
    });
    return message;
  }

}