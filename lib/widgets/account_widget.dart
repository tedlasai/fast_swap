import 'package:flutter/material.dart';

class AccountWidget extends StatefulWidget {
  final String _uid;
  final String _displayName;

  AccountWidget({Key key, @required displayName, @required uid})
      : assert(uid != null),
        _uid = uid,
        _displayName = displayName,
        super(key: key);

  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  String uid;
  String displayName;

  @override
  void initState() {
    super.initState();
    uid = widget._uid;
    displayName = widget._displayName;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[Text('Welcome $displayName! UserID: $uid')]);
  }
}
