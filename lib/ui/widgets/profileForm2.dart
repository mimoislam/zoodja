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
  bool get  isFilled=> _professionEditingController.text.isNotEmpty&&_lineEditingController.text.isNotEmpty;

  TextEditingController _professionEditingController=TextEditingController();
  TextEditingController _lineEditingController=TextEditingController();
  String hijab;
  String dropdownValue = 'Brown';
  String dropdownValue2 = "Film";
  int wilaya = 1;
  int commune = 0;
  List listCommune = [];
  ProfileBloc _profileBloc;

  List<String> eyesColor=[
    "Brown",
    'Blue',
    'Hazel',
    'Amber',
    'Gray',
    'Green'
  ];
  List<String> love=[
    "Film", 'voyages', 'sport', 'TV', 'Cuisine'
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      child: Text("Complete Your Profile",  style: GoogleFonts.openSans(fontSize: 20, color: text_color, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Text("Wilaya", style: GoogleFonts.openSans(fontWeight: FontWeight.w600,fontSize: 17,color:Color(0xff18516E) ),)),

                  DropdownButtonFormField<int>(
                    value: wilaya,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),

                    ),
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,

                    onChanged: (int newValue) {
                      setState(() {
                        wilaya = newValue;
                        getCommune();
                      });
                    },
                    items: algeria_wilaya
                        .map<DropdownMenuItem<int>>(( value) {
                      return DropdownMenuItem<int>(
                        value: value['wilaya_code'],
                        child: Text(value["wilaya_name_ascii"]),
                      );
                    }).toList(),
                  ) ,
                  SizedBox(height: 20,),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Text("Commune", style: GoogleFonts.openSans(fontWeight: FontWeight.w600,fontSize: 17,color:Color(0xff18516E) ),)),

                  FutureBuilder(
                    future: getCommune(),
                    builder: (context, snapshot) {
                    return DropdownButtonFormField<int>(
                      value: commune,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),

                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,

                      onChanged: (int newValue) {
                        setState(() {
                          commune = newValue;
                        });
                      },
                      items: listCommune
                          .map<DropdownMenuItem<int>>(( value) {
                        return DropdownMenuItem<int>(
                          value: value['id'],
                          child: Text(value["commune_name_ascii"]),
                        );
                      }).toList(),
                    ) ;
                  },),

                  SizedBox(height: 20,),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Text("Eyes Color ", style: GoogleFonts.openSans(fontWeight: FontWeight.w600,fontSize: 17,color:Color(0xff18516E) ),)),

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
                        underline: Container(),
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
                  SizedBox(height: 20,),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Text("What do you Like ?", style: GoogleFonts.openSans(fontWeight: FontWeight.w600,fontSize: 17,color:Color(0xff18516E) ),)),

                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),

                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue2,
                        elevation: 16,
                        underline: Container(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue2 = newValue;
                          });
                        },
                        items:love
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                  ),
                  SizedBox(height: 20,),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Text("What Is your Profession", style: GoogleFonts.openSans(fontWeight: FontWeight.w600,fontSize: 17,color:Color(0xff18516E) ),)),

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
                  SizedBox(height: 20,),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Text("Describe yourself one line", style: GoogleFonts.openSans(fontWeight: FontWeight.w600,fontSize: 17,color:Color(0xff18516E) ),)),

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
                      onTap: isFilled?(){ User user1;
                      if(widget.user.gender=="Female"){
                        user1=User(name: widget.user.name,love:dropdownValue2,ville:commune , email: widget.user.email,gender: widget.user.gender, interestedIn: widget.user.interestedIn, ages: widget.user.ages, location: widget.user.location, photoFile: widget.user.photoFile,hijab: hijab,profession: _professionEditingController.text,eyesColor: dropdownValue,line: _lineEditingController.text);

                      }else
                      {
                        user1=User(name: widget.user.name,ville:commune ,love:dropdownValue2,  email: widget.user.email,gender: widget.user.gender, interestedIn: widget.user.interestedIn, ages: widget.user.ages, location: widget.user.location, photoFile: widget.user.photoFile,profession: _professionEditingController.text,eyesColor: dropdownValue,line: _lineEditingController.text);
                      }

                      _profileBloc.add(Submitting(user:user1));
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
  getCommune()async{
    listCommune=[];
    for(int index=0;index<algeria_cites.length;index++){
      if(int.parse(algeria_cites[index]["wilaya_code"])==wilaya){
        listCommune.add(algeria_cites[index]);
      }
    }
    commune = listCommune[0]["id"];
  }
}
