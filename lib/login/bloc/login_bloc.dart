import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fastswap/login/login.dart';
import 'package:fastswap/user_repository.dart';
import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;
import 'package:fastswap/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository {}

  @override
  LoginState get initialState {
    return LoginState.empty();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInitialize) {
      yield* _mapLoginInitializeToState();
    } else if (event is LoginwithFacebookPressed) {
      yield* _mapLoginWithFacebookPressedToState();
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithApplePressed) {
      yield* _mapLoginWithApplePressedToState();
    }
  }

  Stream<LoginState> _mapLoginInitializeToState() async* {
    bool supportsAppleSignIn = false;
    print("HERE");
    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var version = iosInfo.systemVersion;

      if (version.contains('13') == true) {
        supportsAppleSignIn = true;
      }
    }
    print("MADE IT OUT $supportsAppleSignIn");
    yield state.update(supportsAppleSignIn: supportsAppleSignIn);
    print(state);
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _userRepository.signInWithGoogle();
      yield state.success();
    } catch (_) {
      yield state.failure();
    }
  }

  Stream<LoginState> _mapLoginWithApplePressedToState() async* {
    try {
      await _userRepository.signInWithApple();
      print("HI SIGNED IN WITH APPLE");
      yield state.success();
    } catch (_) {
      yield state.failure();
    }
  }

  Stream<LoginState> _mapLoginWithFacebookPressedToState() async* {
    try {
      await _userRepository.signInWithFacebook();
      yield state.success();
    } on PlatformException catch (e) {
      if (e.code == "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL") {
        yield state.emailAlreadyExists();
      } else {
        throw (e);
      }
    } catch (_) {
      print(_);
      yield state.failure();
    }
  }
}
