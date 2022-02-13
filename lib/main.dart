import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/bloc/blocDelegate.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/pages/home.dart';
 AndroidNotificationChannel channel;
 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // when u are outside  the app add notification for it

  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print('Handling a background message ${message.notification.title}');
  print('Handling a background message ${message.notification.title}');
}
void main() async{

      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      // Set the background messaging handler early on, as a named top-level function

      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // when u are inside the app add notification for it
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification.title}');
        }
      });      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      print('Handling a background message ${await FirebaseMessaging.instance.getToken()}');
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );




      final UserRepository userRepository=UserRepository();
      AuthenticationBloc _authenticationBloc=AuthenticationBloc(userRepository: userRepository);
      Timer(Duration(seconds: 4), () {
        _authenticationBloc.add(AppStarted());
      });
      Bloc.observer = SimpleBlocDelegate();
      runApp(
          BlocProvider(create: (context) {

            return _authenticationBloc ;
          }  ,
          child: Home(userRepository:userRepository),
          ));
}

