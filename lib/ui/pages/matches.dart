import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/matches/matches_bloc.dart';
import 'package:zoodja/models/user.dart';
import 'package:zoodja/repositories/matchesRepository.dart';
import 'package:zoodja/ui/pages/messaging.dart';
import 'package:zoodja/ui/widgets/iconWidget.dart';
import 'package:zoodja/ui/widgets/pageTurn.dart';
import 'package:zoodja/ui/widgets/profile.dart';
import 'package:zoodja/ui/widgets/userGender.dart';
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
                  if((snapshot.data.docs!=null)&&(snapshot.data.docs.length!=0)){
                    final user=snapshot.data.docs;
                    return SliverGrid(delegate: SliverChildBuilderDelegate(
                      (BuildContext context,int index)
                    {return GestureDetector(
                    onTap:()async{
                      User selectUser=await matchesRepository.getUserDetails(user[index].id);
                      User currentUser=await matchesRepository.getUserDetails(widget.userId);
                      await getDifference(selectUser.location);
                      showDialog(context: context, builder: (context) =>
                        Dialog(
                          backgroundColor: Colors.transparent,
                          child: profileWidget(
                            photo: selectUser.photo,
                            photoHeight: size.height,
                            padding: size.height*0.01,
                            photoWidth: size.width,
                            clipRadius: size.height*0.01,
                            containerWidth:size.width,
                            containerHeight: size.height*0.2,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.height*0.02),
                              child: ListView(
                                children: [
                                  SizedBox(
                                    height: size.height*0.02,
                                  ),
                                  Row(children: [
                                      userGender(selectUser.gender),
                                    Expanded(child: Text(" "+selectUser.name+", "+
                                        (DateTime.now().year-selectUser.age.toDate().year).toString(),
                                    style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: size.height*0.05,
                                    ),
                                    ))
                                  ],),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,color: Colors.white,),
                                      Text(difference!=null?(difference/1000).floor().toString()+
                                          "km away":"away",
                                        style: GoogleFonts.openSans(
                                          color: Colors.white,
                                        ),),
                                      SizedBox(
                                        height: size.height*0.01,
                                      ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(size.height*0.02),
                                                child: iconWidget(Icons.message , (){
                                                  _matchesBloc.add(OpenChatEvent(currentUser: widget.userId,selectedUser: selectUser.uid));
                                                  pageTurn(Messaging(currentUser: currentUser,selectedUser: selectUser), context);
                                                }, size.height*0.04, Colors.white),

                                              )
                                            ],
                                          )
                                        ],
                                  )
                                ],
                              ),
                            )
                          ),
                        ),);
                    },
                    child:
                    profileWidget(
                      padding: size.height*0.01,
                      photo: user[index]['photourl'],
                      photoWidth: size.width*0.5,
                      photoHeight: size.height*0.3,
                      clipRadius: size.height*0.01,
                      containerHeight: size.height*0.03 ,
                      containerWidth: size.width*0.5,
                      child: Text(" "+user[index]['name'],style: GoogleFonts.openSans(color: Colors.white),)
                    ),
                    );

                    },
                    childCount: user.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                    ),);
                  }
                  else{
                    return SliverToBoxAdapter(
                      child: Container()
                    );
                  }
              },
              ),
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                title:  Text(
                  "People who liked you",
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 30.0
                  ),

                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: state.selectedList,
                builder: (context, snapshot) {
                  if(!snapshot.hasData)
                  return SliverToBoxAdapter(
                  child: Container(),
                  );
                  if((snapshot.data.docs!=null)&&(snapshot.data.docs.length!=0)){
                    final user =snapshot.data.docs;
                    print(snapshot.data.docs.length==0);
                    return SliverGrid(delegate: SliverChildBuilderDelegate(
                        (BuildContext context,int index){
                          return GestureDetector(
                            onTap: ()async{
                              User selectUser=await matchesRepository.getUserDetails(user[index].id);
                              User currentUser=await matchesRepository.getUserDetails(widget.userId);
                              await getDifference(selectUser.location);
                              showDialog(context: context, builder: (context) => Dialog(
                                child: profileWidget(
                                  padding: size.height*0.01,
                                  photo: selectUser.photo,
                                  photoHeight: size.height,
                                  photoWidth: size.width,
                                  clipRadius: size.height*0.01,
                                  containerWidth: size.width,
                                  containerHeight: size.height*0.25,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: size.height*0.02),
                                    child: Column(
                                      children: [
                                        Expanded(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: size.height*0.01,),
                                            Row(
                                              children: [
                                                userGender(selectUser.gender),
                                                Expanded(child: Text(" "+selectUser.name+", "+
                                                    (DateTime.now().year-selectUser.age.toDate().year).toString(),
                                                  style: GoogleFonts.openSans(color: Colors.white,fontSize: size.height*0.05),)),

                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.location_on,color: Colors.white,),
                                                Text(difference!=null?(difference/1000).floor().toString()+
                                                    "km away":"away",
                                                  style: GoogleFonts.openSans(
                                                    color: Colors.white,
                                                  ),),

                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height*0.01,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(size.height*0.02),
                                                  child: iconWidget(Icons.clear , (){
                                                    _matchesBloc.add(DeleteUserEvent(currentUser: widget.userId,selectedUser: selectUser.uid));
                                                    pageTurn(Messaging(currentUser: currentUser,selectedUser: selectUser), context);
                                                  }, size.height*0.08, Colors.blue),

                                                ),
                                                SizedBox(
                                                  width: size.width*0.05,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(size.height*0.02),
                                                  child: iconWidget(FontAwesomeIcons.solidHeart , (){
                                                    _matchesBloc.add(AcceptUserEvent(currentUser: widget.userId,selectedUser: selectUser.uid,
                                                        currentUserName: currentUser.name,currentUserPhotoUrl: currentUser.photo,
                                                        selectedUserName: selectUser.name,selectedUserPhotoUrl: selectUser.photo));

                                                  }, size.height*0.08, Colors.red),

                                                )
                                              ],
                                            )

                                          ],
                                        ))
                                      ],
                                    ),
                                  )
                                ),
                              ),);
                            },
                            child: profileWidget(
                              padding: size.height*0.01,
                              photo: user[index].get("photoUrl"),
                              photoWidth: size.width*0.5,
                              photoHeight: size.height*0.3,
                              clipRadius: size.height*0.01,
                              containerHeight: size.height*0.03,
                              containerWidth: size.height*0.5,
                              child: Text(" "+user[index].get('name'),style: GoogleFonts.openSans(color: Colors.white),)
                            ),
                          );
                        },childCount: user.length
                    ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ));
                  }      else{
                    return SliverToBoxAdapter(
                      child: Container(),
                    );
                  }        },)
            ],
          );
        }


        return Container();
    },);
  }
}
