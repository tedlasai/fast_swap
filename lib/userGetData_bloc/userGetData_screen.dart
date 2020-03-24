import 'package:fastswap/screens/GetDataFormFrontScreen.dart';
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

class UserGetDataScreen extends StatefulWidget {
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

  State<UserGetDataScreen> createState() => _UserGetDataScreenState();
}

class _UserGetDataScreenState extends State<UserGetDataScreen> {
  String uid;
  String displayName;
  FirebaseUsersRepository firebaseUsersRepository;

  @override
  void initState() {
    super.initState();
    uid = widget._uid;
    displayName = widget._displayName;
    firebaseUsersRepository = widget._firebaseUsersRepository;
    BlocProvider.of<UsersBloc>(context).add(LoadUser(uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserGetDataBloc, UserGetDataState>(
        builder: (context, state) {
          if (state.hasLoadedUser) {
            if (state.hasUserData) {
              return HomeScreen(
                displayName: displayName,
                uid: uid,
              );
            } else {
              return GetDataFormFrontScreen(
                uid: uid,
                displayName: displayName,
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
    );
  }
}
