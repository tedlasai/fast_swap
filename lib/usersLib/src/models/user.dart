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
  final String facebook;
  final String uid;
  final String username;
  final String usernameLowercase;
  final List<String> usernameSearchTerms;
  final String twitter;

  User(
      {String displayName,
      String email,
      String instagram,
      String phoneNumber,
      String facebook,
      String snapchat,
      @required String uid,
      String username,
      List<String> usernameSearchTerms,
      String usernameLowercase,
      String twitter})
      : displayName = displayName ?? "",
        email = email ?? "",
        instagram = instagram ?? "",
        phoneNumber = phoneNumber ?? "",
        snapchat = snapchat ?? "",
        facebook = facebook ?? "",
        uid = uid,
        username = username ?? "",
        usernameLowercase = toLower(username),
        usernameSearchTerms = setSearchParam(usernameLowercase),
        twitter = twitter ?? "";

  User copyWith(
      {String displayName,
      String email,
      String instagram,
      String facebook,
      String phoneNumber,
      String snapchat,
      String uid,
      String username,
      String usernameLowercase,
      List<String> usernameSearchTerms,
      String twitter}) {
    return User(
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        instagram: instagram ?? this.instagram,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        snapchat: snapchat ?? this.snapchat,
        facebook: facebook ?? this.facebook,
        uid: uid ?? this.uid,
        username: username ?? this.username,
        usernameLowercase: usernameLowercase ?? this.usernameLowercase,
        usernameSearchTerms: usernameSearchTerms ?? this.usernameSearchTerms,
        twitter: twitter ?? this.twitter);
  }

  @override
  int get hashCode =>
      displayName.hashCode ^
      email.hashCode ^
      instagram.hashCode ^
      phoneNumber.hashCode ^
      snapchat.hashCode ^
      facebook.hashCode ^
      uid.hashCode ^
      username.hashCode ^
      usernameLowercase.hashCode ^
      usernameSearchTerms.hashCode ^
      twitter.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          displayName == other.displayName &&
          email == other.email &&
          instagram == other.instagram &&
          facebook == other.facebook &&
          snapchat == other.snapchat &&
          phoneNumber == other.phoneNumber &&
          uid == other.uid &&
          username == other.username &&
          twitter == other.twitter;

  @override
  String toString() {
    return 'User{displayName: $displayName, email: $email, facebook: $facebook, instagram: $instagram, phoneNumber: $phoneNumber, snapchat: $snapchat,   uid: $uid , username: $username, usernameLowercase: $usernameLowercase, usernameSearchTerms: $usernameSearchTerms, twitter: $twitter,}';
  }

  UserEntity toEntity() {
    return UserEntity(
        displayName: displayName,
        email: email,
        instagram: instagram,
        facebook: facebook,
        phoneNumber: phoneNumber,
        snapchat: snapchat,
        uid: uid,
        username: username,
        usernameLowercase: usernameLowercase,
        usernameSearchTerms: usernameSearchTerms,
        twitter: twitter);
  }

  static User fromEntity(UserEntity entity) {
    return User(
        displayName: entity.displayName,
        email: entity.email,
        facebook: entity.facebook,
        instagram: entity.instagram,
        phoneNumber: entity.phoneNumber,
        snapchat: entity.snapchat,
        uid: entity.uid,
        username: entity.username,
        usernameLowercase: entity.usernameLowercase,
        usernameSearchTerms: entity.usernameSearchTerms,
        twitter: entity.twitter);
  }
}
