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
import 'package:zoodja/ui/widgets/photo.dart';
import 'package:zoodja/ui/widgets/profileWidget.dart';
import 'package:zoodja/ui/widgets/userGender.dart';
class Matches extends StatefulWidget {
  final String userId;
  final MatchesRepository  matchesRepository;
  const Matches({this.userId,this.matchesRepository}) ;

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  MatchesRepository  matchesRepository;
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
    matchesRepository=widget.matchesRepository;
    _matchesBloc=BlocProvider.of<MatchesBloc>(context);
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
          return Container(
            color: Colors.white,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  expandedHeight: 0,
                  title: Text(
                    "You have … match",
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 20.0
                    ),

                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: state.matchedList,
                  builder: (context, snapshot) {

                    if(!snapshot.hasData)
                      return SliverToBoxAdapter(
                        child: Container(height: size.height*0.2,),
                      );
                    if((snapshot.data.docs!=null)&&(snapshot.data.docs.length!=0)){
                      final user=snapshot.data.docs;
                      return SliverGrid(delegate: SliverChildBuilderDelegate(
                        (BuildContext context,int index)
                      {
                        print(index);
                        return GestureDetector(
                      onTap:()async{
                        User selectUser=await matchesRepository.getUserDetails(user[index].id);
                        User currentUser=await matchesRepository.getUserDetails(widget.userId);
                        await getDifference(selectUser.location);
                        showDialog(context: context, builder: (context) =>
                          Dialog(
                            backgroundColor: Colors.transparent,
                            child: ProfileWidget(
                              photo: selectUser.photo,
                              photoHeight: size.height*0.8,
                              padding: size.height*0.01,
                              photoWidth: size.width,
                              clipRadius: size.height*0.01,
                              containerWidth:size.width,
                              containerHeight: size.height*0.2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: size.height*0.02),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: size.height*0.02,
                                    ),
                                      Text(" "+selectUser.name+", "+
                                      (DateTime.now().year-selectUser.age.toDate().year).toString(),
                                      style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 20,
                                      ),
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: [
                                        Icon(Icons.location_on,color: Colors.white,),
                                        Text(difference!=null?(difference/1000).floor().toString()+
                                            " km away":"away",
                                          style: GoogleFonts.openSans(
                                            color: Colors.white,
                                          ),),
                                        SizedBox(
                                          height: 20,
                                        ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(size.height*0.02),
                                                  child: iconWidget(Icons.message , (){
                                                    _matchesBloc.add(OpenChatEvent(currentUser: widget.userId,selectedUser: selectUser.uid));
                                                    pageTurn(Messaging(currentUser: currentUser,selectedUser: selectUser), context);
                                                  }, size.height*0.04, Colors.transparent),

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
                      ProfileWidget(
                        padding: size.height*0.01,
                        photo: user[index]['photourl'],
                        photoWidth: size.width*0.5,
                        photoHeight: 150.0,
                        clipRadius: size.height*0.01,
                        containerHeight: 150.0 ,
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
                        child: Container(height: size.height*0.2)
                      );
                    }
                },
                ),
                SliverAppBar(
                  backgroundColor: Colors.white,
                  pinned: true,
                  title:  Text(
                    "Someone liked you",
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 20.0
                    ),

                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: state.selectedList,
                  builder: (context, snapshot) {
                    print(snapshot.hasData);
                    if(!snapshot.hasData)
                    return SliverToBoxAdapter(
                    child: Container(),
                    );

                    if((snapshot.data.docs!=null)&&(snapshot.data.docs.length!=0)){
                      final user =snapshot.data.docs;
                      print(snapshot.data.docs.length==0);
                      return SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                          (BuildContext context,int index){
                            return GestureDetector(
                              onTap: ()async{
                                User selectUser=await matchesRepository.getUserDetails(user[index].id);
                                User currentUser=await matchesRepository.getUserDetails(widget.userId);
                                await getDifference(selectUser.location);
                                showDialog(context: context, builder: (context) => Dialog(
                                  child:
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),),
                                    child:Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(

                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: PhotoWidget( photoLink: selectUser.photo,),
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
                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                            ),
                                            width: 150,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: size.height*0.02),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment: CrossAxisAlignment.center,                                      children: [
                                                    Text(" "+selectUser.name+", "+
                                                        (DateTime.now().year-selectUser.age.toDate().year).toString(),
                                                      style: GoogleFonts.openSans(color: Colors.white,fontSize: 20),),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,

                                                      children: [
                                                        Icon(Icons.location_on,color: Colors.white,),
                                                        Text(difference!=null?(difference/1000).floor().toString()+
                                                            "km away":"away",
                                                          style: GoogleFonts.openSans(
                                                              color: Colors.white
                                                              ,fontSize: 20
                                                          ),),
                                                      ],
                                                    ),
                                                  ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(size.height*0.02),
                                                      child: iconWidget(Icons.clear , (){
                                                        _matchesBloc.add(DeleteUserEvent(currentUser: widget.userId,selectedUser: selectUser.uid));
                                                        Navigator.of(context).pop();
                                                      }, 30.0, Colors.blue),

                                                    ),

                                                    Padding(
                                                      padding: EdgeInsets.all(size.height*0.02),
                                                      child: iconWidget(FontAwesomeIcons.solidHeart , (){
                                                        _matchesBloc.add(AcceptUserEvent(currentUser: widget.userId,selectedUser: selectUser.uid,
                                                            currentUserName: currentUser.name,currentUserPhotoUrl: currentUser.photo,
                                                            selectedUserName: selectUser.name,selectedUserPhotoUrl: selectUser.photo));
                                                        Navigator.of(context).pop();

                                                        pageTurn(Messaging(currentUser: currentUser,selectedUser: selectUser), context);
                                                      }, 30.0, Colors.red),

                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  )

                                  // ProfileWidget(
                                  //   padding: size.height*0.01,
                                  //   photo: selectUser.photo,
                                  //   photoHeight: size.height*0.8,
                                  //   photoWidth: size.width,
                                  //   clipRadius: size.height*0.01,
                                  //   containerWidth: size.width,
                                  //     containerHeight: size.height*0.2,
                                  //   child: Padding(
                                  //     padding: EdgeInsets.symmetric(horizontal: size.height*0.02),
                                  //     child: Column(
                                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //       crossAxisAlignment: CrossAxisAlignment.center,                                      children: [
                                  //         Text(" "+selectUser.name+", "+
                                  //             (DateTime.now().year-selectUser.age.toDate().year).toString(),
                                  //           style: GoogleFonts.openSans(color: Colors.white,fontSize: 20),),
                                  //         Row(
                                  //           mainAxisAlignment: MainAxisAlignment.center,
                                  //
                                  //           children: [
                                  //             Icon(Icons.location_on,color: Colors.white,),
                                  //             Text(difference!=null?(difference/1000).floor().toString()+
                                  //                 "km away":"away",
                                  //               style: GoogleFonts.openSans(
                                  //                 color: Colors.white
                                  //                   ,fontSize: 20
                                  //               ),),
                                  //           ],
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  //   child2:  Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //     children: [
                                  //       Padding(
                                  //         padding: EdgeInsets.all(size.height*0.02),
                                  //         child: iconWidget(Icons.clear , (){
                                  //           _matchesBloc.add(DeleteUserEvent(currentUser: widget.userId,selectedUser: selectUser.uid));
                                  //           Navigator.of(context).pop();
                                  //         }, 30.0, Colors.blue),
                                  //
                                  //       ),
                                  //
                                  //       Padding(
                                  //         padding: EdgeInsets.all(size.height*0.02),
                                  //         child: iconWidget(FontAwesomeIcons.solidHeart , (){
                                  //           _matchesBloc.add(AcceptUserEvent(currentUser: widget.userId,selectedUser: selectUser.uid,
                                  //               currentUserName: currentUser.name,currentUserPhotoUrl: currentUser.photo,
                                  //               selectedUserName: selectUser.name,selectedUserPhotoUrl: selectUser.photo));
                                  //           Navigator.of(context).pop();
                                  //
                                  //           pageTurn(Messaging(currentUser: currentUser,selectedUser: selectUser), context);
                                  //         }, 30.0, Colors.red),
                                  //
                                  //       )
                                  //     ],
                                  //   )
                                  //
                                  // ),
                                ),);
                              },
                              child: ProfileWidget(
                                padding: size.height*0.01,
                                photo: user[index].get("photoUrl"),
                                photoWidth: size.width*0.8,
                                photoHeight: 150.0,
                                clipRadius: 10.0,
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
            ),
          );
        }


        return Container();
    },);
  }
}
