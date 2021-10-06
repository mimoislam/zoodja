import 'dart:convert';

import 'package:flutter/material.dart';

const backgroundColor=Colors.blueGrey;
const text_color=Color(0xff18516E);
const text_color2=Color(0xff8969AE);

String constructForMessage(String token) {
  return jsonEncode({
    "to" : token,
    "notification" : {
      "body" : "You Have  received Message",
      "title": "Title of Your Notification"
    }
  });
}
String constructForMatch(String token) {
  return jsonEncode({
    "to" : token,
    "notification" : {
      "body" : "Go Check it ",
      "title": "You Have  Match",
    }
  });
}
String constructForLike(String token) {
  return jsonEncode({
    "to" : token,
    "notification" : {
      "body" : "Go Check it ",
      "title":"Someone Liked you",
    }
  });
}