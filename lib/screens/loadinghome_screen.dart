import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication_bloc/authentication_bloc.dart';

class LoadingHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // BlocProvider.of<AuthenticationBloc>(context).add(
              // LoggedOut(),
              // );
            },
          )
        ],
      ),
      body: Center(child: Text('Loading')),
    );
  }
}
