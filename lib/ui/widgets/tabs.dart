import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/bloc/matches/matches_bloc.dart';
import 'package:zoodja/bloc/message/message_bloc.dart';
import 'package:zoodja/repositories/matchesRepository.dart';
import 'package:zoodja/repositories/messageRepository.dart';
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
  MatchesBloc _matchesBloc;
  int lengthMatches=0;
  int lengthMessages=0;
  int lengthSelected=0;
  int index=0;
  MatchesRepository  matchesRepository=MatchesRepository();

  @override
  void initState() {
    pageController=PageController(initialPage: 0);
    _messageBloc=MessageBloc(messageRepository: messageRepository);
     _matchesBloc=MatchesBloc(matchesRepository: matchesRepository);

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
    List<Widget> pages=[
      Search(userId: widget.userId,),
      Matches(userId: widget.userId,matchesBloc: _matchesBloc, matchesRepository: matchesRepository,),
      Messages(userId: widget.userId,messageBloc: _messageBloc,messageRepository: messageRepository,),
      ProfileMenu(userId:widget.userId,messageRepository: messageRepository,)
    ];
    return Theme(data: ThemeData(
        primaryColor:backgroundColor,
        accentColor: Colors.white
    ), child:
      Scaffold(
          resizeToAvoidBottomInset: false,

          body: SafeArea(
            child: Container(
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
                    right: size.width*0.05,
                    left: size.width*0.05,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff18516E),
                          borderRadius: BorderRadius.circular(size.height*0.03)
                        ),
                        child:Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      Icon(Icons.home_outlined,color: Colors.white,size: 30,),
                                      index==0?Container(width: 20, height:3,color: Colors.white,):Container()

                                    ],
                                  ),
                                ),
                              ),
                            BlocBuilder<MatchesBloc,MatchesState>(
                            bloc: _matchesBloc,
                            builder: (context, state) {
                              if (state is LoadingState){
                              _matchesBloc.add(LoadListsEvent(userId: widget.userId));
                            }
                            if(state is LoadUserState){
                              state.matchedList.listen((event) {
                                final user=event.docs;
                                if(lengthMatches<user.length)
                                  {
                                    this.eventMatch=true;
                                    Timer(Duration(seconds: 2), () {
                                      this.eventMatch=false;
                                      setState(() {

                                      });
                                    });
                                  }
                                else{
                                    print("notEvent");
                                }
                                if(0<user.length){
                                  setState(() {
                                    existMatch=true;
                                  });

                                }else{
                                  existMatch=false;
                                  setState(() {
                                  });
                                }
                              });
                              state.selectedList.listen((event) {
                                final user=event.docs;
                                if(lengthSelected<user.length)
                                {
                                  this.eventSelected=true;
                                  print("event");
                                  Timer(Duration(seconds: 2), () {
                                    this.eventSelected=false;
                                    setState(() {

                                    });
                                  });
                                }else{
                                  print("notEvent");
                                }
                                if(0<user.length){
                                  setState(() {
                                    existSelected=true;
                                  });

                                }else{
                                  existSelected=false;
                                  setState(() {
                                  });
                                }
                              });
                              return Stack(
                                children: [
                                  Container(
                                    width: 0,
                                    height: 0,
                                    child: Column(
                                      children: [
                                        StreamBuilder<QuerySnapshot>(
                                          stream: state.matchedList,
                                          builder: (context, snapshot) {
                                            if((snapshot.hasData)&&(snapshot.data.size!=0)){
                                              lengthMatches=snapshot.data.size;
                                              existMatch=true;
                                              return Container();
                                            }
                                            existMatch=false;
                                            return Container();
                                          }
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                            stream: state.selectedList,
                                            builder: (context, snapshot) {

                                              if((snapshot.hasData)&&(snapshot.data.size!=0)){
                                                lengthSelected=snapshot.data.size;
                                                existSelected=true;
                                                return Container();
                                              }
                                              existSelected=false;
                                              return Container();
                                            }
                                        )

                                      ],
                                    ),
                                  ),
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
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 5.0),
                                                child: Image.asset("assets/logo.png"),
                                              ),
                                              index==1?Container(width: 20, height:3,color: Colors.white,):Container()
                                            ],
                                          ),
                                          (existSelected||existMatch)?Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              width: 7,height: 7,
                                              decoration: BoxDecoration(
                                                  color:Colors.red,
                                                  borderRadius: BorderRadius.circular(5)
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
                                    Icon(Icons.people,color: Colors.white,size: 30,),
                                    index==1?Container(width: 20, height:3,color: Colors.white,):Container()

                                  ],
                                ),
                              ),
                            );
                              // return Container();
                            },),
                              BlocBuilder<MessageBloc,MessageState>(
                                bloc: _messageBloc,
                                builder: (context, state) {
                                  if(state is MessageInitialState){
                                    _messageBloc
                                        .add(ChatStreamEvent(currentUserId: widget.userId));
                                    // return CircularProgressIndicator();
                                  }
                                  if(state is ChatLoadingState){
                                    return Container();
                                  }
                                  if(state is ChatLoadedState){
                                    state.chatStream.listen((event) {
                                      final user=event.docs;
                                      if(lengthMessages<user.length)
                                      {
                                        this.eventMessage=true;

                                        Timer(Duration(seconds: 2), () {
                                          this.eventMessage=false;
                                          setState(() {

                                          });
                                        });
                                      }
                                      else{
                                        print("notEvent");
                                      }
                                      if(0<user.length){
                                        setState(() {
                                          existMessage=true;
                                        });
                                      }else{
                                        existMessage=false;
                                        setState(() {
                                        });
                                      }
                                    });

                                    Stream <QuerySnapshot> chatStream=state.chatStream;
                                    return Stack(
                                      children: [
                                        Container(
                                          width: 0,
                                          height: 0,
                                          child: StreamBuilder(
                                            stream: chatStream,
                                            builder: (context, snapshot) {
                                              if(!snapshot.hasData){
                                                lengthMessages=snapshot.data.size;
                                                return Container();
                                              }
                                              if((snapshot.data.docs.isNotEmpty)){
                                                  return Container();
                                              }else{
                                                return Container();
                                              }

                                            } ,
                                          ),
                                        ),
                                        Container(
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
                                            child: Column(
                                              children: [
                                                Icon(Icons.message_outlined,color: Colors.white,size: 30,),
                                                index==2?Container(width: 20, height:3,color: Colors.white,):Container()

                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
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
                                      child: Column(
                                        children: [
                                          Icon(Icons.message_outlined,color: Colors.white,size: 30,),
                                          index==2?Container(width: 20, height:3,color: Colors.white,):Container()

                                        ],
                                      ),
                                    ),
                                  )
                                  ;
                                },
                              ),
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
                                      Icon(Icons.person_outline_outlined,color: Colors.white,size: 30,),
                                      index==3?Container(width: 20, height:3,color: Colors.white,):Container()
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
            ),
          )
      ),
    );
  }
}



