import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoodja/bloc/message/message_bloc.dart';
import 'package:zoodja/repositories/messageRepository.dart';
import 'package:zoodja/ui/widgets/chat.dart';

class Messages extends StatefulWidget {
  final String userId;
  final MessageRepository messageRepository;
  const Messages({ this.userId,this.messageRepository}) ;

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  MessageRepository messageRepository=MessageRepository();
  MessageBloc _messageBloc;
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    messageRepository=widget.messageRepository;
    _messageBloc=BlocProvider.of<MessageBloc>(context);

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
        return CircularProgressIndicator();
      }
      if(state is ChatLoadingState){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if(state is ChatLoadedState){
        Stream <QuerySnapshot> chatStream=state.chatStream;
        return Padding(
          padding: const EdgeInsets.only(top:0.0,),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: double.infinity,
                height: 50,
                decoration:  BoxDecoration(
                    color: Color(0xff213A50)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("Chat",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.white),),
                        Container(
                          width: 45,
                          height: 3,
                          color: Color(0xff20A39E),
                        )
                      ]
                      ,
                    ),

                  ],
                ),

              ),

              Expanded(
                child: StreamBuilder(
                  stream: chatStream,
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(child: Text("No data"));
                    }
                    if((snapshot.data.docs.isNotEmpty)){
                      if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );}
                      else{

                        return Container(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              print("snapshot.data.docs.length");

                              print(snapshot.data.docs[index].id);
                              return ChatWidget(userId: widget.userId,
                                creationTime: snapshot.data.docs[index].get("timestamp"),
                                selectedUserId:  snapshot.data.docs[index].id,);
                            },
                          ),
                        );
                      }
                     }else{
                      return Center(
                        child: Text("You don't have any conversations",style: GoogleFonts.openSans(
                          fontSize: 16,fontWeight: FontWeight.bold
                        ),),
                      );
                    }
                  } ,

                ),
              ),
            ],
          ),
        );
      }
      else
        {
          return Container();
        }

    },);
  }
}
