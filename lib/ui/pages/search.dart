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

        return profileWidget(
          padding: size.height*0.035,
            photoHeight: size.height*0.824,
            photo: _user.photo,
            clipRadius: size.height*0.02,
            containerHeight: size.height*0.3,
            containerWidth: size.width*0.9,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.height*0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height*0.07,),
                  Row(
                    children: [
                      userGender(_user.gender),Expanded(child: Text(" "+_user.name +", "
                      +(DateTime.now().year-_user.age.toDate().year)    .toString(),
                      style: GoogleFonts.openSans(color: Colors.white,fontSize: size.height*0.05),
                      ))
                    ],
                  ),
                  Row(
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          iconWidget(EvaIcons.flash, (){}, size.height*0.04, Colors.yellow),
                          iconWidget(Icons.clear,(){
                            _searchBloc.add(PassUserEvent(currentUserId: widget.userId,selectedUserId: _user.uid));
                          },size.height*0.04,Colors.blue),
                          iconWidget(FontAwesomeIcons.solidHeart, ()
                          {
                            _searchBloc.add(SelectUserEvent(name: _currentUser.name,selectedUserId: _user.uid,currentUserId: widget.userId,photoUrl: _currentUser.photo));
                          }, size.height*0.04, Colors.red),
                          iconWidget(EvaIcons.options2, (){}, size.height*0.04, Colors.white)
                        ],
                      )
                    ],
                  )
                ],
              ),

            )
          );
      }else return Container();
      }
      ,);
  }
}
