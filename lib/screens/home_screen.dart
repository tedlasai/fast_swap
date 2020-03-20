import 'package:fastswap/widgets/account_widget.dart';
import 'package:fastswap/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastswap/authentication_bloc/authentication_bloc.dart';
import 'package:fastswap/tab/app_tab.dart';
import 'package:fastswap/tab/bloc/tab.dart';
import 'package:fastswap/tab/tab_selector.dart';
import 'package:fastswap/userGetData_bloc/bloc/bloc.dart';
import 'package:fastswap/usersLib/users_repository.dart';
import 'package:fastswap/users_bloc/users.dart';
import 'package:fastswap/widgets/customSearchDelegate_widget.dart';

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

  @override
  void initState() {
    super.initState();
    uid = widget._uid;
    displayName = widget._displayName;
    _UsersBloc = BlocProvider.of<UsersBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
            appBar: AppBar(
              title: Text(activeTab == AppTab.home ? 'Home' : 'Account'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  },
                ),
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
            body: activeTab == AppTab.home
                ? HomeWidget(uid: uid, displayName: displayName)
                : AccountWidget(uid: uid, displayName: displayName),
            bottomNavigationBar: TabSelector(
              activeTab: activeTab,
              onTabSelected: (tab) =>
                  BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
            ));
      },
    );
  }
}
