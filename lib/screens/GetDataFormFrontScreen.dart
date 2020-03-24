import 'package:fastswap/userGetData_bloc/userGetData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication_bloc/authentication_bloc.dart';

class GetDataFormFrontScreen extends StatefulWidget {
  final String _uid;
  final String _displayName;

  GetDataFormFrontScreen({Key key, @required displayName, @required uid})
      : assert(uid != null),
        _uid = uid,
        _displayName = displayName,
        super(key: key);

  State<GetDataFormFrontScreen> createState() => _GetDataFormFrontScreenState();
}

class _GetDataFormFrontScreenState extends State<GetDataFormFrontScreen> {
  String uid;
  String displayName;

  void initState() {
    super.initState();
    uid = widget._uid;
    displayName = widget._displayName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Enter User Data')),
        body: UserGetDataForm(uid: uid, displayName: displayName));
  }
}
