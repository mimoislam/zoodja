import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String uid;
  String name;
  String gender ;
  String withHijab ;
  String hijab ;
  String interestedIn;
  String photo;
  Timestamp age;
  int filter;
  GeoPoint location ;
  User(
      {this.uid,
      this.name,
      this.gender,
      this.interestedIn,
      this.photo,
      this.age,
      this.location,this.filter,this.withHijab,this.hijab});
}