import 'package:equatable/equatable.dart';
import 'package:fastswap/usersLib/users_repository.dart';

abstract class DisplayUserDataState extends Equatable {
  const DisplayUserDataState(this.hasUser, this.data);

  final bool hasUser;
  final User data;

  @override
  List<Object> get props => [hasUser, data];

  @override
  String toString() => 'DisplayUserDataState { hasUser: $hasUser, data:$data }';
}

class HasUserData extends DisplayUserDataState {
  const HasUserData(data) : super(true, data);

  @override
  String toString() => 'HasUserData { hasUser: $hasUser, data:$data }';
}

class NoUserData extends DisplayUserDataState {
  NoUserData() : super(false, User(uid: ""));

  ///CHANGED SOMETHING EHRE IF IT BREAKS REMOVE THE QUOTES
}
