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

  const UserGetDataStart({
    @required this.uid,
  });

  @override
  String toString() => 'UserGetDataStart { uid :$uid}';

  @override
  List<Object> get props => [uid];
}

class UserGetDataChanged extends UserGetDataEvent {
  final String username;
  final String twitter;

  const UserGetDataChanged({this.username, this.twitter});

  @override
  List<Object> get props => [username, twitter];

  @override
  String toString() =>
      'DataChanged { username :$username, twitter: $twitter }';
}

class UserGetDataSubmitted extends UserGetDataEvent {
  final String username;
  final String twitter;
  final String displayName;
  final String uid;

  const UserGetDataSubmitted({@required this.username,
    @required this.uid,
    @required this.displayName,
    @required this.twitter});

  @override
  List<Object> get props => [username, twitter, uid, displayName];

  @override
  String toString() {
    return 'Submitted { displayName: $displayName, username: $username, uid: $uid, twitter: $twitter}';
  }
}

class UserGetDataWithGooglePressed extends UserGetDataEvent {}

class UserGetDatawithFacebookPressed extends UserGetDataEvent {}
