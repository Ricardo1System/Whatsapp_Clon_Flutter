part of 'contact_bloc.dart';

@immutable
sealed class ContactState {}

final class ContactInitial extends ContactState {}


class GetContactsLoading extends ContactState {
  
}
class GetContactsLoaded extends ContactState {
  final List<ContactDto> userList;

  GetContactsLoaded({required this.userList});
}
class GetContactsError extends ContactState {
  final String error;

  GetContactsError({required this.error});
}
