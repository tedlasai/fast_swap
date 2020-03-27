import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastswap/tab/app_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:fastswap/user_repository.dart';
import 'package:fastswap/tab/bloc/tab.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      final name = await _userRepository.getUserDisplayName();
      final uid = await _userRepository.getUserUID();
      if (isSignedIn) {
        yield Authenticated(name, uid);
      } else {
        yield Unauthenticated(uid);
      }
    } catch (_) {
      yield Unauthenticated("");
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(
      await _userRepository.getUserDisplayName(),
      await _userRepository.getUserUID(),
    );
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated(await _userRepository.getUserUID());
    _userRepository.signOut();
  }
}
