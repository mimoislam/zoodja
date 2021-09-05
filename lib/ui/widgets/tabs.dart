import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/pages/matches.dart';
import 'package:zoodja/ui/pages/messages.dart';
import 'package:zoodja/ui/pages/search.dart';

class Tabs extends StatelessWidget {
  final userId;

  const Tabs({this.userId});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages=[
      Search(        userId: userId,
      ),
      Matches(),
      Messages()
    ];
    return Theme(data: ThemeData(
      primaryColor:backgroundColor,
      accentColor: Colors.white
    ), child: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Chill',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
          actions: <Widget>[
            IconButton(onPressed: (){
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            }, icon: Icon(Icons.exit_to_app))
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: Container(
              height: 48,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabBar(tabs: <Widget>[
                    Tab(icon: Icon(Icons.search),),
                    Tab(icon: Icon(Icons.people),),
                    Tab(icon: Icon(Icons.message),),

                  ])
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: pages,
        ),
      ),
    ));
  }
}
