import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isSuccess;
  final bool isFailure;
  final bool isEmailAlreadyExistsFailure;
  final bool supportsAppleSignIn;

  LoginState(
      {@required this.isSuccess,
      @required this.isFailure,
      @required this.isEmailAlreadyExistsFailure,
      @required this.supportsAppleSignIn});

  factory LoginState.empty() {
    {
      return LoginState(
          isSuccess: false,
          isFailure: false,
          isEmailAlreadyExistsFailure: false,
          supportsAppleSignIn: false);
    }
  }

  LoginState emailAlreadyExists() {
    return copyWith(
        isSuccess: false, isFailure: false, isEmailAlreadyExistsFailure: true);
  }

  LoginState failure() {
    return copyWith(
        isSuccess: false, isFailure: true, isEmailAlreadyExistsFailure: false);
  }

  LoginState success() {
    return copyWith(
        isSuccess: true, isFailure: false, isEmailAlreadyExistsFailure: false);
  }

  LoginState update(
      {bool isSuccess,
      bool isFailure,
      bool isEmailAlreadyExistsFailure,
      bool supportsAppleSignIn}) {
    print("supportsApple $supportsAppleSignIn");
    return copyWith(
        isSuccess: isSuccess,
        isFailure: isFailure,
        isEmailAlreadyExistsFailure: isEmailAlreadyExistsFailure,
        supportsAppleSignIn: supportsAppleSignIn);
  }

  LoginState copyWith(
      {bool isSuccess,
      bool isFailure,
      bool isEmailAlreadyExistsFailure,
      bool supportsAppleSignIn}) {
    return LoginState(
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
        isEmailAlreadyExistsFailure:
            isEmailAlreadyExistsFailure ?? this.isEmailAlreadyExistsFailure,
        supportsAppleSignIn: supportsAppleSignIn ?? this.supportsAppleSignIn);
  }

  @override
  String toString() {
    return '''LoginState {
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isEmailAlreadyExistsFailure: $isEmailAlreadyExistsFailure
      supportsAppleSignIn: $supportsAppleSignIn
    }''';
  }
}
