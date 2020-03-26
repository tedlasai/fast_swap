import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitialize extends LoginEvent {}

class LoginWithGooglePressed extends LoginEvent {}

class LoginwithFacebookPressed extends LoginEvent {}

class LoginWithApplePressed extends LoginEvent {}
