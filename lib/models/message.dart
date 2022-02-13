import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderName, senderId, selectedUserId, text, photoUrl,uid;
  File photo;
  Timestamp timestamp;
  bool viewed;
  bool isSend=false;
  Message(
      {this.senderName,
        this.senderId,
        this.selectedUserId,
        this.text,
        this.photoUrl,
        this.photo,
        this.timestamp,
        this.viewed,
        this.uid,
        this.isSend});

  bool equals(Message message) {
    return message.uid==this.uid ;
  }

  @override
  bool operator ==(Object other) => other is Message && other.uid == uid;

  changeSend(){
    this.isSend=!this.isSend;
  }

}