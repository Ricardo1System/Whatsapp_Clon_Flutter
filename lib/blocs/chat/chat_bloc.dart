import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp_clone/models/chat/chat_dto.dart';
import 'package:whatsapp_clone/services/firebase/chat_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<GetChatsHome>((event, emit) => _getChatsHome(event, emit));
    on<GetChatBody>((event, emit) => _getChatBody(event, emit));
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final ChatService _chatService = ChatService();

  Future<void> _getChatsHome(GetChatsHome event, Emitter<ChatState> emit) async {
    List<ChatDto> contactChats = [];
    emit(GetChatsLoading());
    try {
      User user = FirebaseAuth.instance.currentUser!;
      String uid = user.uid;
      DocumentSnapshot userSnapshot = await users.doc(uid).get();

      // Verificar si el documento existe antes de acceder a sus datos
      if (userSnapshot.exists) {
        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;
        for (var ele in userData!["chats"]) {
          contactChats.add(ChatDto.fromJson(ele));
        }
        emit(GetChatsLoaded(contactChats: contactChats));
      }
    } catch (e) {
      emit(GetChatsError());
    }
  }
  
  Future<void> _getChatBody(GetChatBody event, Emitter<ChatState> emit) async {
    
    _chatService.getChatBody(event.chatId);
  }
}
