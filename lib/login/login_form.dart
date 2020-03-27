import 'package:fastswap/tab/app_tab.dart';
import 'package:fastswap/tab/bloc/tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastswap/user_repository.dart';
import 'package:fastswap/authentication_bloc/authentication_bloc.dart';
import 'package:fastswap/login/login.dart';
import 'package:fastswap/widgets/customLinkWidget.dart';
import 'package:fastswap/userGetData_bloc/bloc/bloc.dart';
import 'package:fastswap/users_bloc/users.dart';

class LoginForm extends StatefulWidget {
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool notNull(Object o) => o != null;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isEmailAlreadyExistsFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registered with Other Login Service!'),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          //update user

        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(500.0),
                        child: Image.asset(
                          'assets/fastswap_logo.JPG',
                          height: 200,
                          fit: BoxFit.fitHeight,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        state.supportsAppleSignIn ? AppleLoginButton() : null,
                        GoogleLoginButton(),
                        // FacebookLoginButton(),
                        CustomLinkWidget(
                            name: "Privacy Policy",
                            url:
                                "https://techsaico.com/fastswap-privacy-policy/",
                            color: Colors.grey),
                      ].where(notNull).toList(),
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
}
