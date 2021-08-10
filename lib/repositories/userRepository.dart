import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository{
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  UserRepository({FirebaseAuth firebaseAuth, FirebaseFirestore firestore}):
    _firebaseAuth=firebaseAuth,
    _firestore=firestore;

  Future <void>signInWithEmail(String email, String password) {
      return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  Future<bool>isFirstTIme(String userId)async{
    bool exist;
    await FirebaseFirestore.instance.collection('users').doc(userId).get().then((value) =>{exist=value.exists} );
    return exist;
  }
  Future<void>signUpWithEmail(String email, String password)async {
    print(_firebaseAuth);
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
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

  }