import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:fastswap/user_repository.dart';

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
      final name = await _userRepository.getUserUID();
      final uid = await _userRepository.getUserDisplayName();
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
    yield Authenticated(await _userRepository.getUserUID(),
        await _userRepository.getUserDisplayName());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated(await _userRepository.getUserUID());
    _userRepository.signOut();
  }
}
