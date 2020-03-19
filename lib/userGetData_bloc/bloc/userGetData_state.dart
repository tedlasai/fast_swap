import 'package:meta/meta.dart';

@immutable
class UserGetDataState {
  final bool hasUserData;
  final bool hasLoadedUser;
  final bool isSuccess;
  final bool isFailure;
  final bool isSubmitting;
  final String isUsernameValid;
  final String userEmail;
  final String username;
  final String uid;

  bool get isFormValid =>
      isUsernameValid == "VALID" && isUsernameValid == "VALID";

  String errorMessage() {
    if (isUsernameValid != "VALID") {
      return isUsernameValid;
    } else {
      return "";
    }
  }

  UserGetDataState(
      {this.hasUserData,
      this.isFailure,
      this.isSuccess,
      this.hasLoadedUser,
      this.isSubmitting,
      this.isUsernameValid,
      this.userEmail,
      this.username,
      this.uid});

  factory UserGetDataState.empty() {
    return UserGetDataState(
        hasLoadedUser: false,
        isSuccess: false,
        isFailure: false,
        hasUserData: false,
        isSubmitting: false,
        isUsernameValid: "VALID",
        username: "adfsdf");
  }

  UserGetDataState update(
      {String isUsernameValid, String username, String uid}) {
    return copyWith(
      isUsernameValid: isUsernameValid,
      username: username,
      uid: uid,
      hasUserData: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory UserGetDataState.failure() {
    return UserGetDataState(
      isUsernameValid: "",
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
      isSubmitting: true,
      hasUserData: false,
      hasLoadedUser: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  UserGetDataState copyWith({
    String isUsernameValid,
    String uid,
    String username,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool hasUserData,
    bool hasLoadedUser,
    bool isSuccess,
    bool isFailure,
  }) {
    return UserGetDataState(
      username: username ?? this.username,
      uid: uid ?? this.uid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
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
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure
    }''';
  }
}
