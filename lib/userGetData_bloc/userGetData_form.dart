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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _snapchatController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();

  //final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _usernameController.text.isNotEmpty;

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
    _usernameController.addListener(_onDataChanged);
    _emailController.addListener(_onDataChanged);
    _phoneNumberController.addListener(_onDataChanged);
    _snapchatController.addListener(_onDataChanged);
    _facebookController.addListener(_onDataChanged);
    _instagramController.addListener(_onDataChanged);
    _twitterController.addListener(_onDataChanged);
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
                      labelText: 'Username (required)',
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
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Email (optional)',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return state.isEmailValid != "VALID"
                          ? 'Invalid Email'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Phone Number (optional)',
                    ),
                    keyboardType: TextInputType.number,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return state.isPhoneNumberValid != "VALID"
                          ? 'Invalid Phone number'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: _snapchatController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Snapchat (optional)',
                    ),
                    keyboardType: TextInputType.text,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return state.isSnapchatValid != "VALID"
                          ? 'Invalid Snapchat'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: _facebookController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Facebook (optional)',
                    ),
                    keyboardType: TextInputType.text,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return state.isFacebookValid != "VALID"
                          ? 'Invalid Facebook'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: _instagramController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Instagram (optional)',
                    ),
                    keyboardType: TextInputType.text,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return state.isInstagramValid != "VALID"
                          ? 'Invalid Instagram'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: _twitterController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Twitter (optional)',
                    ),
                    keyboardType: TextInputType.text,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return state.isTwitterValid != "VALID"
                          ? 'Invalid Twitter'
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
    _emailController.dispose();
    _phoneNumberController.dispose();
    _snapchatController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    _twitterController.dispose();
    //_passwordController.dispose();
    super.dispose();
  }

  void _onDataChanged() {
    _UserGetDataBloc.add(
      UserGetDataChanged(
          username: _usernameController.text,
          email: _emailController.text,
          phoneNumber: _phoneNumberController.text,
          snapchat: _snapchatController.text,
          facebook: _facebookController.text,
          instagram: _instagramController.text,
          twitter: _twitterController.text),
    );
  }

  void _onFormSubmitted() {
    _UserGetDataBloc.add(
      UserGetDataSubmitted(
          username: _usernameController.text,
          email: _emailController.text,
          phoneNumber: _phoneNumberController.text,
          snapchat: _snapchatController.text,
          facebook: _facebookController.text,
          instagram: _instagramController.text,
          twitter: _twitterController.text,
          uid: uid,
          displayName: displayName),
    );
  }
}
