import 'package:flutter/material.dart';
import 'package:zoodja/models/user.dart';


class Messaging extends StatefulWidget {
  final User currentUser;
  final User selectedUser;

  const Messaging({ this.currentUser, this.selectedUser});
  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
