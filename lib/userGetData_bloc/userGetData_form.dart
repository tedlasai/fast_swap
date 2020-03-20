import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastswap/user_repository.dart';
import 'package:fastswap/authentication_bloc/authentication_bloc.dart';
import 'package:fastswap/userGetData_bloc/bloc/bloc.dart';
import 'package:fastswap/userGetData_bloc/bloc/userGetData_bloc.dart';
import 'package:fastswap/userGetData_bloc/submit_button.dart';
import 'package:fastswap/userGetData_bloc/userGetData_screen.dart';

import '../screens/splash_screen.dart';

class UserGetDataForm extends StatefulWidget {
  final String _uid;
  final String _displayName;

  UserGetDataForm({Key key, @required String uid, @required String displayName})
      : assert(uid != null),
        _uid = uid,
        _displayName = displayName,
        super(key: key);

  State<UserGetDataForm> createState() => _UserGetDataFormState();
}

class _UserGetDataFormState extends State<UserGetDataForm> {
  String uid;
  String displayName;
  final TextEditingController _usernameController = TextEditingController();

  //final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated => _usernameController.text.isNotEmpty;

  bool isSubmitButtonEnabled(UserGetDataState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  UserGetDataBloc _UserGetDataBloc;

  //UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    uid = widget._uid;
    displayName = widget._displayName;
    _UserGetDataBloc = BlocProvider.of<UserGetDataBloc>(context);
    _usernameController.addListener(_onUsernameChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserGetDataBloc, UserGetDataState>(
      listener: (context, state) {
        if (!state.isFormValid) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(state.errorMessage()), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSuccess) {
          //BlocProvider.of<UserGetDataBloc>(context).add(UserGetDataSubmitted());
        }
      },
      child: BlocBuilder<UserGetDataBloc, UserGetDataState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset('assets/flutter_logo.png', height: 200),
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Username',
                    ),
                    keyboardType: TextInputType.text,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return state.isUsernameValid != "VALID"
                          ? 'Invalid Username'
                          : null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SubmitButton(
                          onPressed: isSubmitButtonEnabled(state)
                              ? _onFormSubmitted
                              : null,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    //_passwordController.dispose();
    super.dispose();
  }

  void _onUsernameChanged() {
    _UserGetDataBloc.add(
      UserGetDataUsernameChanged(username: _usernameController.text),
    );
  }

  void _onFormSubmitted() {
    _UserGetDataBloc.add(
      UserGetDataSubmitted(
          username: _usernameController.text,
          uid: uid,
          displayName: displayName),
    );
  }
}
