import 'package:fastswap/authentication_bloc/authentication_bloc.dart';
import 'package:fastswap/qrcodegen_bloc/qrcodegen.dart';

import 'package:fastswap/tab/app_tab.dart';
import 'package:fastswap/tab/bloc/tab.dart';
import 'package:fastswap/userGetData_bloc/bloc/bloc.dart';
import 'package:fastswap/users_bloc/users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastswap/search_bloc/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAccountAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  CustomAccountAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAccountAppBarState createState() => _CustomAccountAppBarState();
}

class _CustomAccountAppBarState extends State<CustomAccountAppBar> {
  // Create a text controller. Later, use it to retrieve the
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Account'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            BlocProvider.of<SearchBloc>(context).add(SearchClear());
            BlocProvider.of<UserGetDataBloc>(context)
                .add(UserGetDataUninitialized());
            BlocProvider.of<UsersBloc>(context).add(NoUser());
            BlocProvider.of<QrCodeGenBloc>(context).add(QrCodeGenClear());
            BlocProvider.of<TabBloc>(context).add(
                UpdateTab(AppTab.home)); //reset to home next time you log in
          },
        )
      ],
    );
  }
}
