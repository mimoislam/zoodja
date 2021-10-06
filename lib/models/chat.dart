
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat{
   String name,photoUrl,lastMessagePhoto,lastMessage,lastMessageSenderId;
  Timestamp timestamp;
  bool viewed;

  Chat({this.name, this.viewed,this.photoUrl, this.lastMessagePhoto, this.lastMessage,this.timestamp,this.lastMessageSenderId});


}