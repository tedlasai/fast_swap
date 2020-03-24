import 'package:fastswap/userGetData_bloc/userGetData.dart';
import 'package:fastswap/users_bloc/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildColumnGetData extends StatefulWidget {
  final String _uid;
  final String _displayName;

  BuildColumnGetData({Key key, @required displayName, @required uid})
      : assert(uid != null),
        _uid = uid,
        _displayName = displayName,
        super(key: key);

  State<BuildColumnGetData> createState() => _BuildColumnGetData();
}

class _BuildColumnGetData extends State<BuildColumnGetData>
    with SingleTickerProviderStateMixin {
  ScrollController _controller;
  String username;

  void initState() {
    super.initState();
    _controller = ScrollController();
    username = "";
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserGetDataBloc, UserGetDataState>(
        builder: (context, state) {
      return BlocBuilder<UsersBloc, UsersState>(
        builder: (context, currentUserState) {
          print(state.instagram);
          if (currentUserState is UserInfoLoaded) {
            username = currentUserState.userInfo.username;
          }

          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Username (required)',
                      ),
                      keyboardType: TextInputType.text,
                      autovalidate: true,
                      autocorrect: false,
                      initialValue: username),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Email (optional)',
                    ),
                    keyboardType: TextInputType.emailAddress,
//                    autovalidate: true,
                    autocorrect: false,
//                    validator: (_) {
//                      return state.isUsernameValid != "VALID"
//                          ? 'Invalid Username'
//                          : null;
//                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Phone Number (optional)',
                    ),
                    keyboardType: TextInputType.number,
//                    autovalidate: true,
                    autocorrect: false,
//                    validator: (_) {
//                      return state.isUsernameValid != "VALID"
//                          ? 'Invalid Username'
//                          : null;
//                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Snapchat (optional)',
                    ),
                    keyboardType: TextInputType.text,
//                    autovalidate: true,
                    autocorrect: false,
//                    validator: (_) {
//                      return state.isUsernameValid != "VALID"
//                          ? 'Invalid Username'
//                          : null;
//                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Facebook (optional)',
                    ),
                    keyboardType: TextInputType.text,
//                    autovalidate: true,
                    autocorrect: false,
//                    validator: (_) {
//                      return state.isUsernameValid != "VALID"
//                          ? 'Invalid Username'
//                          : null;
//                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Instagram (optional)',
                    ),
                    keyboardType: TextInputType.text,
//                    autovalidate: true,
                    autocorrect: false,
//                    validator: (_) {
//                      return state.isUsernameValid != "VALID"
//                          ? 'Invalid Username'
//                          : null;
//                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Twitter (optional)',
                    ),
                    keyboardType: TextInputType.text,
//                    autovalidate: true,
                    autocorrect: false,
//                    validator: (_) {
//                      return state.isUsernameValid != "VALID"
//                          ? 'Invalid Username'
//                          : null;
//                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[SubmitButton()],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
