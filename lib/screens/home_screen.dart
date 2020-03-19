import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastswap/authentication_bloc/authentication_bloc.dart';
import 'package:fastswap/tab/app_tab.dart';
import 'package:fastswap/tab/bloc/tab.dart';
import 'package:fastswap/tab/tab_selector.dart';
import 'package:fastswap/userGetData_bloc/bloc/bloc.dart';
import 'package:fastswap/usersLib/users_repository.dart';
import 'package:fastswap/users_bloc/users.dart';

class HomeScreen extends StatefulWidget {
  final String _uid;
  final String _displayName;

  HomeScreen({Key key, @required displayName, @required uid})
      : assert(uid != null),
        _uid = uid,
        _displayName = displayName,
        super(key: key);

  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String uid;
  String displayName;
  UsersBloc _UsersBloc;
  AppTab _activeTab;

  @override
  void initState() {
    super.initState();
    _activeTab = _activeTab;
    uid = widget._uid;
    displayName = widget._displayName;
    _UsersBloc = BlocProvider.of<UsersBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
      if (state is UserInfoLoaded) {
        print(state.userInfo["whatsapp"]);
      } else {
        print(state);
      }
      return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    LoggedOut(),
                  );
                },
              )
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(child: Text('Welcome $displayName! UserID: $uid')),
            ],
          ),
          bottomNavigationBar: BlocBuilder<TabBloc, AppTab>(
            builder: (context, activeTab) {
              return TabSelector(
                activeTab: activeTab,
                onTabSelected: (tab) =>
                    BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
              );
            },
          ));
    });
  }
}
