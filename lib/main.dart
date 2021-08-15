import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoodja/bloc/blocDelegate.dart';
import 'package:zoodja/ui/pages/home.dart';
void main() {
      WidgetsFlutterBinding.ensureInitialized();
      Bloc.observer = SimpleBlocDelegate();
      runApp(Home());
}

