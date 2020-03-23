import 'package:fastswap/displayUserData_bloc/displayUserData.dart';
import 'package:fastswap/tab/app_tab.dart';
import 'package:fastswap/tab/bloc/tab.dart';
import 'package:fastswap/usersLib/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayUserDataScreen extends StatelessWidget {
  @override
  User data;
  String twitter;
  String displayname;

  Widget build(BuildContext context) {
    return BlocBuilder<DisplayUserDataBloc, DisplayUserDataState>(
        builder: (displayUserContext, displayUserDataState) {
      data = displayUserDataState.data;
      twitter = data.twitter;
      displayname = data.displayName;
      return Scaffold(
        appBar: AppBar(
            title: Text(displayname),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                BlocProvider.of<DisplayUserDataBloc>(context)
                    .add(DisplayUserDataClear());

                // BlocProvider.of<TabBloc>(context).add(
                //   UpdateTab(AppTab.home)); //reset to home next time you log in
              },
            )),
        body: Center(child: Text('DISPLAY USER DATA SCREEN $twitter')),
      );
    });
  }
}
