import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/models/user.dart';
import 'package:zoodja/ui/widgets/photo.dart';

class ProfileItem extends StatefulWidget {
final User user ;
final int difference;
  const ProfileItem({ this.user,this.difference});
  @override
  _ProfileItemState createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  User get user =>widget.user;
  int get difference =>widget.difference;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(size.height*0.035),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.height*0.05),
                      ),
                      child:Column(
                        children: [
                              Container(
                                width: size.width*0.9,
                                height: size.height*0.7,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(size.height*0.05),
                                  child: PhotoWidget( photoLink:  user.photo,),
                                ),
                              ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.height*0.02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),

                                Container(
                                  child: Text(user.name +" , "
                                      +(DateTime.now().year-user.age.toDate().year)    .toString(),
                                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontSize: 20,color:Color(0xff18516E)),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(height: 5,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text((difference!=null?(difference/1000000).floor().toString()+
                                        " km":"away")+", "+user.love+", "+user.ville,
                                      style: GoogleFonts.openSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600
                                      ),

                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text("Description ",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontSize: 17,color:Color(0xff18516E))
                                ),
                                Text(user.line,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontSize: 15
                                  ),
                                ),
                                Text("Color of Eyes"+user.eyesColor,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.openSans(
                                      color: Colors.black,
                                      fontSize: 15
                                  ),
                                ),

                              ],
                            ),

                          )

                        ],
                      ),
                    ),

                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
