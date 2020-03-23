import 'package:meta/meta.dart';

@immutable
class UserGetDataState {
  final bool hasUserData;
  final bool hasLoadedUser;
  final bool isSuccess;
  final bool isFailure;
  final bool isSubmitting;
  final String uid;
  final String username;
  final String email;
  final String phoneNumber;
  final String snapchat;
  final String facebook;
  final String instagram;
  final String twitter;
  final String isUsernameValid;
  final String isEmailValid;
  final String isPhoneNumberValid;
  final String isSnapchatValid;
  final String isFacebookValid;
  final String isInstagramValid;
  final String isTwitterValid;

  bool get isFormValid =>
      isUsernameValid == "VALID" && isEmailValid == "VALID" &&
          isPhoneNumberValid == "VALID" && isSnapchatValid == "VALID" &&
          isFacebookValid == "VALID" && isInstagramValid == "VALID" && isTwitterValid == "VALID";

  String errorMessage() {
    if (isUsernameValid != "VALID") {
      return isUsernameValid;
    } else if (isEmailValid != "VALID") {
      return isEmailValid;
    } else if (isPhoneNumberValid != "VALID") {
      return isPhoneNumberValid;
    } else if (isSnapchatValid != "VALID") {
      return isSnapchatValid;
    } else if (isInstagramValid != "VALID") {
      return isInstagramValid;
    } else if (isTwitterValid != "VALID") {
      return isTwitterValid;
    } else {
      return "";
    }
  }

  UserGetDataState({this.hasUserData,
    this.isFailure,
    this.isSuccess,
    this.hasLoadedUser,
    this.isSubmitting,
    this.uid,
    this.username,
    this.email,
    this.phoneNumber,
    this.snapchat,
    this.facebook,
    this.instagram,
    this.twitter,
    this.isUsernameValid,
    this.isEmailValid,
    this.isPhoneNumberValid,
    this.isSnapchatValid,
    this.isFacebookValid,
    this.isInstagramValid,
    this.isTwitterValid});

  factory UserGetDataState.empty() {
      return UserGetDataState(
          hasLoadedUser: false,
          isSuccess: false,
          isFailure: false,
          hasUserData: false,
          isSubmitting: false,
          username: "adfsdf",
          email: "adfsdf",
          phoneNumber: "adfsdf",
          snapchat: "adfsdf",
          facebook: "adfsdf",
          instagram: "adfsdf",
          twitter: "adfsdf",
          isUsernameValid: "VALID",
          isEmailValid: "VALID",
          isPhoneNumberValid: "VALID",
          isSnapchatValid: "VALID",
          isFacebookValid: "VALID",
          isInstagramValid: "VALID",
          isTwitterValid: "VALID");
  }

  UserGetDataState update({String uid,
    String username,
    String email,
    String phoneNumber,
    String snapchat,
    String facebook,
    String instagram,
    String twitter,
    String isUsernameValid,
    String isEmailValid,
    String isPhoneNumberValid,
    String isSnapchatValid,
    String isFacebookValid,
    String isInstagramValid,
    String isTwitterValid}) {
    return copyWith(
      uid: uid,
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      snapchat: snapchat,
      facebook: facebook,
      instagram: instagram,
      twitter: twitter,
      isUsernameValid: isUsernameValid,
      isEmailValid: isEmailValid,
      isPhoneNumberValid: isPhoneNumberValid,
      isSnapchatValid: isSnapchatValid,
      isFacebookValid: isFacebookValid,
      isInstagramValid: isInstagramValid,
      isTwitterValid: isTwitterValid,
      hasUserData: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory UserGetDataState.failure() {
    return UserGetDataState(
      isUsernameValid: "",
      isEmailValid: "",
      isPhoneNumberValid: "",
      isSnapchatValid: "",
      isFacebookValid: "",
      isInstagramValid: "",
      isTwitterValid: "",
      isSubmitting: false,
      hasUserData: false,
      hasLoadedUser: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory UserGetDataState.success() {
    return UserGetDataState(
      isUsernameValid: "VALID",
      isEmailValid: "VALID",
      isPhoneNumberValid: "VALID",
      isSnapchatValid: "VALID",
      isFacebookValid: "VALID",
      isInstagramValid: "VALID",
      isTwitterValid: "VALID",
      isSubmitting: false,
      hasUserData: true,
      hasLoadedUser: true,
      isSuccess: true,
      isFailure: false,
    );
  }

  factory UserGetDataState.loadedUser() {
    return UserGetDataState(
      isUsernameValid: "VALID",
      isEmailValid: "VALID",
      isPhoneNumberValid: "VALID",
      isSnapchatValid: "VALID",
      isFacebookValid: "VALID",
      isInstagramValid: "VALID",
      isTwitterValid: "VALID",
      isSubmitting: false,
      hasUserData: false,
      hasLoadedUser: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory UserGetDataState.loading() {
    return UserGetDataState(
      isUsernameValid: "VALID",
      isEmailValid: "VALID",
      isPhoneNumberValid: "VALID",
      isSnapchatValid: "VALID",
      isFacebookValid: "VALID",
      isInstagramValid: "VALID",
      isTwitterValid: "VALID",
      isSubmitting: true,
      hasUserData: false,
      hasLoadedUser: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  UserGetDataState copyWith({
    String uid,
    String username,
    String email,
    String phoneNumber,
    String snapchat,
    String facebook,
    String instagram,
    String twitter,
    String isUsernameValid,
    String isEmailValid,
    String isPhoneNumberValid,
    String isSnapchatValid,
    String isFacebookValid,
    String isInstagramValid,
    String isTwitterValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool hasUserData,
    bool hasLoadedUser,
    bool isSuccess,
    bool isFailure,
  }) {
    return UserGetDataState(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      snapchat: snapchat ?? this.snapchat,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      twitter: twitter ?? this.twitter,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isSnapchatValid: isSnapchatValid ?? this.isSnapchatValid,
      isFacebookValid: isFacebookValid ?? this.isFacebookValid,
      isInstagramValid: isInstagramValid ?? this.isInstagramValid,
      isTwitterValid: isTwitterValid ?? this.isTwitterValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      hasUserData: hasUserData ?? this.hasUserData,
      hasLoadedUser: hasLoadedUser ?? this.hasLoadedUser,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''UserGetDataState {
      hasUserData: $hasUserData,
      hasLoadedUser: $hasLoadedUser,
      isUsernameValid: $isUsernameValid, 
      isEmailValid: $isEmailValid,
      isPhoneNumberValid: $isPhoneNumberValid,
      isSnapchatValid: $isSnapchatValid,
      isFacebookValid: $isFacebookValid,
      isInstagramValid: $isInstagramValid,
      isTwitterValid: $isTwitterValid,   
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure
    }''';
  }
}
