import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fastswap/login/login.dart';
import 'package:fastswap/user_repository.dart';
import 'package:fastswap/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginwithFacebookPressed) {
      yield* _mapLoginWithFacebookPressedToState();
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _userRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithFacebookPressedToState() async* {
    try {
      await _userRepository.signInWithFacebook();
      yield LoginState.success();
    } on PlatformException catch (e) {
      if (e.code == "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL") {
        yield LoginState.emailAlreadyExists();
      } else {
        throw (e);
      }
    } catch (_) {
      print(_);
      yield LoginState.failure();
    }
  }
}
