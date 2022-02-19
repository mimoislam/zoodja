import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/bloc/matches/matches_bloc.dart' as ms;
import 'package:zoodja/bloc/message/message_bloc.dart';
import 'package:zoodja/bloc/search/search_bloc.dart';
import 'package:zoodja/models/message.dart';
import 'package:zoodja/repositories/matchesRepository.dart';
import 'package:zoodja/repositories/messageRepository.dart';
import 'package:zoodja/repositories/searchRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/pages/matches.dart';
import 'package:zoodja/ui/pages/messages.dart';
import 'package:zoodja/ui/pages/profileMenu.dart';
import 'package:zoodja/ui/pages/search.dart';


class Tabs extends StatefulWidget {
  final userId;

   Tabs({this.userId});

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  MessageRepository messageRepository=MessageRepository();
  MessageBloc _messageBloc;
  ms.MatchesBloc _matchesBloc;

  int index=0;
  MatchesRepository  matchesRepository=MatchesRepository();
  SearchRepository  searchRepository=SearchRepository();
  SearchBloc _searchBloc;
  @override
  void initState() {
    pageController=PageController(initialPage: 0);
    _messageBloc=MessageBloc(messageRepository: messageRepository);
    _matchesBloc=ms.MatchesBloc(matchesRepository: matchesRepository);
    _searchBloc=SearchBloc(searchRepository: searchRepository);
    super.initState();
  }

  PageController pageController;


  bool existMatch=false;
  bool existSelected=false;
  bool existMessage=false;


  bool eventMessage=false;
  bool eventSelected=false;
  bool eventMatch=false;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double topPadding=MediaQuery.of(context).padding.top;
    List<Widget> pages=[
      Search(userId: widget.userId),
      Matches(userId: widget.userId, matchesRepository: matchesRepository,),
      Messages(userId: widget.userId,messageRepository: messageRepository,),
      ProfileMenu(userId:widget.userId,messageRepository: messageRepository,)
    ];
    return Theme(data: ThemeData(
        primaryColor:backgroundColor,
        accentColor: Colors.white
    ), child:
      Scaffold(
          resizeToAvoidBottomInset: false,

          body: MultiBlocProvider(providers: [
            BlocProvider<SearchBloc>(
              create: (BuildContext context) => SearchBloc(searchRepository: searchRepository),
            ),
            BlocProvider<MessageBloc>(
              create: (BuildContext context) => MessageBloc(messageRepository: messageRepository),
            ),
            BlocProvider<ms.MatchesBloc>(
              create: (BuildContext context) => ms.MatchesBloc(matchesRepository: matchesRepository),
            ),
          ]
              ,child:Container(
            padding: EdgeInsets.only(top:topPadding ),

            width: size.width,
            height: size.height,
            child: Stack(
              children: [
               PageView(
                 physics: NeverScrollableScrollPhysics(),
                 allowImplicitScrolling: false,
                    controller:pageController ,
                    onPageChanged: (value) {
                      index=value;
                      setState(() {});
                    },
                    children: pages,
                  ),
                Positioned(
                  bottom: 5,
                  right: 10,
                  left: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 66,
                      decoration: BoxDecoration(
                        color: Color(0xff18516E),
                        borderRadius: BorderRadius.circular(size.height*0.03)
                      ),
                      child:Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              child: GestureDetector(
                                onTap: (){
                                  if(index!=0){
                                    index=0;
                                    setState(() {
                                    });
                                    pageController.jumpToPage(0);
                                  }
                                },
                                child: Column(
                                  children: [
                                    Image.asset("assets/home.png",height: 30,),
                                    SizedBox(height:4,),

                                    index==0?Container(width: 25, height:2,decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),):Container()

                                  ],
                                ),
                              ),
                            ),
                          BlocBuilder<ms.MatchesBloc,ms.MatchesState>(
                          bloc: _matchesBloc,
                          builder: (context, state) {
                            if (state is ms.LoadingState){
                            _matchesBloc.add(ms.LoadListsEvent(userId: widget.userId));
                          }
                          if(state is ms.LoadUserState){
                            state.matchedList.listen((event) {

                              existMatch=event.docs.length!=0;
                              eventMatch=event.docs.length!=0;
                              setState(() {

                              });
                                  Timer(Duration(seconds: 3), () {
                                    eventMatch=false;
                                    setState(() {

                                    });
                                  });

                            });
                            state.selectedList.listen((event) {

                              existSelected=event.docs.length!=0;
                              eventSelected=event.docs.length!=0;
                              setState(() {

                              });
                                Timer(Duration(seconds: 3), () {
                                  this.eventSelected=false;
                                  setState(() {

                                  });
                                });

                            });
                            return Stack(
                              children: [

                                Container(
                                  width: 40,
                                  height: 40,
                                  child: GestureDetector(
                                  onTap: (){
                                    if(index!=1){
                                      index=1;
                                      setState(() {
                                      });
                                      pageController.jumpToPage(1);
                                    }
                                    },
                                    child: Stack(
                                      clipBehavior: Clip.none,

                                      children: [
                                        Column(
                                          children: [

                                            Image.asset("assets/logo.png",height: 30,),
                                            SizedBox(height: 4,),
                                            index==1?Container(width: 25, height:2,decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10)
                                            ),):Container()
                                          ],
                                        ),
                                        (existSelected||existMatch)?Positioned(
                                          top: -5,
                                          right: -5,
                                          child: Container(
                                            width: 10,height: 10,
                                            decoration: BoxDecoration(
                                                color:Colors.red,
                                                borderRadius: BorderRadius.circular(15)
                                            ),
                                          ),
                                        ):Container()
                                      ],
                                    ),
                                  ),
                                )

                              ],
                            );
                          }
                          return   Container(
                            width: 40,
                            height: 40,
                            child: GestureDetector(
                              onTap: (){
                                if(index!=1){
                                  index=1;
                                  pageController.jumpToPage(1);

                                  setState(() {
                                  });
                                }
                              },
                              child: Column(
                                children: [

                                  Image.asset("assets/logo.png",height: 30,),
                                  SizedBox(height: 4,),
                                  index==1?Container(width: 25, height:2,decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),):Container()
                                ],
                              ),
                            ),
                          );
                            // return Container();
                          },),
                            BlocBuilder<MessageBloc,
                                MessageState>(
                              bloc: _messageBloc,
                              builder: (context, state) {
                              if(state is MessageInitialState){
                              _messageBloc
                                  .add(ChatStreamEvent(currentUserId: widget.userId));
                              return CircularProgressIndicator();
                              }
                              if(state is ChatLoadingState){
                              return Center(
                              child: CircularProgressIndicator(),
                              );
                              }
                              if(state is ChatLoadedState){
                                state.chatStream.listen((event) async{

                                  for(var uid in event.docChanges){
                                    print("uid.doc.id");
                                    print(uid.doc.id);
                                    Message message=await messageRepository.
                                    getLastMessage(currentUserId: widget.userId,selectedUserId: uid.doc.id);
                                    if(message.viewed==false){
                                      existMessage=true;
                                      eventMessage=true;
                                      setState(() {

                                      });
                                      Timer(Duration(seconds: 3), () {
                                        this.eventMessage=false;
                                        setState(() {

                                        });
                                      });
                                    }
                                  }
                                });

                              }
                              return Container(
                                width: 40,
                                height: 40,
                                child: GestureDetector(
                                  onTap: (){
                                    if(index!=2){
                                      index=2;

                                      setState(() {

                                      });
                                      pageController.jumpToPage(2);

                                    }
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,

                                    children: [
                                      Column(
                                        children: [
                                          Image.asset("assets/conversation.png",height: 30,),
                                          SizedBox(height:4,),                                               index==2?Container(width: 25, height:2,decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10)
                                          ),):Container()

                                        ],
                                      ),
                                      (existMessage)?Positioned(
                                        top: -5,
                                        right: -5,
                                        child: Container(
                                          width: 10,height: 10,
                                          decoration: BoxDecoration(
                                              color:Colors.red,
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                        ),
                                      ):Container()
                                    ],
                                  ),
                                ),
                              );
                                // return Container();
                              },),

                            Container(
                              width: 40,
                              height: 40,
                              child: GestureDetector(
                                onTap: (){
                                  if(index!=3){
                                    index=3;
                                    setState(() {});
                                    pageController.jumpToPage(3);
                                  }
                                },
                                child: Column(
                                  children: [
                                    Image.asset("assets/user.png",height: 30,),
                                    SizedBox(height:4,),                                       index==3?Container(width: 25, height:2,decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),):Container()
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ) ,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  right: eventMatch?0:size.width,
                  duration: Duration(milliseconds: 300),
                  child:GestureDetector(
                    onTap: (){
                      pageController.jumpToPage(1);
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      width: size.width*0.9,
                      decoration: BoxDecoration(
                        color: Color(0xffE6DEEF),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text("You Have Match You Didn't Respond To ",style: GoogleFonts.openSans(fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xff18516E),),textAlign: TextAlign.center,))
                        ],
                      ),
                    ),
                  )

                ),
                AnimatedPositioned(
                    right: eventSelected?0:size.width,
                    duration: Duration(milliseconds: 300),
                    child:GestureDetector(
                      onTap: (){
                        pageController.jumpToPage(1);
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: 5),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        width: size.width*0.9,
                        decoration: BoxDecoration(
                            color: Color(0xffE6DEEF),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Text("Someone Liked",style: GoogleFonts.openSans(fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xff18516E),),textAlign: TextAlign.center,))
                          ],
                        ),
                      ),
                    )

                ),
                AnimatedPositioned(
                    right: eventMessage?0:size.width,
                    duration: Duration(milliseconds: 300),
                    child: GestureDetector(
                      onTap: (){
                        pageController.jumpToPage(1);
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: 5),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        width: size.width*0.9,
                        decoration: BoxDecoration(
                            color: Color(0xffE6DEEF),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Text("Someone Send You Message",style: GoogleFonts.openSans(fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xff18516E),),textAlign: TextAlign.center,))
                          ],
                        ),
                      ),
                    )
                ),
              ],
            ),
          )
      ),
    )
    );
  }
}



