import 'package:equatable/equatable.dart';
import 'package:fastswap/usersLib/users_repository.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersLoading extends UsersState {}

class UserInfoLoaded extends UsersState {
  final String uid;
  final User userInfo;

  const UserInfoLoaded(this.uid, this.userInfo);

  @override
  List<Object> get props => [uid, userInfo];

  @override
  String toString() => 'UserInfoLoaded { userInfo: $userInfo, uid: $uid}';
}

class UsersNotLoaded extends UsersState {}
