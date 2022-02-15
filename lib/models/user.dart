import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String uid;
  String name;
  String gender ;
  String withHijab ;
  String hijab ;
  String interestedIn;
  String photo;
  String profession;
  String line;
  String love;
  int ville;
  String email;
  String eyesColor;
  File photoFile;
  Timestamp age;
  DateTime ages;
  int filter;
  int refine;
  GeoPoint location ;
  List <String> tags;
  User(
      {this.uid,
      this.name,
      this.gender,
      this.interestedIn,
      this.photo,
      this.age,
      this.location,
        this.filter,
        this.withHijab,
        this.hijab,
        this.photoFile,
        this.ages,
        this.ville,
        this.eyesColor,
        this.email,
        this.profession,
      this.line,this.love,this.tags,this.refine});
  @override
  bool operator ==(Object other) => (other is User && other.uid == uid)||(other is String && other == uid);
  bool equals(Object user) {
    return (user is User && user.uid == uid)||(user is String && user == uid);
  }

}