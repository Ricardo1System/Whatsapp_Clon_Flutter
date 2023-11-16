import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp_clone/models/user/user_dto.dart';
import 'package:whatsapp_clone/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<GetInformationProfile>(
      (event, emit) => getInformationProfile(event, emit),
    );
  }
final UserRepository userRepository;

   Future<void> getInformationProfile(
      GetInformationProfile event, Emitter<UserState> emit) async {
    emit(GetInformationLoading());
    try {
      var result = userRepository.getInformationProfile();
      if (result != null) {
        // emit(GetInformationLoaded(user: result));
      }
    } catch (e) {}
  }
}
