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
  String ville;
  String email;
  String eyesColor;
  File photoFile;
  Timestamp age;
  DateTime ages;
  int filter;
  GeoPoint location ;
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
      this.line,this.love});
}