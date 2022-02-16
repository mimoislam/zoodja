import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/models/user.dart';
import 'package:zoodja/repositories/messageRepository.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:zoodja/ui/pages/whoAreWe.dart';

class ProfileMenu extends StatefulWidget {
final String userId;
final MessageRepository  messageRepository;

  const ProfileMenu({this.userId,this.messageRepository}) ;

  @override
  _ProfileMenuState createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  List items=["Cooking","Travel","Writing","Reading","Cat Lover","Working"];
  List<String> items2=["Working"];
  int max=3;
  bool change=false;



  MessageRepository  messageRepository;
  UserRepository    userRepository=UserRepository();
  double _currentSliderValue = 20;
  File photo;
  TextEditingController controller=TextEditingController();
  bool saving=false;
  String hijab;
  String withHijab;
  User user;
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return

      ((saving==false)&&(user!=null))
        ?Container(
              child: SingleChildScrollView(
                  child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  height: 50,
                  decoration:  BoxDecoration(
                      color: Color(0xff213A50)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Profile",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.white),),
                          Container(
                            width: 45,
                            height: 3,
                            color: Color(0xff20A39E),
                          )
                        ]
                        ,
                      ),

                    ],
                  ),

                ),

                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Text(
                      "Photos",
                      style: GoogleFonts.nunito(
                          color: Color(0xff18516E),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                      textAlign: TextAlign.start,
                    )),
                    GestureDetector(
                      onTap: ()async{
                        saving=true;
                        setState(() {

                        });
                       await  userRepository.profileUpdate(photo, widget.userId, controller.text, _currentSliderValue.toInt(),items2,withHijab,hijab);
                          saving=false;
                        setState(() {

                        });
                       },
                      child: Container(
                        width: size.width*0.3,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Color(0xff18516E),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text("Save",style: GoogleFonts.openSans(fontSize: 18,color: Colors.white,),)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          child: photo==null
                              ?GestureDetector(
                            onTap: ()async{
                              FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);

                              if(result != null) {
                                setState(() {
                                  photo = File(result.files.single.path);
                                });
                              } else {
                                // User canceled the picker
                              }
                            },
                            child:  Container(constraints: BoxConstraints(
                              maxHeight:100,
                              maxWidth:100,
                            ),
                              child: Image.network(user.photo,
                                fit: BoxFit.cover,
                                  loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null ?
                                        loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                            : null,
                                      ),
                                    );
                                  },),
                            ),
                          )
                              :GestureDetector(
                            onTap: () async{
                              FilePickerResult result = await FilePicker.platform.pickFiles();

                              if(result != null) {
                                setState(() {
                                  photo = File(result.files.single.path);
                                });                        } else {
                                // User canceled the picker
                              }
                            },
                            child:  Container(
                               child:Image.file(photo),
                            ),

                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(size.height*0.02),
                  child:  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                    color: text_color2.withOpacity(0.4),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: "User Name",
                        labelStyle: GoogleFonts.openSans(
                            color: text_color2,
                            fontSize: size.height*0.03
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),

                    ),
                  ),
                ),
                user.gender=="Female"?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          hijab="Veiled";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                        decoration: BoxDecoration(
                            color: text_color2.withOpacity(0.4)
                        ),
                        child: Text("Veiled",style: GoogleFonts.assistant(          color:hijab=="Veiled"?Colors.white:Color(0xff8969AE)),),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          hijab="Unveiled";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                        decoration: BoxDecoration(
                            color: text_color2.withOpacity(0.4)
                        ),
                        child: Text("Unveiled",style: GoogleFonts.assistant(          color:hijab=="Unveiled"?Colors.white:Color(0xff8969AE)),),
                      ),
                    ),
                  ],
                ):Container(),
                Text("Filters", style: GoogleFonts.openSans(fontWeight: FontWeight.w300,fontSize: 17,color:Color(0xff18516E) ),),
                SizedBox(height:10 ,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Kilometery", style: GoogleFonts.openSans(fontWeight: FontWeight.w500,fontSize: 13,color:Color(0xff18516E) ),),
                    Text(_currentSliderValue.toInt().toString()+" Km", style: GoogleFonts.openSans(fontWeight: FontWeight.w600,fontSize: 13,color:Color(0xffB780FF) ),)
                  ],
                ),
                Slider(
                  activeColor: Color(0xffFE3C72),
                  inactiveColor: Color(0xffE6DEEF),
                  value: _currentSliderValue,
                  min: 1,
                  max: 500,
                  divisions: 500,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
                user.gender=="Male"?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          withHijab="Veiled";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                        decoration: BoxDecoration(
                            color: text_color2.withOpacity(0.4)
                        ),
                        child: Text("Veiled",style: GoogleFonts.assistant(          color:withHijab=="Veiled"?Colors.white:Color(0xff8969AE)),),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          withHijab="Unveiled";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                        decoration: BoxDecoration(
                            color: text_color2.withOpacity(0.4)
                        ),
                        child: Text("Unveiled",style: GoogleFonts.assistant(          color:withHijab=="Unveiled"?Colors.white:Color(0xff8969AE)),),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          withHijab=null;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                        decoration: BoxDecoration(
                            color: text_color2.withOpacity(0.4)
                        ),
                        child: Text("No matter",style: GoogleFonts.assistant(          color:withHijab==null?Colors.white:Color(0xff8969AE)),),
                      ),
                    )
                  ],
                ):Container(),
                SizedBox(
                  height: 20,
                ),
                RichText(text: TextSpan(
                    children: [
                      for(int index=0; index<items.length;index++)
                        WidgetSpan(child: GestureDetector(
                          onTap: (){
                            print(max>items2.length);
                            if(items2.contains(items[index])){
                              items2.remove(items[index]);
                            }else{
                              if(max>items2.length){
                                items2.add(items[index]);
                              }
                            }
                            setState(() {
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            padding: EdgeInsets.symmetric(horizontal:10,vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black),
                                color: items2.contains(items[index])?Color(0xffFE3C72):Colors.white
                            ),
                            child: Text(items[index],style: TextStyle(
                                color: items2.contains(items[index])?Colors.white:Colors.black
                            ),),
                          ),
                        ))
                    ]
                )),

                SizedBox(
                  height: 50,
                ),
                Text("Contact Us", style: GoogleFonts.openSans(fontWeight: FontWeight.w300,fontSize: 17,color:Color(0xff18516E) ),),
                SizedBox(
                  height: 20,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          change=!change;
                          setState(() {

                          });
                        },
                        child: Container(
                          width: size.width*0.7,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Color(0xff18516E),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Text(change?"Change Language to French":"Changer la langue en anglais",style: GoogleFonts.openSans(fontSize: 15,color: Colors.white,),)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => WhoAreWe(),));

                        },
                        child: Container(
                          width: size.width*0.7,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: Color(0xff18516E),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Text("Who Are We",style: GoogleFonts.openSans(fontSize: 20,color: Colors.white,),)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: GestureDetector(
                        onTap: (){
                           BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                          width: size.width*0.7,

                          decoration: BoxDecoration(
                              color: Color(0xffFE3C72),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Text("LOGOUT",style: GoogleFonts.openSans(fontSize: 18,color: Colors.white,),)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ))):Center(child: Container(child: CircularProgressIndicator()));


  }

  @override
  void initState() {
    messageRepository=widget.messageRepository;
    getUser();
    super.initState();
  }
 getUser()async{

     user= await messageRepository.getUserDetails(widget.userId);
     _currentSliderValue=(user.filter).toDouble();
     withHijab=(user.withHijab);
     print(photo);
    controller.text=user.name;
    items2=user.tags;
    hijab=user.hijab;
     setState(() {});
  }

}
