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
  final String email;
  final String phoneNumber;
  final String snapchat;
  final String facebook;
  final String instagram;
  final String twitter;

  const UserGetDataChanged({this.username, this.email, this.phoneNumber,
    this.snapchat, this.facebook, this.instagram, this.twitter});

  @override
  List<Object> get props => [username, email, phoneNumber, snapchat, facebook, instagram, twitter];

  @override
  String toString() =>
      'DataChanged { username :$username, email :$email, phone number :$phoneNumber,'
          'snapchat :$snapchat, facebook :$facebook, instagram :$instagram, twitter: $twitter }';
}

class UserGetDataSubmitted extends UserGetDataEvent {
  final String username;
  final String email;
  final String phoneNumber;
  final String snapchat;
  final String facebook;
  final String instagram;
  final String twitter;
  final String displayName;
  final String uid;

  const UserGetDataSubmitted({@required this.uid,
    @required this.displayName,
    @required this.username,
    @required this.email,
    @required this.phoneNumber,
    @required this.snapchat,
    @required this.facebook,
    @required this.instagram,
    @required this.twitter});

  @override
  List<Object> get props => [username, email, phoneNumber, snapchat, facebook,
    instagram, twitter, uid, displayName];

  @override
  String toString() {
    return 'Submitted { displayName: $displayName, username: $username, uid: $uid,'
        'email: $email, phone number: $phoneNumber, snapchat: $snapchat, facebook: $facebook, '
        'instagram: $instagram, twitter: $twitter}';
  }
}

class UserGetDataWithGooglePressed extends UserGetDataEvent {}

class UserGetDatawithFacebookPressed extends UserGetDataEvent {}
