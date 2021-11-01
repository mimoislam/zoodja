import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zoodja/models/user.dart';

class SearchRepository {
  final FirebaseFirestore _firestore;

  SearchRepository({FirebaseFirestore firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<User> chooseUser(currentUserId, selectedUserId, name, photoUrl) async {
    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('chosenList')
        .doc(selectedUserId)
        .set({});

    await _firestore
        .collection('users')
        .doc(selectedUserId)
        .collection('chosenList')
        .doc(currentUserId)
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
    return getUser(currentUserId);
  }

  passUser(currentUserId, selectedUserId) async {
    await _firestore
        .collection('users')
        .doc(selectedUserId)
        .collection('chosenList')
        .doc(currentUserId)
        .set({});

    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('chosenList')
        .doc(selectedUserId)
        .set({});
    return getUser(currentUserId);
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
    });
    return currentUser;
  }

  Future<List> getChosenList(userId) async {
    List<String> chosenList = [];
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
  Future<User> getUser(userId) async {
    User _user = User();
    List<String> chosenList = await getChosenList(userId);
    List<String> matchedList = await getMatchedList(userId);
    User currentUser = await getUserInterests(userId);
    await _firestore.collection('users').get().then((users) async{
      for (var user in users.docs) {

        int dif=((await getDifference(user['location']))/1000000).toInt();
        print("user.id ");
        print(user.id);
        print((user.id != userId));
        print((!chosenList.contains(user.id)));
        print((!matchedList.contains(user.id)));
        print((currentUser.interestedIn == user['gender']));

        if(( currentUser.gender=="Female")||(currentUser.withHijab=="")||(currentUser.withHijab==null)){
        if ((!chosenList.contains(user.id)) &&
            (!matchedList.contains(user.id)) &&
            (user.id != userId) &&
            (currentUser.interestedIn == user['gender']) &&
            (user['interestedIn'] == currentUser.gender)
            &&(currentUser.filter.toInt()>=dif)) {
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
          break;
        }
      }else{
         if ((!chosenList.contains(user.id)) &&
             (!matchedList.contains(user.id)) &&
             (user.id != userId) &&(currentUser.withHijab==user['hijab']) &&
             (currentUser.interestedIn == user['gender']) &&
             (user['interestedIn'] == currentUser.gender)&&(currentUser.filter.toInt()>=dif)) {
           _user.uid = user.id;
           _user.name = user['name'];
           _user.photo = user['photourl'];
           _user.age = user['age'];
           _user.location = user['location'];
           _user.gender = user['gender'];
           _user.interestedIn = user['interestedIn'];
           _user.eyesColor = user['eyesColor'];

           break;
       }
      }
      }
    });
    return _user;
  }
  Future<User> getUserNotExistInList({userId, List<String> userss}) async {

    User _user = User();
    List<String> chosenList = await getChosenList(userId);
    List<String> matchedList = await getMatchedList(userId);
    User currentUser = await getUserInterests(userId);
    await _firestore.collection('users').get().then((users) async{
      for (var user in users.docs) {
        if(!userss.contains(user.id)){
        int dif=((await getDifference(user['location']))/1000000).toInt();
        if(( currentUser.gender=="Female")||(currentUser.withHijab=="")||(currentUser.withHijab==null)){
          if ((!chosenList.contains(user.id)) &&
              (!matchedList.contains(user.id)) &&
              (user.id != userId) &&
              (currentUser.interestedIn == user['gender']) &&
              (user['interestedIn'] == currentUser.gender)
              &&(currentUser.filter.toInt()>=dif)) {
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
            break;
          }
        }else{
          if ((!chosenList.contains(user.id)) &&
              (!matchedList.contains(user.id)) &&
              (user.id != userId) &&(currentUser.withHijab==user['hijab']) &&
              (currentUser.interestedIn == user['gender']) &&
              (user['interestedIn'] == currentUser.gender)&&(currentUser.filter.toInt()>=dif)) {
            _user.uid = user.id;
            _user.name = user['name'];
            _user.photo = user['photourl'];
            _user.age = user['age'];
            _user.location = user['location'];
            _user.gender = user['gender'];
            _user.interestedIn = user['interestedIn'];
            _user.eyesColor = user['eyesColor'];

            break;
          }
        }
      }
      }
    });
    return _user;
  }
}