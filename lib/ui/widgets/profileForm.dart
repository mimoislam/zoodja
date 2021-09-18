import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/bloc/login/login_bloc.dart';
import 'package:zoodja/bloc/profile/profile_bloc.dart';
import 'package:zoodja/repositories/userRepository.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/widgets/gender.dart';

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
  UserRepository get _userRepository=>widget._userRepository;


  String gender,interestedIn;
  DateTime age;
  File photo;
  GeoPoint location;
  ProfileBloc _profileBloc;
  bool get isFilled=>  _nameController.text.isNotEmpty&& gender !=null
  &&photo!=null&&age!=null;
 bool isButtonEnabled(ProfileState state){
   return isFilled &&!state.isSubmitting;
 }
  _getLocation ()async{
   Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   location=GeoPoint(position.latitude, position.longitude);;
  }
  _onSubmitted()async{
    await _getLocation();
    if(gender=="Female"){
      interestedIn="Male";
    }else
      {
        interestedIn="Female";
      }
    _profileBloc.add(Submitting(name: _nameController.text, gender: gender, interestedIn: interestedIn, age: age, location: location, photo: photo)
    );

  }

  @override
  void initState() {
   _getLocation();
   _profileBloc=BlocProvider.of<ProfileBloc>(context);
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

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:  Container(
          width:  size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
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
                      child:  Image.asset("assets/default.jpg"),
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
                textFieldWidget(_nameController, "Name", size),
                GestureDetector(
                  onTap: (){
                    DatePicker.showDatePicker(context,showTitleActions: true,
                        minTime: DateTime(1900,1,1),maxTime: DateTime(DateTime.now().year-19,1,1),
                      onConfirm: (time) {
                        setState(() {
                          age=time;
                        });
                        print(age);
                      },
                    );
                    },
                  child: Text("Enter Birthday",style: TextStyle(color: Colors.black,fontSize: size.width*0.09),),
                ),
                Text(age.toString()),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.height*0.02),
                      child: Text("You are " ,style:TextStyle(color: Colors.black,fontSize: size.width*0.09)),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height*0.02),
                  child: GestureDetector(
                    onTap: (){
                      if(isButtonEnabled(state)){
                        _onSubmitted();
                      }
                    },
                    child: Container(
                      width: size.width*0.8,
                      height: size.height*0.06,
                      decoration: BoxDecoration(
                        color: isButtonEnabled(state)?Colors.white:Colors.grey,
                        borderRadius: BorderRadius.circular(size.height*0.05)
                      ),
                      child: Center(
                        child: Text("Save",style: TextStyle(
                          fontSize: size.height*0.025,
                          color: Colors.blue,
                        ),),
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
      child:  TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(color: Colors.white,fontSize: size.height*0.03),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,width: 1),
          ),
        ),
                      ),
  );
}
