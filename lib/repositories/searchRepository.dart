import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zoodja/models/user.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:http/http.dart' as http;

class SearchRepository {
  final FirebaseFirestore _firestore;
  int sizeOfUsers=5;
  SearchRepository({FirebaseFirestore firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;
  chooseUser(currentUserId, selectedUserId, name, photoUrl) async {
    List selectedList=await getSelectedList(currentUserId);
    if(selectedList.contains(selectedUserId)){
      User selectedUser=await getUserInterests(selectedUserId);
      await selectUser(
        currentUserId: currentUserId,
        currentUserName: name,
        currentUserPhotoUrl: photoUrl,
        selectedUserId: selectedUserId,
        selectUserName: selectedUser.name,
        selectUserPhotoUrl: selectedUser.photo
      );

    }else{
      await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('chosenList')
          .doc(selectedUserId)
          .set({});



      await _firestore
          .collection('users')
          .doc(selectedUserId)
          .collection('selectedList')
          .doc(currentUserId)
          .set({
        'name': name,
        'photoUrl': photoUrl,
      });
      String token;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(selectedUserId)
          .get().then((value) {

        token=value["tokens"];

      });
      sendLikedNotification(token);
    }

  }
  updateRefine(String userId)async{
    await _firestore.collection('users').doc(userId).set({
      'refine':true,
    });

  }
  passUser(currentUserId, selectedUserId) async {


    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('chosenList')
        .doc(selectedUserId)
        .set({});
  }

  Future getUserInterests(userId) async {
    User currentUser = User();

    await _firestore.collection('users').doc(userId).get().then((user) {
      currentUser.name = user['name'];
      currentUser.photo = user['photourl'];
      currentUser.gender = user['gender'];
      currentUser.interestedIn = user['interestedIn'];
      currentUser.filter = user['filter'];
      currentUser.withHijab = user['withHijab'];
      currentUser.refine = !(user.data().containsKey("refine"))?false:user["refine"];
    });
    return currentUser;
  }

  Future<List> getChosenList(userId) async {
    List<String> chosenList = [userId];
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('chosenList')
        .get()
        .then((docs) {
      for (var doc in docs.docs) {
        if (docs.docs != null) {
          chosenList.add(doc.id);
        }
      }
    });
    return chosenList;
  }
  Future<List> getMatchedList(userId) async {
    List<String> chosenList = [];
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('matchedList')
        .get()
        .then((docs) {
      for (var doc in docs.docs) {
        if (docs.docs != null) {
          chosenList.add(doc.id);
        }
      }
    });
    return chosenList;
  }
  getDifference(GeoPoint userLocation)async{
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double location= Geolocator.distanceBetween(
        userLocation.latitude, userLocation.longitude, position.latitude, position.longitude
    );
    return location.toInt();

  }
  Future<List<User>> getUser({String userId,List<String> usersId,User currentUser}) async {
    List<User> listOfUsers=[];

    List<String> chosenList = await getChosenList(userId);

    currentUser = await getUserInterests(userId);
    var query=_firestore.collection('users')
        .where("gender", isEqualTo: currentUser.interestedIn);
    List s;
    if (chosenList.length>10){
       s=chosenList.sublist(0,10);
      chosenList.removeRange(0, 10);

      query.where("uid",whereNotIn:s);
    }else {
       s=chosenList;
      chosenList=[];
    }
    print(s);
    if ((currentUser.gender=="Female")||(currentUser.gender=="Male")&&((currentUser.withHijab==null)))
    await query
        .where("uid",whereNotIn: s).get().then((users) async{
      for (var user in users.docs) {

        if((!usersId.contains(user.id))&&(!listOfUsers.contains(user.id))){
          if((!chosenList.contains(user.id))){

            int dif=((await getDifference(user['location']))/1000000).toInt();
            if (currentUser.filter.toInt()>=dif) {
              User _user = User();
              _user.uid = user.id;
              _user.name = user['name'];
              _user.photo = user['photourl'];
              _user.age = user['age'];
              _user.location = user['location'];
              _user.love = user['love'];
              _user.line = user['line'];
              _user.gender = user['gender'];
              _user.interestedIn = user['interestedIn'];
              _user.eyesColor = user['eyesColor'];
              if((usersId.length+listOfUsers.length)<sizeOfUsers){
                listOfUsers.add(_user);
              }else
                {
                  return;
                }
            }
          }
        }

    }
        });
    else{

      //if it was woman with hijab
      await query
          .where("uid",whereNotIn: s).where("hijab",isEqualTo: currentUser.withHijab)
          .get().then((users) async{
        for (var user in users.docs) {
          if((!usersId.contains(user.id))){
            if((!chosenList.contains(user.id))){
              int dif=((await getDifference(user['location']))/1000000).toInt();

              if ((currentUser.filter.toInt()>=dif)) {
                User _user = User();

                _user.uid = user.id;
                _user.name = user['name'];
                _user.photo = user['photourl'];
                _user.age = user['age'];
                _user.location = user['location'];
                _user.love = user['love'];
                _user.line = user['line'];
                _user.gender = user['gender'];
                _user.interestedIn = user['interestedIn'];
                _user.eyesColor = user['eyesColor'];
                if((usersId.length+listOfUsers.length)<sizeOfUsers){
                  listOfUsers.add(_user);
                }else
                {
                  return;
                }

              }
            }
          }


        }
      });
    }

    return listOfUsers;
  }

  selectUser({currentUserId,
    selectedUserId,
    currentUserName,
    currentUserPhotoUrl,
    selectUserName,
    selectUserPhotoUrl})async{
    deleteUser(currentUserId: currentUserId,selectedUserId: selectedUserId);
    await _firestore.
    collection("users").
    doc(currentUserId).
    collection("matchedList").
    doc(selectedUserId).set({
      "name":selectUserName,
      "photourl":selectUserPhotoUrl,
    });
    String token;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(selectedUserId)
        .get().then((value) {

      token=value["tokens"];

    });

    await sendMatchNotification(token);
     await _firestore.
    collection("users").
    doc(selectedUserId).
    collection("matchedList").
    doc(currentUserId).set({
      "name":currentUserName,
      "photourl":currentUserPhotoUrl,
    });


  }

  sendMatchNotification(String token)async {
    if (token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':Authorization
        },
        body: constructForMatch(token),
      );
    } catch (e) {
      print(e);
    }
  }
  sendLikedNotification(String token)async {
    if (token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':Authorization
        },
        body: constructForLike(token),
      );
    } catch (e) {
      print(e);
    }
  }
  void deleteUser({currentUserId,selectedUserId})async{
    await _firestore.
    collection("users").
    doc(selectedUserId).
    collection("matchedmatchedList").
    doc(currentUserId).
    delete();
    await _firestore.
    collection("users").
    doc(currentUserId).
    collection("selectedList").
    doc(selectedUserId).
    delete();
  }

  Future<List> getSelectedList(userId)async{
    List<String> selectedList = [];
    await _firestore.
    collection("users").
    doc(userId).
    collection("selectedList")
        .get()
        .then((docs) {
      for (var doc in docs.docs) {
        if (docs.docs != null) {
          selectedList.add(doc.id);
        }
      }
    });
    return selectedList;
  }
}