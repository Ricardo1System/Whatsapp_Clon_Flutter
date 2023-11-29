import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp_clone/models/contact/contact_dto.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<GetChatsHome>((event, emit) => _getChatsHome(event, emit));
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> _getChatsHome(GetChatsHome event, Emitter<ChatState> emit) async {
    List<ContactDto> contactChats = [];
    emit(GetChatsLoading());
    try {
      User user = FirebaseAuth.instance.currentUser!;
      String uid = user.uid;
      // QuerySnapshot<Object?> chatSnapshot =
      //     await chats.where('participants', arrayContains: uid).get();
      // // Itera sobre los documentos en el resultado de la consulta
      // for (QueryDocumentSnapshot document in chatSnapshot.docs) {
      //   // Accede a los datos del documento
      //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      // }
      DocumentSnapshot userSnapshot = await users.doc(uid).get();

      // Verificar si el documento existe antes de acceder a sus datos
      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;
        for (var ele in userData!["chats"]) {
          contactChats.add(ContactDto.fromJson(ele));
        }
        emit(GetChatsLoaded(contactChats: contactChats));
      }
    } catch (e) {
      emit(GetChatsError());
    }
  }
}
