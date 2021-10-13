
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';

class UserRepository{
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  String verification;

  UserRepository({FirebaseAuth firebaseAuth, FirebaseFirestore fireStore}):
       _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
  _firestore = fireStore ?? FirebaseFirestore.instance;

  Future <void>signInWithEmail(String email, String password)async {
      await  _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      String token = await FirebaseMessaging.instance.getToken();
      print(token);

      // Save the initial token to the database
      await saveTokenToDatabase(token);
  }

  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    String userId = FirebaseAuth.instance.currentUser.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({
      'tokens':token,
    });
  }
  Future<bool>isFirstTime(String userId)async{
    bool exist;
    await FirebaseFirestore.instance.collection('users').doc(userId).get().then((value) =>{exist=value.exists} );
    return exist;
  }

  verifyPhoneNumber( String phone)async{
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (String verificationId, int resendToken) async {
        verification =verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {  },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {  },
      verificationFailed: (FirebaseAuthException error) {
        verification="";
      },
    );
  }


  Future<void>signUpWithEmail(String email, String password)async {
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    GeoPoint location=GeoPoint(position.latitude, position.longitude);
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    String uid =await getUser();
    await _firestore.collection('users').doc(uid).update({
      'location':location,
    });

  }
  signInWithCredential(credential)async{

   await _firebaseAuth.signInWithCredential(credential);
  }

  Future deleteUser() async {
    try {
     await _firebaseAuth.currentUser.delete();

    } catch (e) {

    }
  }

  LoginWithPhoneAndPassword(String phoneNumber, String password)async{
    bool exist=true;
    bool correctPassword=false;
    try{
      await _firebaseAuth.signInWithPhoneNumber(phoneNumber);
      String uid=_firebaseAuth.currentUser.uid;
      await _firestore.
      collection("users").
      doc(uid).
      get().then((value) {
        if(password==value["password"]){
          correctPassword=true;
        }
      });
    }
    catch(e){
      bool exist=false;

    }

  }

  Future <void> signout()async
  {

    return await _firebaseAuth.signOut();
  }
  Future <bool>isSignedIn()async{
  final currentUser =_firebaseAuth.currentUser;
  return currentUser !=null;
  }
  Future <String>getUser()async{
    return (_firebaseAuth.currentUser).uid;
  }
  Future <void>profileSetup(
      File photo,
      String userId,
      String name,
      String gender,
      String interestedIn,
      DateTime age,
      GeoPoint location,String hijab)async{
    print(hijab);
    UploadTask uploadTask;
    uploadTask=FirebaseStorage.instance.ref().child('userPhotos').child(userId).child(userId).putFile(photo);
    return await uploadTask.then((ref) async {
      await ref.ref.getDownloadURL().then((url) async {
      await _firestore.collection('users').doc(userId).set({
        'uid':userId,
        'photourl':url,
        'name':name,
        'location':location,
        'gender':gender,
        'interestedIn':interestedIn,
        'age':age,
        "filter":500,
        "hijab":hijab,

      });
      });
    });

  }
  Future <void>profileUpdate(
      File photo,
      String userId,
      String name,
      int filter,
      )async{
    UploadTask uploadTask;
    if(photo!=null)
    uploadTask=FirebaseStorage.instance.ref().child('userPhotos').child(userId).child(userId).putFile(photo);
    return photo!=null?await uploadTask.then((ref) async {
      await ref.ref.getDownloadURL().then((url) async {
        await _firestore.collection('users').doc(userId).update({
          'photourl':url,
          'name':name,
          "filter":filter
        });
      });
    }): await _firestore.collection('users').doc(userId).update({
      'name':name,
      "filter":filter
    });

  }
  }