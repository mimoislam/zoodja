import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/messaging/messaging_bloc.dart';
import 'package:zoodja/models/message.dart';
import 'package:zoodja/models/user.dart';
import 'package:zoodja/repositories/messageRepository.dart';
import 'package:zoodja/repositories/messaging.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/widgets/message.dart';
import 'package:zoodja/ui/widgets/photo.dart';


class Messaging extends StatefulWidget {
  final User currentUser;
  final User selectedUser;

  const Messaging({ this.currentUser, this.selectedUser});
  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  TextEditingController _messageTextController=TextEditingController();
  MessagingRepository _messagingRepository =MessagingRepository();
  MessagingBloc _messagingBloc;
  bool isValid=false;

  bool get isPopulated=>_messageTextController.text.isNotEmpty;

  bool isSubmitButtonEnabled(MessagingState state){
    return isPopulated ;
  }

  @override
  void initState() {
    _messagingBloc=MessagingBloc(messagingRepository: _messagingRepository);
    _messageTextController.text="";
    _messageTextController.addListener(() {
      setState(() {
        isValid=(_messageTextController.text.isEmpty)?false:true;
      });
    });
    super.initState();
  }


  @override
  void dispose() {
    _messageTextController.dispose();
    super.dispose();
  }
  void _onFormSubmitted(){
    print("Message Submitted");
    _messagingBloc.add(SendMessageEvent(message: Message(
      text: _messageTextController.text,
      senderId: widget.currentUser.uid,
      senderName: widget.currentUser.name,
      selectedUserId: widget.selectedUser.uid,
      photo: null,
    )));
    _messageTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: size.height*0.02,
        title: Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           ClipOval(
             child: Container(
               height: size.height*0.06,
               width: size.height*0.06,
               child: PhotoWidget(photoLink:widget.selectedUser.photo ,),
             ),
           ),
           SizedBox(width: size.width*0.03,),
           Expanded(child: Text(widget.selectedUser.name,style: GoogleFonts.openSans(),))
         ],
        ),
      ),
      body: BlocBuilder<MessagingBloc,MessagingState>(
        bloc: _messagingBloc,
        builder: (context, state) {
          if(state is MessagingInitialState){
            _messagingBloc.add(MessageStreamEvent(selectedUserId: widget.selectedUser.uid,currentUserId: widget.currentUser.uid));
          }
          if(state is MessagingLoadingState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is MessagingLoadedState){
            Stream <QuerySnapshot> messageStream=state.messageStream;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: messageStream,
                  builder:(context, snapshot) {
                    if(!snapshot.hasData){
                      return Container(
                        child: Text("Start Conversation ",style: GoogleFonts.openSans(fontSize: 16,fontWeight: FontWeight.bold),),
                      );
                    }
                    if(snapshot.data.docs.isNotEmpty){
                      return Expanded
                        (child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        scrollDirection: Axis.vertical,

                       itemBuilder: (context, index) {
                         return MessageWidget(
                           currentUserId: widget.currentUser.uid,
                           messageId: snapshot.data.docs[index].id,
                         );
                       },
                      ));
                    }else{
                      return Center(child: Text("Start conversation",style: GoogleFonts.openSans(fontSize: 16,fontWeight: FontWeight.bold),),);
                    }
                }, ),
                Container(
                  width: size.width,
                  height: size.height*0.06,
                  color: backgroundColor,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: ()async{
                          FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);

                          if(result != null) {
                            File(result.files.single.path);
                            _messagingBloc.add(SendMessageEvent(
                              message: Message(
                                text: null,
                                senderName: widget.currentUser.name,
                                senderId: widget.currentUser.uid,
                                photo: File(result.files.single.path),
                                selectedUserId: widget.selectedUser.uid,
                              )
                            ));
                          
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.height*0.005),
                          child: Icon(Icons.add,color: Colors.white,size: size.height*0.04,),
                        ),
                      ),
                      Expanded(
                          child: Container(
                            height: size.height*0.05,
                            padding: EdgeInsets.all(size.height*0.01),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(size.height*0.04),
                            ),
                            child: Center(
                              child: TextField(
                                controller: _messageTextController,
                                textInputAction: TextInputAction.send,
                                maxLines: null,
                                decoration:null,
                                textAlignVertical: TextAlignVertical.center,
                                cursorColor:backgroundColor,
                                textCapitalization: TextCapitalization.sentences,
                              ),
                            ),
                          )
                      ),
                      GestureDetector(
                        onTap: isValid
                            ? _onFormSubmitted
                            : null,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.height*0.01),
                          child: Icon(Icons.send,color:isValid? Colors.white: Colors.grey,size: size.height*0.04,),
                        ),
                      ),                    ],
                  ),
                )
              ],
            );
          }

          return Container();

        },
      ),
    );
  }
}
