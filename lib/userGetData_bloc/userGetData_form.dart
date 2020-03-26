import 'package:fastswap/users_bloc/users.dart';
import 'package:fastswap/widgets/showAlertDelayedDialog.dart';
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

  bool get isPopulated => _usernameController.text.isNotEmpty;

  bool isSubmitButtonEnabled(UserGetDataState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  bool hasLoadedInitalData;

  UserGetDataBloc _UserGetDataBloc;

  //UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();

    hasLoadedInitalData = false;
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

  bool notNull(Object o) => o != null;

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
    }, child: BlocBuilder<UserGetDataBloc, UserGetDataState>(
            builder: (context, state) {
      return BlocBuilder<UsersBloc, UsersState>(
        builder: (UserCurrentContext, UserCurrentState) {
          if (!hasLoadedInitalData) {
            if (UserCurrentState is UserInfoLoaded) {
              _usernameController.text =
                  UserCurrentState.userInfo.username != null
                      ? UserCurrentState.userInfo.username
                      : "";
              _emailController.text = UserCurrentState.userInfo.email != null
                  ? UserCurrentState.userInfo.email
                  : "";
              _phoneNumberController.text =
                  UserCurrentState.userInfo.phoneNumber != null
                      ? UserCurrentState.userInfo.phoneNumber
                      : "";
              _facebookController.text =
                  UserCurrentState.userInfo.facebook != null
                      ? UserCurrentState.userInfo.facebook
                      : "";
              _instagramController.text =
                  UserCurrentState.userInfo.instagram != null
                      ? UserCurrentState.userInfo.instagram
                      : "";
              _snapchatController.text =
                  UserCurrentState.userInfo.snapchat != null
                      ? UserCurrentState.userInfo.snapchat
                      : "";
              _twitterController.text =
                  UserCurrentState.userInfo.twitter != null
                      ? UserCurrentState.userInfo.twitter
                      : "";
            } else {
              _usernameController.text = "";
              _emailController.text = "";
              _facebookController.text = "";
              _instagramController.text = "";
              _snapchatController.text = "";
              _twitterController.text = "";
              _phoneNumberController.text = "";
            }
            hasLoadedInitalData = true;
          }
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                reverse: true,
                shrinkWrap: true,
                children: <Widget>[
                  !state.hasUserData
                      ? TextFormField(
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
                        )
                      : TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: 'Username',
                          ),
                          keyboardType: TextInputType.text,
                          style: new TextStyle(color: Colors.grey),
                          autovalidate: true,
                          autocorrect: false,
                          enabled: false,
                          validator: (_) {
                            return state.isUsernameValid != "VALID"
                                ? 'Invalid Username'
                                : null;
                          },
                        ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
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
                      icon: Icon(Icons.phone),
                      labelText: 'Phone Number (optional)',
                    ),
                    keyboardType: TextInputType.text,
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
                      icon: Icon(Icons.link),
                      labelText: 'Snapchat Username (optional)',
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
                      icon: Icon(Icons.link),
                      labelText: 'Facebook Username (optional)',
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
                      icon: Icon(Icons.link),
                      labelText: 'Instagram Username (optional)',
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
                      icon: Icon(Icons.link),
                      labelText: 'Twitter Username (optional)',
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
                              ? () => _onFormSubmitted(state.hasUserData)
                              : null,
                        )
                      ],
                    ),
                  ),
                ].reversed.where(notNull).toList(),
              ),
            ),
          );
        },
      );
    }));
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

  void _onFormSubmitted(bool hasUserData) {
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
          displayName: displayName,
          usernameCreated: true),
    );

    print("HAS LOADED USER");
    if (hasUserData) {
      showAlertDelayedDialog(context, "Data Submitted", "");
    }

    FocusScope.of(context).requestFocus(FocusNode()); //hide keyboard

    //update user
    BlocProvider.of<UsersBloc>(context).add(
      LoadUser(uid),
    );
  }
}
