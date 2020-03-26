import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastswap/login/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppleLoginButton extends StatefulWidget {
  State<AppleLoginButton> createState() => _AppleLoginButtonState();
}

class _AppleLoginButtonState extends State<AppleLoginButton> {
  @override
  Widget build(BuildContext context) {
    return AppleSignInButton(
      style: ButtonStyle.black,
      type: ButtonType.signIn,
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithApplePressed(),
        );
      },
    );
  }
}
