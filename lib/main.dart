import 'package:connectivity/connectivity.dart';
import 'package:fastswap/displayUserData_bloc/displayUserData.dart';
import 'package:fastswap/internetConnectivity_bloc/internetConnectivity.dart';
import 'package:fastswap/qrcodegen_bloc/qrcodegen.dart';
import 'package:fastswap/search_bloc/search.dart';
import 'package:fastswap/widgets/showAlertDialog.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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

  final Connectivity internetConnectivity = Connectivity();
  runApp(
    App(
        userRepository: userRepository,
        firebaseUsersRepository: firebaseUsersRepository,
        internetConnectivity: internetConnectivity),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;
  final FirebaseUsersRepository _firebaseUsersRepository;
  final Connectivity _internetConnectivity;

  App(
      {Key key,
      @required UserRepository userRepository,
      @required FirebaseUsersRepository firebaseUsersRepository,
      @required Connectivity internetConnectivity})
      : assert(userRepository != null),
        assert(firebaseUsersRepository != null),
        _firebaseUsersRepository = firebaseUsersRepository,
        _userRepository = userRepository,
        _internetConnectivity = internetConnectivity,
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
          BlocProvider<QrCodeGenBloc>(create: (context) => QrCodeGenBloc()),
          BlocProvider<SearchBloc>(
              create: (context) =>
                  SearchBloc(usersRepository: _firebaseUsersRepository)
                    ..add(SearchStarted())),
          BlocProvider<DisplayUserDataBloc>(
              create: (context) => DisplayUserDataBloc(
                  usersRepository: _firebaseUsersRepository)),
          BlocProvider<UsersBloc>(
            create: (context) {
              return UsersBloc(
                usersRepository: _firebaseUsersRepository,
              );
            },
          ),
          BlocProvider<InternetConnectivityBloc>(
            create: (context) => InternetConnectivityBloc(
                internetConnectivity: _internetConnectivity)
              ..add(InternetConnectivityStarted()),
          ),
        ],
        child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: MaterialApp(
                home: MultiBlocListener(
              listeners: [
                BlocListener<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                  if (state is Unauthenticated) {
                    BlocProvider.of<UserGetDataBloc>(context)
                        .add(UserGetDataUninitialized());
                  } else if (state is Authenticated) {
                    BlocProvider.of<UserGetDataBloc>(context)
                        .add(UserGetDataStart(
                      uid: state.uid,
                    ));
                  }
                  /*if (internetConnectivityState is NoConnection) {
                    showAlertDialog(context, "No Internet Connection",
                        "Please Check your Internet Conenction");
                  }*/
                }),
                BlocListener<InternetConnectivityBloc,
                        InternetConnectivityState>(
                    listener: (context, state) async {
                  if (state is NoConnection || state is InternetUninitialized) {
                    showAlertDialog(context, "No Internet Connection",
                        "Please Check your Internet Conenction");
                  }
                })
              ],
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
            ))));
  }
}
