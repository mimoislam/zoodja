import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/message/message_bloc.dart';
import 'package:zoodja/repositories/messageRepository.dart';
import 'package:zoodja/ui/widgets/chat.dart';

class Messages extends StatefulWidget {
  final String userId;

  const Messages({ this.userId}) ;

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  MessageRepository messageRepository=MessageRepository();
  MessageBloc _messageBloc;

  @override
  void initState() {
    _messageBloc=MessageBloc(messageRepository: messageRepository);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc,MessageState>(
      bloc: _messageBloc,
      builder: (context,MessageState state) {
      if(state is MessageInitialState){
        _messageBloc
        .add(ChatStreamEvent(currentUserId: widget.userId));
        // return CircularProgressIndicator();
      }
      if(state is ChatLoadingState){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if(state is ChatLoadedState){
        Stream <QuerySnapshot> chatStream=state.chatStream;
        return StreamBuilder(
          stream: chatStream,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Text("No data");
            }
            if((snapshot.data.docs.isNotEmpty)){
              if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),

              );}
              else{
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(userId: widget.userId,
                      creationTime: snapshot.data.docs[index].get("timestamp"),
                      selectedUserId:  snapshot.data.docs[index].id,);
                  },
                );
              }
            }else{
              return Text("You don't have any conversations",style: GoogleFonts.openSans(
                fontSize: 16,fontWeight: FontWeight.bold
              ),);
            }
          } ,

        );
      }
      else
        {
          return Container();
        }

    },);
  }
}
