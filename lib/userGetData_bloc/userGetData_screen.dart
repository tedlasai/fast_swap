import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastswap/authentication_bloc/authentication_bloc.dart';
import 'package:fastswap/user_repository.dart';
import 'package:fastswap/screens/home_screen.dart';
import 'package:fastswap/login/login.dart';
import 'package:fastswap/screens/splash_screen.dart';
import 'package:fastswap/simple_bloc_delegate.dart';
import 'package:fastswap/userGetData_bloc/userGetData.dart';
import 'package:fastswap/usersLib/users_repository.dart';
import 'package:fastswap/users_bloc/users.dart';

import 'package:fastswap/screens/emptyloading_screen.dart';
import 'package:fastswap/screens/loadinghome_screen.dart';
import 'package:fastswap/screens/splash_screen.dart';

class UserGetDataScreen extends StatelessWidget {
  final String _uid;
  final String _displayName;
  final FirebaseUsersRepository _firebaseUsersRepository;

  UserGetDataScreen(
      {Key key,
      @required String uid,
      @required String displayName,
      @required FirebaseUsersRepository firebaseUsersRepository})
      : assert(uid != null),
        assert(displayName != null),
        assert(firebaseUsersRepository != null),
        _uid = uid,
        _displayName = displayName,
        _firebaseUsersRepository = firebaseUsersRepository,
        super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<UsersBloc>(
            create: (context) {
              return UsersBloc(
                usersRepository: _firebaseUsersRepository,
              )..add(LoadUser(_uid));
            },
          )
        ],
        child: Scaffold(
          body: BlocBuilder<UserGetDataBloc, UserGetDataState>(
            builder: (context, state) {
              if (state.hasLoadedUser) {
                if (state.hasUserData) {
                  return HomeScreen(
                    displayName: _displayName,
                    uid: _uid,
                  );
                } else {
                  return UserGetDataForm(
                    uid: _uid,
                  );
                }
              } else if (state.isFailure) {
                return LoadingHomeScreen();
              } else if (state.isSuccess) {
                return LoadingHomeScreen();
              } else {
                return EmptyLoadingScreen();
              }
            },
          ),
        ));
  }
}
