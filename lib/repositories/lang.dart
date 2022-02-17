import 'package:flutter/cupertino.dart';

class Lang extends ChangeNotifier{
  Locale locale=Locale('fr');
  Future<Locale> load(Locale locale)async{
     this.locale=locale;
     notifyListeners();
  }


}