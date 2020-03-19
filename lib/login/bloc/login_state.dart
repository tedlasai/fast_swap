import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isSuccess;
  final bool isFailure;
  final bool isEmailAlreadyExistsFailure;

  LoginState({
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isEmailAlreadyExistsFailure,
  });

  factory LoginState.empty() {
    return LoginState(
        isSuccess: false, isFailure: false, isEmailAlreadyExistsFailure: false);
  }

  factory LoginState.emailAlreadyExists() {
    return LoginState(
        isSuccess: false, isFailure: false, isEmailAlreadyExistsFailure: true);
  }

  factory LoginState.failure() {
    return LoginState(
        isSuccess: false, isFailure: true, isEmailAlreadyExistsFailure: false);
  }

  factory LoginState.success() {
    return LoginState(
        isSuccess: true, isFailure: false, isEmailAlreadyExistsFailure: false);
  }

  @override
  String toString() {
    return '''LoginState {
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isEmailAlreadyExistsFailure: $isEmailAlreadyExistsFailure
    }''';
  }
}
