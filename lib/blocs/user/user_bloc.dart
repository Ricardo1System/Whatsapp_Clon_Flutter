
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp_clone/models/user/user_dto.dart';
import 'package:whatsapp_clone/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<GetProfile>((event, emit) => getProfile(event, emit),);
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final UserRepository userRepository;

  Future<void> getProfile(GetProfile event, Emitter<UserState> emit) async {
    emit(GetInformationLoading());
    try {
      User user = FirebaseAuth.instance.currentUser!;
      String uid = user.uid;
      DocumentSnapshot userSnapshot = await users.doc(uid).get();

        // Verificar si el documento existe antes de acceder a sus datos
    if (userSnapshot.exists) {
      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;
      UserDto user = UserDto.fromJson(userData!);
      emit(GetInformationLoaded(user: user));
    } else {
      print('El usuario no existe en Firestore.');
    }
  } catch (e) {
    print('Error al obtener datos desde Firebase: $e');
  }
  }
}
