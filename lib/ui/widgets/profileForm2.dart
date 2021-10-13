import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/authentication/authentication_bloc.dart';
import 'package:zoodja/bloc/profile/profile_bloc.dart';
import 'package:zoodja/models/user.dart';
import 'package:zoodja/ui/constats.dart';


class ProfileForm2 extends StatefulWidget {
  final User user;
  final ProfileBloc profileBloc;
  ProfileForm2({this.user,this.profileBloc});
  @override
  _ProfileForm2State createState() => _ProfileForm2State();
}


class _ProfileForm2State extends State<ProfileForm2> {
  bool get  isFilled=> _villeEditingController.text.isNotEmpty &&_professionEditingController.text.isNotEmpty&&_lineEditingController.text.isNotEmpty;

  TextEditingController _villeEditingController=TextEditingController();
  TextEditingController _professionEditingController=TextEditingController();
  TextEditingController _lineEditingController=TextEditingController();
  String hijab;
  String dropdownValue = 'Brown';
  ProfileBloc _profileBloc;

  List<String> eyesColor=[
    "Brown",
    'Blue',
    'Hazel',
    'Amber',
    'Gray',
    'Green'
  ];
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return BlocListener<ProfileBloc, ProfileState>(
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
  child: BlocBuilder<ProfileBloc, ProfileState>(
    bloc: _profileBloc,
  builder: (context, state) {
    if(       state.isSubmitting)
      return Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      );
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Text("Complete Your Profile",  style: GoogleFonts.openSans(fontSize: 20, color: text_color, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 30,),
                  Container(

                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextFormField(
                      controller: _villeEditingController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          labelText: "Ville",
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),

                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        elevation: 16,

                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items:eyesColor
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                  ),
                  SizedBox(height: 30,),
                  Container(

                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextFormField(
                      controller: _professionEditingController,
                      maxLines: 1,
                      maxLength: 50,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          labelText: "Profession",
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(

                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextFormField(
                      controller: _lineEditingController,
                      maxLines: 1,
                      maxLength: 100,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          labelText: "Describe yourself one line",
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  widget.user.gender=="Female"?Row(
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
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            hijab="Can't say";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                          decoration: BoxDecoration(
                              color: text_color2.withOpacity(0.4)
                          ),
                          child: Text("Can't say",style: GoogleFonts.assistant(          color:hijab=="Can't say"?Colors.white:Color(0xff8969AE)),),
                        ),
                      )
                    ],
                  ):Container(),
                  SizedBox(height: 30,),


                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: isFilled?(){ User user;
                      if(widget.user.gender=="Female"){
                        user=User(name: widget.user.name, email: widget.user.email,gender: widget.user.gender, interestedIn: widget.user.interestedIn, ages: widget.user.ages, location: widget.user.location, photoFile: widget.user.photoFile,hijab: hijab,profession: _professionEditingController.text,eyesColor: dropdownValue,line: _lineEditingController.text);

                        // _profileBloc.add(Submitting(name: _nameController.text, gender: gender, interestedIn: interestedIn, age: age, location: location, photo: photo,hijab:hijab)
                        //
                        // );
                      }else
                      {
                        user=User(name: widget.user.name,  email: widget.user.email,gender: widget.user.gender, interestedIn: widget.user.interestedIn, ages: widget.user.ages, location: widget.user.location, photoFile: widget.user.photoFile,profession: _professionEditingController.text,eyesColor: dropdownValue,line: _lineEditingController.text);

                      }

                      _profileBloc.add(Submitting(user:user));
                      Navigator.pop(context);
                      }:null,
                      child: Center(
                        child: Container(
                          width: size.width*0.8,
                          height: 40,
                          decoration: BoxDecoration(
                              color: isFilled?Color(0xff3B5998):Colors.grey,
                              borderRadius: BorderRadius.circular(size.height*0.05)
                          ),
                          child: Center(
                            child: Text("Get Started",style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  },
),
);
  }
  @override
  void initState() {
    hijab="Veiled";
    _profileBloc=widget.profileBloc;

    super.initState();
  }
}
