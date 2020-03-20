import 'package:fastswap/users_bloc/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidget extends StatefulWidget {
  final String _uid;
  final String _displayName;

  HomeWidget({Key key, @required displayName, @required uid})
      : assert(uid != null),
        assert(displayName != null),
        _uid = uid,
        _displayName = displayName,
        super(key: key);

  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String uid;
  String displayName;
  String whatsapp;

  @override
  void initState() {
    super.initState();
    uid = widget._uid;
    displayName = widget._displayName;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
                'EDIT INFO PAGE Welcome $displayName! UserID: $uid Whatsapp: $whatsapp')
          ]);
    });
  }
}
