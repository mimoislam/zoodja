import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/models/chat.dart';
import 'package:zoodja/models/message.dart';
import 'package:zoodja/models/user.dart';
import 'package:zoodja/repositories/messageRepository.dart';
import 'package:zoodja/ui/pages/messaging.dart';
import 'package:zoodja/ui/widgets/pageTurn.dart';
import 'package:zoodja/ui/widgets/photo.dart';
import "package:timeago/timeago.dart" as  timeAgo;
class ChatWidget extends StatefulWidget {

  final String userId,selectedUserId;
  final Timestamp creationTime;

  const ChatWidget({ this.userId, this.selectedUserId, this.creationTime}) ;

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  MessageRepository messageRepository=MessageRepository();
  Chat chat;
  User user;

  getUserDetail()async{
    user=await messageRepository.getUserDetails(widget.selectedUserId);
    Message message=await messageRepository.
    getLastMessage(currentUserId: widget.userId,selectedUserId: widget.selectedUserId).catchError((error){
      print(error);
    });
    if (message ==null){
      return Chat(
        name: user.name,
        photoUrl: user.photo,
        lastMessage: null,
        lastMessagePhoto: null,
        timestamp: null
      );
    }else{
      return Chat(
          name: user.name,
          photoUrl: user.photo,
          lastMessage: message.text,
          lastMessagePhoto: message.photoUrl,
          timestamp: message.timestamp,
          lastMessageSenderId: message.selectedUserId,
          viewed: message.viewed
      );
    }
  }

  opeChat()async{
    User currentUser=await messageRepository.getUserDetails(widget.userId);
    User selectedUser=await messageRepository.getUserDetails(widget.selectedUserId);
    try{
      pageTurn(Messaging(
        currentUser: currentUser,
        selectedUser: selectedUser,

      ), context);

    }
    catch (e){
      print(e.toString());
    }
  }
  deleteChat()async{
      await messageRepository.deleteChat(selectedUserId: widget.selectedUserId,currentUserId: widget.userId);

  }
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return FutureBuilder(
      future: getUserDetail(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Container();
        }
        else{
           chat =snapshot.data;
          return GestureDetector(
            onTap: ()async{
              await opeChat();
            },
            onLongPress: (){
              showDialog(context: context, builder: (context) =>AlertDialog(
                content: Wrap(
                  children: [
                    Text("Do you want to delete this chat ?",style:  GoogleFonts.openSans(
                      fontWeight: FontWeight.bold
                    ),),

                    Text("This action is irreversible",style:  GoogleFonts.openSans(
                        fontWeight: FontWeight.w600
                    ),)
                  ],
                ),actions: [
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text(
                    "No",style:  GoogleFonts.openSans(
                      color:Colors.blue,
                  ),
                  )),
                TextButton(onPressed: ()async{
                  await deleteChat();
                  Navigator.of(context).pop();
                }, child: Text(
                  "Yes",style:  GoogleFonts.openSans(
                  color:Colors.red,
                ),
                )),
              ],
              ),);
            },
            child: Padding(
              padding: EdgeInsets.all(size.height*0.02),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  color:(!chat.viewed)&&(widget.userId!=chat.lastMessageSenderId)?Colors.grey[200]:Colors.transparent,
                  borderRadius: BorderRadius.circular(size.height*0.02),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 75,
                            width:75,
                            child: PhotoWidget(
                              photoLink: user.photo,
                            ),
                          ),
                        ),
                        SizedBox(width: size.width*0.02,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name,style: GoogleFonts.openSans(
                              color: Color(0xff18516E),
                              fontSize: (!chat.viewed)&&(widget.userId!=chat.lastMessageSenderId)?18:15,
                              fontWeight: (!chat.viewed)&&(widget.userId!=chat.lastMessageSenderId)?FontWeight.bold:FontWeight.w700
                            ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            chat.lastMessage!=null?Text(chat.lastMessage,overflow: TextOverflow.fade,style: GoogleFonts.openSans(
                              color:Color(0xff18516E),
                                fontWeight: (!chat.viewed)&&(widget.userId!=chat.lastMessageSenderId)?FontWeight.w500:FontWeight.w300
                            ),)
                                :chat.lastMessagePhoto==null
                                ?Text("Chat Room available",style: GoogleFonts.openSans(
                                color:Colors.grey,
                                fontSize: size.height*0.02
                            ))
                                :Row(children: [
                                  Icon(Icons.photo,color: Colors.grey,size: size.height*0.02,),
                                  Text("Photo",style: GoogleFonts.openSans(
                                    color:Colors.grey,
                                    fontSize: size.height*0.015
                                  ),)
                            ],)

                          ],
                        )
                      ],
                    ),
                    chat.timestamp!=null?Text(
                        timeAgo.format(chat.timestamp.toDate())
                    ):Text(  timeAgo.format(widget.creationTime.toDate()))
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
