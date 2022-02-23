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

  print('Handling a background message ${message.messageId}');
  print('Handling a background message ${message.notification.title}');
  print('Handling a background message ${message.notification.body}');



}
void main() async{

      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final ios=IOSInitializationSettings();
      final android=AndroidInitializationSettings('@mipmap/ic_launcher');
      final settingss=InitializationSettings(
        android: android,
        iOS: ios
      );

      FlutterLocalNotificationsPlugin notificaiton=FlutterLocalNotificationsPlugin();
      notificaiton.initialize(settingss,onSelectNotification: (payload)async{
        print(payload);
      });

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
        print('Message data: ${message.notification.title}');
        if(message.notification.title==titleForMatch)
        notificaiton.show(0, message.notification.title, message.notification.body, NotificationDetails(
            android: AndroidNotificationDetails(
              "Channel ID",
              "Channel name",
              "Channel description",
            ),
            iOS: IOSNotificationDetails(
            )
        ),payload: "ssss");
        if(message.notification.title==titleForMessage)
          notificaiton.show(1, message.notification.title, message.notification.body, NotificationDetails(
              android: AndroidNotificationDetails(
                "Channel ID",
                "Channel name",
                "Channel description",
              ),
              iOS: IOSNotificationDetails(
              )
          ),payload: "ssss");
        if(message.notification.title==titleForLike)
          notificaiton.show(2, message.notification.title, message.notification.body, NotificationDetails(
              android: AndroidNotificationDetails(
                "Channel ID",
                "Channel name",
                "Channel description",
              ),
              iOS: IOSNotificationDetails(
              )
          ),payload: "ssss");

        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification.title}');
        }
      });

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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

