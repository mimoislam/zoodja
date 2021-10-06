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
import 'package:zoodja/ui/widgets/iconWidget.dart';
import 'package:zoodja/ui/widgets/profile.dart';
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
getDifference(GeoPoint userLocation)async{
  Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  double location= Geolocator.distanceBetween(
      userLocation.latitude, userLocation.longitude, position.latitude, position.longitude
  );
  difference=location.toInt();

}

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
      borderRadius: BorderRadius.circular(clipRadius),
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
        _user=state.user;
        _currentUser=state.currentUser;
        if(_user.location==null){

          return Center(
            child: Text("No One HERE",
            style: GoogleFonts.openSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
            ),
          );
        }else
          getDifference(_user.location);

        return Container(
          margin: EdgeInsets.only(top: size.height*0.03),
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              profileWidget(
                padding: size.height*0.035,
                  photoHeight: size.height*0.7,
                  photoWidth: size.width*0.7,
                  photo: _user.photo,
                  clipRadius: size.height*0.05,

                  child:
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.height*0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(

                              children: [
                               Expanded(child: Text(" "+_user.name +", "
                                +(DateTime.now().year-_user.age.toDate().year)    .toString(),
                                style: GoogleFonts.openSans(color: Colors.white,fontSize: size.height*0.05),
                                 textAlign: TextAlign.center,
                                ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on,color: Colors.white,),
                                Text(difference!=null?(difference/1000).floor().toString()+
                                    "km away":"away",
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                ),

                                ),
                                SizedBox(
                                  height: size.height*0.05,
                                ),


                              ],
                            )
                          ],
                        ),

                      ),


                child2: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    iconWidget(Icons.clear_sharp,(){
                      animation="dislove";
                      setState(() {

                      });
                      Timer(Duration(seconds: 1), () {
                         _searchBloc.add(PassUserEvent(currentUserId: widget.userId,selectedUserId: _user.uid));
                      });
                      animation="";
                      setState(() {

                      });
                    },size.height*0.05,Color(0xff20A39E)),
                    iconWidget(EvaIcons.star, (){}, size.height*0.03, Color(0xffFFBA49)),

                    iconWidget(FontAwesomeIcons.solidHeart, ()
                    {
                      animation="love";
                      setState(() {

                      });
                      Timer(Duration(seconds: 1), () {
                        _searchBloc.add(SelectUserEvent(name: _currentUser.name,selectedUserId: _user.uid,currentUserId: widget.userId,photoUrl: _currentUser.photo));
                      });
                      animation="";
                      setState(() {

                      });

                    }, size.height*0.05, Colors.red),
                  ],
                )
                ),
              animation==""?Container():Container(
                padding: EdgeInsets.all(size.height*0.035),
                alignment: Alignment.topCenter,
                child: animation=="love"
                    ?love( photoHeight: size.height*0.7,photoWidth: size.width*0.7,clipRadius: size.height*0.05,)
                    :dislove(photoHeight: size.height*0.7,photoWidth: size.width*0.7,clipRadius: size.height*0.05,),
              )
            ],
          ),
        );
      }else return Container();
      }
      ,);
  }
}
