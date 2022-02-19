import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:zoodja/bloc/messaging/messaging_bloc.dart';
import 'package:zoodja/models/message.dart';
import 'package:zoodja/models/user.dart';
import 'package:zoodja/repositories/messageRepository.dart';
import 'package:zoodja/repositories/messaging.dart';
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/widgets/message.dart';
import 'package:zoodja/ui/widgets/photo.dart';
import "package:timeago/timeago.dart" as  timeAgo;
import 'package:zoodja/ui/widgets/photoLink.dart';


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
  List<Message> messages=[];
  ItemScrollController _scrollController = ItemScrollController();
  bool isListing=false;
  bool gettingMessages=false;


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
    DocumentReference messageRef=_messagingRepository.getMessageRef();
    print(messageRef.id);
    Message message=Message(
      uid: messageRef.id,
      text: _messageTextController.text,
      senderId: widget.currentUser.uid,
      senderName: widget.currentUser.name,
      selectedUserId: widget.selectedUser.uid,
      photo: null,
      isSend: false,timestamp: Timestamp. fromDate(DateTime.now())
    );
    setState(() {
      messages.add(message);
    });
    _messagingBloc.add(SendMessageEvent(message: message,documentReference: messageRef));

    _messageTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double top=MediaQuery.of(context).padding.top;
    return Scaffold(

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

            if(!isListing) {
              messageStream.listen((event) async {
                if (messages.length == 0) {
                  setState(() {
                    gettingMessages=true;
                  });
                  for (int index = 0; event.docs.length > index; index++) {
                    Message message = await getDetails(event.docs[index].id);
                    messages.insert(0,message);
                  }
                  setState(() {
                    print(messages.length);
                    gettingMessages=false;
                  });
                } else {
                  for (int index = 1;
                      event.docChanges.length > index;
                      index++) {

                    Message message=Message(uid: event.docChanges[index].doc.id);
                    if(messages.contains(message))
                      {
                      for(int index =messages.length-1;index>0;index--){
                        if (message.uid==messages[index].uid){
                            messages[index].isSend=true;
                        }
                      }
                    }
                    else
                      {
                      Message message = await getDetails(event.docChanges[index].doc.id);
                      messages.add(message);
                    }
                  }
                  if (mounted)
                    setState(() {
                    });
                }
              });
              isListing=true;
            }
            return gettingMessages
                ? Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        Colors.blueGrey,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Getting Messages ......")
                  ],
                ),
              ),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 20+top,),
                Container(
                  width: double.infinity,

                  margin:EdgeInsets.only(bottom: 20,left: 10) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          height:88,
                          width: 88,
                          child: PhotoWidget(photoLink:widget.selectedUser.photo ,),
                        ),
                      ),
                      SizedBox(width: 12,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(widget.selectedUser.name,style: GoogleFonts.nunito(fontSize: 22,fontWeight: FontWeight.bold,color: Color(0xff18516E)),overflow: TextOverflow.ellipsis,),
                            Text(widget.selectedUser.love+" ,"+(DateTime.now().year-widget.selectedUser.age.toDate().year)    .toString() ,overflow: TextOverflow.ellipsis,style: GoogleFonts.montserrat(
                                color: Color(0xff18516E),
                                fontSize: 13,fontWeight: FontWeight.w300),),
                          ],
                        ),
                      ),
                      SizedBox(width: 12,),

                    ],
                  ),
                ),


                (messages.length==0)
                      ?Center(child: Text("Start conversation",style: GoogleFonts.openSans(fontSize: 16,fontWeight: FontWeight.bold),),)
                      :
                         Expanded(
                            child: ScrollablePositionedList.builder(
                          addAutomaticKeepAlives: true,
                          initialScrollIndex: messages.length,
                          itemScrollController: _scrollController,
                          itemCount: messages.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                             bool show = false;
                             return Column(
                                      crossAxisAlignment: messages[index].senderId ==
                                              widget.currentUser.uid
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        messages[index].text != null
                                            ? Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.start,
                                                direction: Axis.horizontal,
                                                children: [
                                                  Stack(
                                                    textDirection:messages[index].senderId ==
                                                        widget
                                                            .currentUser.uid?TextDirection.rtl:TextDirection.ltr,

                                                    children: [
                                                      Image.asset(messages[index].senderId ==
                                                          widget
                                                              .currentUser.uid?"assets/triangal.png":"assets/triangal2.png"),

                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment: messages[index]
                                                                    .senderId ==
                                                                widget
                                                                    .currentUser.uid
                                                            ? CrossAxisAlignment.end
                                                            : CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ConstrainedBox(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth:
                                                                  size.width *
                                                                      0.7,

                                                            ),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  show = !show;
                                                                });
                                                              },
                                                              child: Container(
                                                                margin:EdgeInsets.only(right: 19,top: 11.3,left: 19),

                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: messages[index].senderId ==
                                                                                widget
                                                                                    .currentUser.uid
                                                                            ? Color(
                                                                                0xffFE3C72)
                                                                            : Color(
                                                                                0xffE6DEEF),
                                                                      borderRadius: BorderRadius.circular(5)
                                                                       ),
                                                                padding: EdgeInsets
                                                                    .all(size
                                                                            .height *
                                                                        0.015),
                                                                child: Text(
                                                                  messages[index].text,
                                                                  style: GoogleFonts.openSans(
                                                                      color: messages[index].senderId ==
                                                                              widget
                                                                                  .currentUser.uid
                                                                          ? Colors
                                                                              .white
                                                                          : Color(
                                                                              0xff18516E)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          messages[index].senderId ==
                                                                  widget.currentUser
                                                                      .uid
                                                              ? AnimatedContainer(
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          300),
                                                                  height:
                                                                      show == true
                                                                          ? 20
                                                                          : 0,
                                                                  child: Text(
                                                                    timeAgo.format(
                                                                        messages[index]
                                                                            .timestamp
                                                                            .toDate()),
                                                                    style: GoogleFonts
                                                                        .openSans(
                                                                            fontSize:
                                                                                12),
                                                                  ))
                                                              : AnimatedContainer(
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          300),
                                                                  height:
                                                                      show == true
                                                                          ? 20
                                                                          : 0,
                                                                  child: Text(
                                                                    timeAgo.format(
                                                                        messages[index]
                                                                            .timestamp
                                                                            .toDate()),
                                                                    style: GoogleFonts
                                                                        .openSans(
                                                                            fontSize:
                                                                                12),
                                                                  ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PhotoLink(
                                                          url:
                                                              messages[index].photoUrl,
                                                        ),
                                                      ));
                                                },
                                                child: Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.start,
                                                  direction: Axis.horizontal,
                                                  children: [
                                                    messages[index].senderId ==
                                                            widget
                                                                .currentUser.uid
                                                        ? Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        size.height *
                                                                            0.01),
                                                            child: Text(
                                                              timeAgo.format(
                                                                  messages[index]
                                                                      .timestamp
                                                                      .toDate()),
                                                              style: GoogleFonts
                                                                  .openSans(),
                                                            ),
                                                          )
                                                        : Container(),
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          size.height * 0.01),
                                                      child: ConstrainedBox(
                                                        constraints: BoxConstraints(
                                                            maxWidth:
                                                                size.width *
                                                                    0.6,
                                                            maxHeight:
                                                                size.height *
                                                                    0.5),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      backgroundColor),
                                                              borderRadius: BorderRadius
                                                                  .circular(size
                                                                          .height *
                                                                      0.02)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    size.height *
                                                                        0.02),
                                                            child: PhotoWidget(
                                                              photoLink:
                                                                  messages[index]
                                                                      .photoUrl,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    messages[index].senderId ==
                                                            widget
                                                                .currentUser.uid
                                                        ? SizedBox()
                                                        : Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        size.height *
                                                                            0.01),
                                                            child: Text(
                                                              timeAgo.format(
                                                                  messages[index]
                                                                      .timestamp
                                                                      .toDate()),
                                                              style: GoogleFonts
                                                                  .openSans(),
                                                            ),
                                                          )
                                                  ],
                                                ),
                                              ),
                                        messages[index].isSend?Container():Text("Loading")
                                      ],
                                    );
                          },
                        )),



                Container(
                  margin: EdgeInsets.only(bottom: 5,left: 5,right: 5),
                  padding: EdgeInsets.only(right: 10,left: 10),
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Color(0xff18516E),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: ()async{
                          FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);

                          if(result != null) {
                            File(result.files.single.path);
                            DocumentReference messageRef= _messagingRepository.getMessageRef();


                            Message message=Message(
                              uid: messageRef.id,
                              text: null,
                              senderName: widget.currentUser.name,
                              senderId: widget.currentUser.uid,
                              photo: File(result.files.single.path),
                              selectedUserId: widget.selectedUser.uid,
                              isSend: false,
                              timestamp: Timestamp.fromDate(DateTime.now())
                            );
                            setState(() {
                              messages.add(message);
                            });

                            _messagingBloc.add(SendMessageEvent(
                              message: message,documentReference: messageRef
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
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xff18516E),
                              borderRadius: BorderRadius.circular(size.height*0.04),
                            ),
                            child: TextField(

                              controller: _messageTextController,
                              textInputAction: TextInputAction.send,
                              maxLines: null,
                              style:GoogleFonts.openSans(color: Colors.white,fontWeight: FontWeight.w600) ,
                              decoration:InputDecoration(

                                  border: InputBorder.none,
                                hintText: "Message ....",
                                hintStyle: GoogleFonts.openSans(color: Colors.white,fontWeight: FontWeight.w600),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor:Colors.white,
                              textCapitalization: TextCapitalization.sentences,
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
  Future<Message>getDetails (String id)async{
    Message message;

    message=await _messagingRepository.getMessageDetail(messageId: id);
    return message;
  }
}
