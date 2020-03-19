import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UserGetDataEvent extends Equatable {
  @override
  const UserGetDataEvent();

  List<Object> get props => [];
}

class UserGetDataUninitialized extends UserGetDataEvent {}

class UserGetDataStart extends UserGetDataEvent {
  final String uid;

  const UserGetDataStart(this.uid);

  @override
  String toString() => 'UserGetDataStart { uid :$uid }';
}

class UserGetDataUsernameChanged extends UserGetDataEvent {
  final String username;

  const UserGetDataUsernameChanged({@required this.username});

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'UsernameChanged { username :$username }';
}

class UserGetDataSubmitted extends UserGetDataEvent {
  final String username;
  final String uid;

  const UserGetDataSubmitted({@required this.username, @required this.uid});

  @override
  List<Object> get props => [username, uid];

  @override
  String toString() {
    return 'Submitted { username: $username, uid: $uid}';
  }
}

class UserGetDataWithGooglePressed extends UserGetDataEvent {}

class UserGetDatawithFacebookPressed extends UserGetDataEvent {}
