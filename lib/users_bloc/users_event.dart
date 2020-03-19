import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fastswap/usersLib/users_repository.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UsersEvent {
  final String uid;

  const LoadUser(this.uid);

  @override
  String toString() => 'LoadUser { uid :$uid }';
}

class AddUser extends UsersEvent {
  final User user;

  const AddUser(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'AddUser { user: $user }';
}

class UpdateUser extends UsersEvent {
  final User updatedUser;

  const UpdateUser(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];

  @override
  String toString() => 'UpdateUser { updatedUser: $updatedUser }';
}

class DeleteUser extends UsersEvent {
  final User user;

  const DeleteUser(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'DeleteUser { user: $user }';
}

class UsersInfoUpdated extends UsersEvent {
  final Map<String, Object> userInfo;

  const UsersInfoUpdated(this.userInfo);

  @override
  List<Object> get props => [userInfo];
}
