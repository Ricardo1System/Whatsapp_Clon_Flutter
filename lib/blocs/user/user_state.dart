part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}
class GetInformationLoading extends UserState {}
class GetInformationLoaded extends UserState {
  UserDto user;
  GetInformationLoaded({required this.user});

  List<Object> get props =>[user];
}
class ErrorStatus extends UserState {}