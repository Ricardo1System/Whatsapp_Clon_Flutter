part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}


class GetChatsLoading extends ChatState {}
class GetChatsLoaded extends ChatState {
  final List<ContactDto> contactChats;
  GetChatsLoaded({required this.contactChats});
}
class GetChatsError extends ChatState {}
