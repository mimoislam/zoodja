import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/models/message.dart';
import 'package:zoodja/repositories/messaging.dart';

import "package:timeago/timeago.dart" as  timeAgo;
import 'package:zoodja/ui/constats.dart';
import 'package:zoodja/ui/widgets/photo.dart';

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
    print( widget.messageId);
    _message=await _messagingRepository.getMessageDetail(messageId: widget.messageId);
    print(_message);
    return _message;
  }

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
                  _message.senderId==widget.currentUserId?Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height*0.01),
                    child:Text(timeAgo.format(_message.timestamp.toDate()),style: GoogleFonts.openSans(),) ,
                  ):Container(),
                  Padding(
                    padding: EdgeInsets.all(size.height*0.01),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: size.width*0.7,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _message.senderId==widget.currentUserId?backgroundColor:Colors.grey[200],
                          borderRadius: _message.senderId==widget.currentUserId?BorderRadius.only(
                            topLeft: Radius.circular(size.height*0.02),
                            topRight: Radius.circular(size.height*0.02),
                            bottomLeft: Radius.circular(size.height*0.02),
                          ):
                          BorderRadius.only(
                            topLeft: Radius.circular(size.height*0.02),
                            topRight: Radius.circular(size.height*0.02),
                            bottomRight : Radius.circular(size.height*0.02),
                          )
                        ),
                        padding: EdgeInsets.all(size.height*0.01),
                        child: Text(_message.text,style: GoogleFonts.openSans(color:
                        _message.senderId==widget.currentUserId?Colors.white
                            :Colors.black),),
                      ),
                    ),
                  ),
                  _message.senderId==widget.currentUserId?
                      SizedBox()
                      :Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height*0.01),
                    child: Text(timeAgo.format(_message.timestamp.toDate()),style: GoogleFonts.openSans(),),
                  )
                ],
              )
                  :Wrap(
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
                  _message.senderId==widget.currentUserId?   SizedBox()
                      :Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height*0.01),
                    child: Text(timeAgo.format(_message.timestamp.toDate()),style: GoogleFonts.openSans(),),
                  )
                ],
              )
              ],
            );
          }
        },

    );
  }
}
