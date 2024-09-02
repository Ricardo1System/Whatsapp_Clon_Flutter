part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}


class GetChatsHome extends ChatEvent {}
class GetChatBody extends ChatEvent {
  final String chatId;

  GetChatBody({required this.chatId});
}
