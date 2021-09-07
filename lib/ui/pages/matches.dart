import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/matches/matches_bloc.dart';
import 'package:zoodja/models/user.dart';
import 'package:zoodja/repositories/matchesRepository.dart';
class Matches extends StatefulWidget {
  final String userId;

  const Matches({this.userId}) ;

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  MatchesRepository  matchesRepository=MatchesRepository();
  MatchesBloc _matchesBloc;

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
    _matchesBloc=MatchesBloc(matchesRepository: matchesRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return BlocBuilder<MatchesBloc,MatchesState>(
      bloc: _matchesBloc,
      builder: (context, state) {
        if (state is LoadingState){
          _matchesBloc.add(LoadListsEvent(userId: widget.userId));
          return CircularProgressIndicator();
        }
        if(state is LoadUserState){
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.white,
                title: Text(
                  "Matched Users",
                  style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 30.0
                  ),

                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: state.matchedList,
                builder: (context, snapshot) {
                  if(!snapshot.hasData)
                    return SliverToBoxAdapter(
                      child: Container(),
                    );
                  if(snapshot.data.docs!=null){
                    final user=snapshot.data.docs;
                    return SliverGrid(delegate: SliverChildBuilderDelegate(
                      (BuildContext context,int index)
                    {return GestureDetector(
                    onTap:()async{
                      User selectUser=await matchesRepository.getUserDetails(user[index].id);
                      User currentUser=await matchesRepository.getUserDetails(widget.userId);
                      await getDifference(selectUser.location);
                      showDialog(context: context, builder: (context) {
                      },);
                    });
                    }), gridDelegate: null,);
                  }
              },)
            ],
          );
        }


        return Container();
    },);
  }
}
