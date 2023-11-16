part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}


class Auth extends AuthEvent {
  
  
}

class SetCode extends AuthEvent {
  final String smsCode;
  SetCode({required this.smsCode,});
}
class SendCode extends AuthEvent {
  // final String code;
  final String number;
  SendCode({required this.number});
  // SendCode({required this.number ,required this.code});
}
