import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp_clone/models/contact/contact_dto.dart';
import 'package:whatsapp_clone/services/firebase/users_service.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    on<ContactEvent>((event, emit) {});
    on<GetContactsEvent>((event, emit) => _getContacts(event,emit));
  }

  final UsersService _usersService = UsersService();
  
 Future<void> _getContacts(GetContactsEvent event, Emitter<ContactState> emit) async {
  emit(GetContactsLoading());
  try {
    List<ContactDto> users = await _usersService.getUsersInDb();
    emit(GetContactsLoaded(userList: users));
  } catch (e) {
    emit(GetContactsError(error: e.toString()));
  }
 }
}
