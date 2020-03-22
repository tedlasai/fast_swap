import 'package:fastswap/displayUserData_bloc/displayUserData.dart';
import 'package:fastswap/tab/app_tab.dart';
import 'package:fastswap/tab/bloc/tab.dart';
import 'package:fastswap/usersLib/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayUserDataScreen extends StatelessWidget {
  @override
  User data;

  Widget build(BuildContext context) {
    return BlocBuilder<DisplayUserDataBloc, DisplayUserDataState>(
        builder: (displayUserContext, displayUserDataState) {
      data = displayUserDataState.data;
      String twitter = data.twitter;
      print("TWITTER");
      return Scaffold(
        appBar: AppBar(
            title: Text('Display User Data'),
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
