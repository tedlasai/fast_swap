import 'package:equatable/equatable.dart';
import 'package:fastswap/usersLib/users_repository.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersLoading extends UsersState {}

class UserInfoLoaded extends UsersState {
  final Map<String, Object> userInfo;

  const UserInfoLoaded(this.userInfo);

  @override
  List<Object> get props => [userInfo];

  @override
  String toString() => 'UserInfoLoaded { userInfo: $userInfo }';
}

class UsersNotLoaded extends UsersState {}
