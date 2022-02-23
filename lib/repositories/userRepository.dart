
import 'dart:io';
import 'package:image/image.dart' as Img;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zoodja/models/user.dart' as user;

class UserRepository{
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;


  UserRepository({FirebaseAuth firebaseAuth, FirebaseFirestore fireStore}):
       _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
  _firestore = fireStore ?? FirebaseFirestore.instance;


  Future<bool>checkEmail(String email )async{
    bool s=false;

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,password: "ssssssss");
    }
     catch  (e)
    {
        s=true;

    }
    return s;
  }
  Future<void> saveTokenToDatabase(String token,String userId) async {
    // Assume user is logged in for this example
    bool firstTime=await isFirstTime(userId);
    print("firstTime");
    print(firstTime);
    if(firstTime){
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({
      'tokens':token,
    });}
  }
  Future<bool>isFirstTime(String userId)async{
    bool exist;
    await FirebaseFirestore.instance.collection('users').doc(userId).get().then((value) =>{exist=value.exists} );
    return exist;
  }

  Future<String> verifyPhoneNumber( String phone,Function change,Function change2 )async{
     await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (String verificationId, int resendToken) async {
        change2(verificationId);

      },
      verificationFailed: (FirebaseAuthException error) {
        print(error);
      },
       codeAutoRetrievalTimeout: (String verificationId) {  },
       verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async{
         await signInWithCredential(phoneAuthCredential);
         change();
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
   await _firebaseAuth.signInWithCredential(credential).catchError((error) {
     // do something with the error
     print("error");
     print(error);
   });
   String token = await FirebaseMessaging.instance.getToken();
   await saveTokenToDatabase(token,FirebaseAuth.instance.currentUser.uid);
   print("object2");

  }

  Future deleteUser() async {
    try {
     await _firebaseAuth.currentUser.delete();

    } catch (e) {

    }
  }

updateToken()async{
    String s=await FirebaseMessaging.instance.getToken();
  await _firestore.collection('users').doc((_firebaseAuth.currentUser).uid).set({
    'tokens':s,
  });
}


  Future <void> signout()async
  {
    await _firestore.collection('users').doc(_firebaseAuth.currentUser.uid).update({
      'refine':0,
    });
    return await _firebaseAuth.signOut();
  }
  Future <bool>isSignedIn()async{
  final currentUser =_firebaseAuth.currentUser;
  return currentUser !=null;
  }
  Future <String>getUser()async{
    return (_firebaseAuth.currentUser).uid;
  }
  Future <void>profileSetup({user.User user,String userId})async{
    UploadTask uploadTask;
    File img;

      Img.Image image = Img.decodeImage(user.photoFile.readAsBytesSync());
      image=Img.copyResize(image, width: 500);
      Directory root  = await getTemporaryDirectory();
      String directoryPath = root.path+'/bozzetto_camera';
      await Directory(directoryPath).create(recursive: true);
      String filePath = '$directoryPath/${DateTime.now()}.jpg';
      img=new File(filePath)
        ..writeAsBytesSync(Img.encodePng(image));
      uploadTask =
          FirebaseStorage.instance.ref().child('userPhotos').child(userId)
              .child(userId)
              .putFile(img);
      String token = await FirebaseMessaging.instance.getToken();

    return await uploadTask.then((ref) async {
      await ref.ref.getDownloadURL().then((url) async {
        img.delete();
      await _firestore.collection('users').doc(userId).set({
        'uid':userId,
        'photourl':url,
        'name':user.name,
        'location':user.location,
        'gender':user.gender,
        'interestedIn':user.interestedIn,
        'age':user.ages,
        "filter":500,
        "hijab":user.hijab,
        "eyesColor":user.eyesColor,
        "email":user.email,
        "ville":user.ville,
        "line":user.line,
        "love":user.love,
        "withHijab":null,
        'tokens':token,
        "tags":user.tags,
        "refine":0
      });
      });
    });


  }
  Future <void>profileUpdate(
      File photo,
      String userId,
      int filter,
      List<String> list,
      withHijab,
      hijab,line
      )async{
    File img;
    UploadTask uploadTask;
    if(photo!=null) {
      Img.Image image = Img.decodeImage(photo.readAsBytesSync());
      image=Img.copyResize(image, width: 500);
       Directory root  = await getTemporaryDirectory();
      String directoryPath = root.path+'/bozzetto_camera';
      await Directory(directoryPath).create(recursive: true);
      String filePath = '$directoryPath/${DateTime.now()}.jpg';
      img=new File(filePath)
        ..writeAsBytesSync(Img.encodePng(image));
      uploadTask =
          FirebaseStorage.instance.ref().child('userPhotos').child(userId)
              .child(userId)
              .putFile(img);
    }
    return photo!=null?await uploadTask.then((ref) async {
      await ref.ref.getDownloadURL().then((url) async {
        img.delete();

        await _firestore.collection('users').doc(userId).update({
          'photourl':url,
          "filter":filter,
           "tags":list,
          "withHijab":withHijab,
          "hijab":hijab,
          "line":line
        });
      });
    }): await _firestore.collection('users').doc(userId).update({
      "filter":filter,
      "tags":list,
      "withHijab":withHijab,
      "hijab":hijab,
      "line":line

    });

  }
  }