import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/models/message.dart';
import 'package:zoodja/repositories/messaging.dart';

import "package:timeago/timeago.dart" as  timeAgo;
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/widgets/photo.dart';
import 'package:zoodja/ui/widgets/photoLink.dart';

class MessageWidget extends StatefulWidget {
  final String messageId,currentUserId;

  const MessageWidget({ this.messageId, this.currentUserId}) ;

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  MessagingRepository _messagingRepository =MessagingRepository();
  Message _message;

  Future getDetails()async{
    _message=await _messagingRepository.getMessageDetail(messageId: widget.messageId);
    return _message;
  }
bool show=false;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return FutureBuilder(
        future: getDetails(),
        builder: (context, snapshot) {
          // print(snapshot.hasData);
          if(!snapshot.hasData){
            return Container();
          }
          else{
            _message=snapshot.data;
            return Column(
              crossAxisAlignment: _message.senderId==widget.currentUserId?CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
              _message.text!=null?Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: _message.senderId==widget.currentUserId?CrossAxisAlignment.end:CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(size.height*0.01),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: size.width*0.7,
                          ),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                show=!show;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: _message.senderId==widget.currentUserId?Color(0xffFE3C72):Color(0xffE6DEEF),
                                borderRadius: _message.senderId==widget.currentUserId?BorderRadius.only(
                                  topLeft: Radius.circular(size.height*0.02),
                                  bottomRight: Radius.circular(size.height*0.02),
                                  bottomLeft: Radius.circular(size.height*0.02),
                                ):
                                BorderRadius.only(
                                  bottomLeft: Radius.circular(size.height*0.02),
                                  topRight: Radius.circular(size.height*0.02),
                                  bottomRight : Radius.circular(size.height*0.02),
                                )
                              ),
                              padding: EdgeInsets.all(size.height*0.015),
                              child: Text(_message.text,style: GoogleFonts.openSans(color:
                              _message.senderId==widget.currentUserId?Colors.white
                                  :Color(0xff18516E)),),
                            ),
                          ),
                        ),
                      ),
                      _message.senderId==widget.currentUserId?
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                          height: show==true?20:0,
                          child: Text(timeAgo.format(_message.timestamp.toDate()),style: GoogleFonts.openSans(fontSize: 12),))
                          : AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: show==true?20:0,
                          child: Text(timeAgo.format(_message.timestamp.toDate()),style: GoogleFonts.openSans(fontSize: 12),))

                    ],
                  ),

                ],
              )
                  :GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoLink(url: _message.photoUrl,),));
                },
                    child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                children: [
                    _message.senderId==widget.currentUserId?Padding(
                      padding: EdgeInsets.symmetric(vertical: size.height*0.01),
                      child: Text(timeAgo.format(_message.timestamp.toDate()),style: GoogleFonts.openSans(),),
                    ):Container(),
                    Padding(
                      padding: EdgeInsets.all( size.height*0.01),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: size.width*0.6,
                          maxHeight: size.height*0.5
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: backgroundColor),
                            borderRadius: BorderRadius.circular(size.height*0.02)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(size.height*0.02),
                            child: PhotoWidget(photoLink: _message.photoUrl,),
                          ),
                        ),
                      ),
                    ),
                    _message.senderId==widget.currentUserId
                        ?SizedBox()
                        :Padding(
                      padding: EdgeInsets.symmetric(vertical: size.height*0.01),
                      child: Text(timeAgo.format(_message.timestamp.toDate()),style: GoogleFonts.openSans(),),
                    )
                ],
              ),
                  ),
                SizedBox(height: 10,)
              ],
            );
          }
        },

    );
  }
}
