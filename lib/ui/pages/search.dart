import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/search/search_bloc.dart';
import 'package:zoodja/models/user.dart';
import 'package:zoodja/repositories/searchRepository.dart';
import 'package:zoodja/ui/pages/profileItem.dart';
import 'package:zoodja/ui/widgets/iconWidget.dart';
import 'package:zoodja/ui/widgets/photo.dart';
import 'package:zoodja/ui/widgets/profileWidget.dart';
import 'package:zoodja/ui/widgets/userGender.dart';

class Search extends StatefulWidget {
final String userId;

  const Search({this.userId}) ;


  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchRepository _searchRepository=SearchRepository();
  SearchBloc _searchBloc;
  User _user,_currentUser;
  int difference;
 String animation="";
 double opacity=0;
  List<String> list=[];

  getDifference(GeoPoint userLocation)async{
  Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  double location= Geolocator.distanceBetween(
      userLocation.latitude, userLocation.longitude, position.latitude, position.longitude
  );
  difference=location.toInt();

}
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
  _searchBloc=SearchBloc(searchRepository: _searchRepository);

    super.initState();
  }
  Widget love({photoHeight, photoWidth, clipRadius}){
  return Container(
    width: photoWidth,
    height: photoHeight,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xffFE3C72).withOpacity(0.5),
    ),
    child: Icon(
      FontAwesomeIcons.solidHeart,
      color: Colors.white,
      size: 100,
    ),
  );
  }

  Widget dislove({photoHeight, photoWidth, clipRadius}){
    return Container(
      width: photoWidth,
      height: photoHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(clipRadius),
        color: Color(0xff20A39E).withOpacity(0.5),

      ),

      child: Icon(
        Icons.clear_sharp,
        color: Colors.white,
        size: 100,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return BlocBuilder<SearchBloc,SearchState>(
      bloc: _searchBloc,
      builder: (context, state) {
      if(state is InitialSearchState){
        _searchBloc.add(LoadUserEvent(userId:widget.userId));
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              Colors.blueGrey,
            ),
          ),
        );
      }
      if(state is LoadingState){
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              Colors.blueGrey,
            ),
          ),
        );
      }
      if(state is LoadUserState){
        _user=state.users[0];
        _currentUser=state.currentUser;
        getUsers(state);
        if(_user.location==null){

          return Center(
            child: Text("No one in your area - Expand your area",
            style: GoogleFonts.openSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
              textAlign: TextAlign.center,
            ),
          );
        }else
          getDifference(_user.location);

        return Draggable(
          onDragEnd: (details) {

            if(details.offset.dx>=75){
              animation="love";
              _searchRepository.chooseUser(widget.userId, _user.uid, _currentUser.name, _currentUser.photo);
              Timer(Duration(seconds: 2), () async{
                state.users.removeAt(0);
                getUsers(state);
                setState(() {

                });
              });
            }
            if(details.offset.dx<=(-75)){
              animation="dislove";
              _searchRepository.passUser(widget.userId, _user.uid);

              Timer(Duration(seconds: 2), ()async {
                state.users.removeAt(0);
                getUsers(state);
                setState(() {

                });

              });
            }
            setState(() {
            });
            Timer(Duration(seconds: 1), () {
              animation="";
              setState(() {
              });
            });
          },
          childWhenDragging: Container(),
          feedback: Container(
            margin: EdgeInsets.only(top:10),
            child: Stack(
              children: [
                ProfileWidget(
                    padding: size.height*0.035,
                    photoHeight: size.height*0.7,
                    photoWidth: size.width*0.8,
                    photo: _user.photo,
                    clipRadius: size.height*0.05,
                ),
                animation==""?Container():Container(
                  padding: EdgeInsets.all(size.height*0.035),
                  alignment: Alignment.topCenter,
                  child: animation=="love"
                      ?love( photoHeight: size.height*0.7,photoWidth: size.width*0.9,clipRadius: size.height*0.05,)
                      :dislove(photoHeight: size.height*0.7,photoWidth: size.width*0.9,clipRadius: size.height*0.05,),
                )
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        children: [
                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal:  30,),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                          width: size.width*0.9,
                                          height: size.height-150 ,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: PhotoWidget( photoLink:  _user.photo,),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            decoration: BoxDecoration(
                                              gradient:  LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.black54,
                                                    Colors.black87,
                                                    Colors.black
                                                  ],
                                                  stops: [0.1,0.2,0.4,0.9],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter
                                              ),
                                              color: Colors.black45,
                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                            ),
                                            width: size.width*0.9,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Row(

                                                        children: [
                                                          Container(
                                                            constraints: BoxConstraints(
                                                                maxWidth: size.width*0.7
                                                            ),
                                                            child: Text(" "+_user.name +" , "
                                                                +(DateTime.now().year-_user.age.toDate().year)    .toString(),
                                                              style: GoogleFonts.openSans(color: Colors.white,fontSize: 16),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          GestureDetector(
                                                            onTap: (){
                                                              print("_user.eyesColor");
                                                              print(_user.eyesColor);
                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileItem(user: _user,difference:difference),));
                                                            },
                                                            child: Icon(Icons.info_outline,color: Colors.white,),)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Icon(Icons.location_on,color: Colors.white,),
                                                          Text(difference!=null?(difference/1000000).floor().toString()+
                                                              " km ":"away" +", "+_user.love,
                                                            style: GoogleFonts.openSans(
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,

                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          SizedBox(width: 10,),
                                                          Expanded(
                                                            child: Text(_user.line,
                                                              style: GoogleFonts.openSans(
                                                                color: Colors.white,
                                                              ),
                                                              overflow: TextOverflow.ellipsis,

                                                            ),
                                                          ),

                                                        ],
                                                      )
                                                    ],
                                                  ),

                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),

                                  ],
                                ),
                              ),


                            ),
                          ),

                          animation==""?Container():Container(
                            alignment: Alignment.topCenter,
                            child: animation=="love"
                                ?love( photoHeight: size.height-150,photoWidth: size.width*0.90-25,clipRadius: 20.0,)
                                :dislove(photoHeight: size.height-150,photoWidth: size.width*0.9-25,clipRadius: 20.0,),
                          )
                        ],
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(height:5 ,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: (){
                      animation="dislove";
                      setState(() {});
                      _searchRepository.passUser(widget.userId, _user.uid);

                      Timer(Duration(seconds: 2), () {
                      animation="";
                      state.users.removeAt(0);
                      getUsers(state);
                      setState(() {});
                      });

                      setState(() {});
                      },
                    child:Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff20A39E),
                        ),
                        child: Center(child: Image.asset("assets/Cross.png",width: 20,height: 20,))),
                  ),
                  SizedBox(width: 15,),
                  GestureDetector(

                    child:Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffFFBA49),
                        ),
                        child: Center(child: Image.asset("assets/Star.png",width: 15,height: 15,))),
                  ),
                  SizedBox(width: 15,),
                  GestureDetector(
                    onTap:  ()
                    {
                      animation="love";
                      setState(() {

                      });
                      _searchRepository.chooseUser(widget.userId, _user.uid, _currentUser.name, _currentUser.photo);

                      Timer(Duration(seconds: 2), () {
                        animation="";
                        state.users.removeAt(0);
                        getUsers(state);

                        setState(() {

                        });
                      });

                      setState(() {

                      });

                    },
                      child:Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.red,
                          ),
                          child: Center(child: Image.asset("assets/Heart.png",width: 20,height: 20,))),
                     ),
                ],
              )
            ],
          ),
        );
      }else return Container();
      }
      ,);
  }

  void getUsers( state) {
    list=[];
    for(int index=(state.users.length-1);index<state.users.length ;index++){
      list.add(state.users[index].uid);
    }
    _searchRepository.getUserNotExistInList(userId: widget.userId,userss: list).then((value) {
      for (User user in state.users){
        if(user.uid==value.uid){
          return;
        }
      }
      state.users.add(value);
      for (User user in state.users){
        print(user.uid);
      }
    });
  }
}
