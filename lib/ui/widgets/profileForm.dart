import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/bloc/login/login_bloc.dart';
import 'package:zoodja/bloc/profile/profile_bloc.dart';
import 'package:zoodja/models/user.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/validator.dart';
import 'package:zoodja/ui/widgets/gender.dart';
import 'package:zoodja/ui/widgets/profileForm2.dart';

class ProfileForm extends StatefulWidget {
  final UserRepository _userRepository;

  const ProfileForm({@required UserRepository userRepository}):
        assert(userRepository !=null),
        _userRepository=userRepository ;
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _ageController=TextEditingController();
  UserRepository get _userRepository=>widget._userRepository;

  final TextEditingController _emailController=TextEditingController();

  String gender,interestedIn;
  DateTime age;
  File photo;
  GeoPoint location;
  ProfileBloc _profileBloc;
  bool get isFilled=>  _nameController.text.isNotEmpty&& gender !=null
  &&photo!=null&&age!=null;
 bool isButtonEnabled(ProfileState state){
   return isFilled ;
 }
  _getLocation ()async{
   Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   location=GeoPoint(position.latitude, position.longitude);;
  }
  showDialogs({String message}){
    return showDialog(
      context: context,
      builder: (context) {
        return
          AlertDialog(
            title: const Text("Missing Field"),
            content:  Text(message),
            actions: [
               GestureDetector(
                child: const Text(" OK ",style: TextStyle(color: Colors.blue,fontSize: 20),),
                onTap: () => Navigator.pop(context),
              ),
            ],
          );
      },
    );
  }
  _onSubmitted()async{
    await _getLocation();
    bool s=await _userRepository.checkEmail(_emailController.text);

    User user;
    if (s){
      return showDialogs(message: "Invalid or Used  Email Please Check it Again ");
    }else
      if (photo==null){
      return showDialogs(message: " Please Enter Your Photo ");
    }else
    if (_nameController.text==""){
      return showDialogs(message: " Please Enter Your name ");
    }else
    if (_emailController.text==""){
      return showDialogs(message: " Please Enter Your email ");
    }
    else
    if (age==null){
      return showDialogs(message: " Please Enter Your Age ");
    }
    if(gender=="Female"){

      interestedIn="Male";
      user=User(name: _nameController.text, gender: gender, interestedIn: interestedIn, ages: age, location: location, photoFile: photo,email: _emailController.text);

      // _profileBloc.add(Submitting(name: _nameController.text, gender: gender, interestedIn: interestedIn, age: age, location: location, photo: photo,hijab:hijab)
      //
      // );
    }else
      {
        interestedIn="Female";
        user=User(name: _nameController.text, gender: gender, interestedIn: interestedIn, ages: age, location: location, photoFile: photo,email:_emailController.text);
        //
        // _profileBloc.add(Submitting(name: _nameController.text, gender: gender, interestedIn: interestedIn, age: age, location: location, photo: photo)
        // );
      }

    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileForm2(user: user,profileBloc: _profileBloc,),));


  }

  @override
  void initState() {
   _getLocation();
   _profileBloc=BlocProvider.of<ProfileBloc>(context);
   gender="Female";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   Size size =MediaQuery.of(context).size;

    return BlocListener<ProfileBloc,ProfileState>(
        bloc: _profileBloc,
        listener: (context, state) {
          if(state.isFailure){
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SignUp Failed'),
                    Icon(Icons.error)
                  ],
                ),
                duration: Duration(seconds: 2),
              ),
            );
          }
          if(state.isSubmitting){
            print('isSubmitting');
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Signing Up ......'),
                    CircularProgressIndicator()
                  ],
                ),
                duration: Duration(seconds: 2),
              ),
            );
          }
          if (state.isSuccess){
            print('isSuccess');
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          }

        },
    child: BlocBuilder<ProfileBloc,ProfileState>(
      builder: (context, state) {
        print("state");
        if(       state.isSubmitting)
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:  Container(
          width:  size.width,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());

                    // Navigator.pop(context);
                  },
                  child: Icon(Icons.clear,color: Colors.black,),
                ),
                ClipRRect(
                 borderRadius: BorderRadius.circular(size.height*0.1),
                  child: Container(
                    width: size.width,
                    child: CircleAvatar(
                      radius: size.width*0.3,
                      backgroundColor: Colors.transparent,
                      child: photo==null ?GestureDetector(
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
                        child:  ClipRRect(
                            borderRadius: BorderRadius.circular(200),child: Image.asset("assets/default.jpg",height: 200,)),
                      ):GestureDetector(
                        onTap: () async{
                          FilePickerResult result = await FilePicker.platform.pickFiles();

                          if(result != null) {
                            setState(() {
                              photo = File(result.files.single.path);
                            });                        } else {
                            // User canceled the picker
                          }
                        },
                        child:  CircleAvatar(
                          radius:  size.width*0.3,backgroundImage: FileImage(photo),
                        ),

                      ),
                    ),
                  ),
                ),
                textFieldWidget(_nameController, "User Name", size),
                Padding(
                  padding: EdgeInsets.all(size.height*0.02),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    color: text_color2.withOpacity(0.4),

                    child: TextFormField(
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => Validators.isValidEmail(value)?null :"please enter email",

                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: GoogleFonts.openSans(
                          color: text_color2,
                          fontSize: 13
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),

                ),


                GestureDetector(
                    onTap: (){
                      DatePicker.showDatePicker(context,showTitleActions: true,
                        minTime: DateTime(DateTime.now().year-80,1,1),maxTime: DateTime(DateTime.now().year-19,1,1),
                        onConfirm: (time) {
                          setState(() {
                            age=time;
                            _ageController.text=age.year.toString()+"/"+age.month.toString()+"/"+age.day.toString();
                          });

                          print(age);
                        },
                      );
                    },
                    child:  Padding(
                      padding: EdgeInsets.all(size.height*0.02),
                      child:  Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                        color: text_color2.withOpacity(0.4),
                        child: TextField(
                            enabled: false,
                            controller: _ageController,
                            decoration: InputDecoration(
                            labelText:"Birthday" ,
                            labelStyle: GoogleFonts.openSans(
                            color: text_color2,
                            fontSize: 13
                            ),
                              hintText: DateTime(DateTime.now().year-19,1,1).year.toString()+"/"+DateTime(DateTime.now().year-19,1,1).month.toString()+"/"+DateTime(DateTime.now().year-19,1,1).day.toString(),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                          ),

                        ),
                      ),
                    )
                ),


                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:10),
                      child: Text("Gender" ,style:TextStyle(color: Colors.black,fontSize: size.width*0.09)),
                    ),
                    Row(
                      mainAxisAlignment:  MainAxisAlignment.spaceAround,
                      children: [
                        genderWidget(FontAwesomeIcons.venus, "Female", size, gender, (){
                          setState(() {
                            gender="Female";
                          });
                        }),
                        genderWidget(FontAwesomeIcons.mars, "Male", size, gender, (){
                          setState(() {
                            gender="Male";
                          });
                        })
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30,),


                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: (){
                        _onSubmitted();

                    },
                    child: Center(
                      child: Container(
                        width: size.width*0.8,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isButtonEnabled(state)?Color(0xff3B5998):Colors.grey,
                          borderRadius: BorderRadius.circular(size.height*0.05)
                        ),
                        child: Center(
                          child: Text("Get Started",style: TextStyle(
                            fontSize: 20,
                            color: isButtonEnabled(state)?Colors.white:Colors.black,
                          ),),
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        );
      },
    ),
    );
  }

  @override
  void dispose() {
   _nameController.dispose();
    super.dispose();
  }
}
Widget textFieldWidget(controller,text,size){
  return Padding(
      padding: EdgeInsets.all(size.height*0.02),
      child:  Container(
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
        color: text_color2.withOpacity(0.4),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: text,
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
  );
}
