import 'package:fastswap/search_bloc/search.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastswap/authentication_bloc/authentication_bloc.dart';
import 'package:fastswap/tab/bloc/tab_bloc.dart';
import 'package:fastswap/user_repository.dart';
import 'package:fastswap/screens/home_screen.dart';
import 'package:fastswap/login/login.dart';
import 'package:fastswap/screens/splash_screen.dart';
import 'package:fastswap/simple_bloc_delegate.dart';
import 'package:fastswap/userGetData_bloc/userGetData.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastswap/users_bloc/users.dart';
import 'package:fastswap/usersLib/users_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  final FirebaseUsersRepository firebaseUsersRepository =
      FirebaseUsersRepository();
  runApp(
    App(
      userRepository: userRepository,
      firebaseUsersRepository: firebaseUsersRepository,
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;
  final FirebaseUsersRepository _firebaseUsersRepository;

  App(
      {Key key,
      @required UserRepository userRepository,
      @required FirebaseUsersRepository firebaseUsersRepository})
      : assert(userRepository != null),
        assert(firebaseUsersRepository != null),
        _firebaseUsersRepository = firebaseUsersRepository,
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) {
              return AuthenticationBloc(
                userRepository: _userRepository,
              )..add(AppStarted());
            },
          ),
          BlocProvider<UserGetDataBloc>(
            create: (context) =>
                UserGetDataBloc(usersRepository: _firebaseUsersRepository)
                  ..add(UserGetDataUninitialized()),
          ),
          BlocProvider<TabBloc>(create: (context) => TabBloc()),
          BlocProvider<SearchBloc>(
              create: (context) =>
                  SearchBloc(usersRepository: _firebaseUsersRepository)
                    ..add(SearchStarted()))
        ],
        child: MaterialApp(
            home: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              BlocProvider.of<UserGetDataBloc>(context)
                  .add(UserGetDataUninitialized());
            } else if (state is Authenticated) {
              BlocProvider.of<UserGetDataBloc>(context).add(UserGetDataStart(
                uid: state.uid,
              ));
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is Unauthenticated) {
                return LoginScreen(userRepository: _userRepository);
              }
              if (state is Authenticated) {
                return UserGetDataScreen(
                  uid: state.uid,
                  displayName: state.displayName,
                  firebaseUsersRepository: _firebaseUsersRepository,
                );
              }
              return SplashScreen();
            },
          ),
        )));
  }
}
