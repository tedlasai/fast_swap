import 'package:meta/meta.dart';
import '../entities/entities.dart';
import '../helpers.dart';

@immutable
class User {
  final String displayName;
  final String email;
  final String instagram;
  final String phoneNumber;
  final String snapchat;
  final String uid;
  final String username;
  final String usernameLowercase;
  final List<String> usernameSearchTerms;
  final String whatsapp;

  User(
      {String displayName,
      String email,
      String instagram,
      String phoneNumber,
      String snapchat,
      @required String uid,
      String username,
      List<String> usernameSearchTerms,
      String usernameLowercase,
      String whatsapp})
      : displayName = displayName ?? "",
        email = email ?? "",
        instagram = instagram ?? "",
        phoneNumber = phoneNumber ?? "",
        snapchat = snapchat ?? "",
        uid = uid,
        username = username ?? "",
        usernameLowercase = toLower(username),
        usernameSearchTerms = setSearchParam(usernameLowercase),
        whatsapp = whatsapp ?? "";

  User copyWith(
      {String displayName,
      String email,
      String instagram,
      String phoneNumber,
      String snapchat,
      String uid,
      String username,
      String usernameLowercase,
      List<String> usernameSearchTerms,
      String whatsapp}) {
    return User(
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        instagram: instagram ?? this.instagram,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        snapchat: snapchat ?? this.snapchat,
        uid: uid ?? this.uid,
        username: username ?? this.username,
        usernameLowercase: usernameLowercase ?? this.usernameLowercase,
        usernameSearchTerms: usernameSearchTerms ?? this.usernameSearchTerms,
        whatsapp: whatsapp ?? this.whatsapp);
  }

  @override
  int get hashCode =>
      displayName.hashCode ^
      email.hashCode ^
      instagram.hashCode ^
      phoneNumber.hashCode ^
      snapchat.hashCode ^
      uid.hashCode ^
      username.hashCode ^
      usernameLowercase.hashCode ^
      usernameSearchTerms.hashCode ^
      whatsapp.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          displayName == other.displayName &&
          email == other.email &&
          instagram == other.instagram &&
          snapchat == other.snapchat &&
          phoneNumber == other.phoneNumber &&
          uid == other.uid &&
          username == other.username &&
          whatsapp == other.whatsapp;

  @override
  String toString() {
    return 'User{displayName: $displayName, email: $email, instagram: $instagram, phoneNumber: $phoneNumber, snapchat: $snapchat,   uid: $uid , username: $username, usernameLowercase: $usernameLowercase, usernameSearchTerms: $usernameSearchTerms, whatsapp: $whatsapp,}';
  }

  UserEntity toEntity() {
    return UserEntity(
        displayName: displayName,
        email: email,
        instagram: instagram,
        phoneNumber: phoneNumber,
        snapchat: snapchat,
        uid: uid,
        username: username,
        usernameLowercase: usernameLowercase,
        usernameSearchTerms: usernameSearchTerms,
        whatsapp: whatsapp);
  }

  static User fromEntity(UserEntity entity) {
    return User(
        displayName: entity.displayName,
        email: entity.email,
        instagram: entity.instagram,
        phoneNumber: entity.phoneNumber,
        snapchat: entity.snapchat,
        uid: entity.uid,
        username: entity.username,
        usernameLowercase: entity.usernameLowercase,
        usernameSearchTerms: entity.usernameSearchTerms,
        whatsapp: entity.whatsapp);
  }
}
