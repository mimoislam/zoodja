import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:zoodja/repositories/messageRepository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
   MessageRepository _messageRepository;
  MessageBloc({@required MessageRepository messageRepository }):
        assert(messageRepository!=null),
        _messageRepository=messageRepository, super(MessageInitialState());
   MessageState get initialState => MessageInitialState();



  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    if(event is ChatStreamEvent){
      yield* _mapChatStreamToState(currentUserId:event.currentUserId);
    }
  }

 Stream<MessageState> _mapChatStreamToState({String currentUserId})async* {
    yield ChatLoadingState();
    Stream<QuerySnapshot> chatStream=_messageRepository.getChats(userId: currentUserId);
    yield ChatLoadedState(chatStream: chatStream);
  }
}
