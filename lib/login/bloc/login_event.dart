import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}



class LoginWithGooglePressed extends LoginEvent {}
class LoginwithFacebookPressed extends LoginEvent {}


