part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String uid;
  final String displayName;

  const Authenticated(this.uid, this.displayName);

  @override
  List<Object> get props => [uid, displayName];

  @override
  String toString() => 'Authenticated { uid: $uid, displayName:$displayName }';
}

class Unauthenticated extends AuthenticationState {
  final String uid;

  const Unauthenticated(this.uid);
}
