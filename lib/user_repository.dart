import 'dart:async';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;
  final AppleSignIn _appleSignIn;

  UserRepository(
      {FirebaseAuth firebaseAuth,
      GoogleSignIn googleSignIn,
      FacebookLogin facebookLogin,
      AppleSignIn appleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _facebookLogin = facebookLogin ?? FacebookLogin(),
        _appleSignIn = appleSignIn ?? AppleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<FirebaseUser> signInWithApple() async {
    print("IN SIGN IN WITH APPLE");
    final AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        final AppleIdCredential appleIdCredential = result.credential;
        OAuthProvider oAuthProvider =
            new OAuthProvider(providerId: "apple.com");
        final AuthCredential credential = oAuthProvider.getCredential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode),
        );
        await _firebaseAuth.signInWithCredential(credential);

        await _firebaseAuth.currentUser().then((val) async {
          UserUpdateInfo updateUser = UserUpdateInfo();
          updateUser.displayName =
              "${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}";
          await val.updateProfile(updateUser);
        });
        break;
      case AuthorizationStatus.cancelled:
        // TODO: Handle this case.
        break;
      case AuthorizationStatus.error:
        // TODO: Handle this case.
        break;
    }

    return _firebaseAuth.currentUser();
  }

  Future<FirebaseUser> signInWithFacebook() async {
    final FacebookLoginResult facebookLoginResult =
        await _facebookLogin.logIn([]);
    final accessToken = facebookLoginResult.accessToken.token;
    final credential =
        FacebookAuthProvider.getCredential(accessToken: accessToken);
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
      _facebookLogin.logOut()
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUserUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<String> getUserDisplayName() async {
    return (await _firebaseAuth.currentUser()).displayName;
  }
}
