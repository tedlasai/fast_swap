import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class User {
  final String email;
  final String instagram;
  final String phoneNumber;
  final String snapchat;
  final String uid;
  final String username;
  final String whatsapp;

  User(
      {String email,
      String instagram,
      String phoneNumber,
      String snapchat,
      @required String uid,
      String username,
      String whatsapp})
      : email = email ?? "",
        instagram = instagram ?? "",
        phoneNumber = phoneNumber ?? "",
        snapchat = snapchat ?? "",
        uid = uid,
        username = username ?? "",
        whatsapp = whatsapp ?? "";

  User copyWith(
      {String email,
      String instagram,
      String phoneNumber,
      String snapchat,
      String uid,
      String username,
      String whatsapp}) {
    return User(
        email: email ?? this.email,
        instagram: instagram ?? this.instagram,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        snapchat: snapchat ?? this.snapchat,
        uid: uid ?? this.uid,
        username: username ?? this.username,
        whatsapp: whatsapp ?? this.whatsapp);
  }

  @override
  int get hashCode =>
      email.hashCode ^
      instagram.hashCode ^
      phoneNumber.hashCode ^
      snapchat.hashCode ^
      uid.hashCode ^
      username.hashCode ^
      whatsapp.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          instagram == other.instagram &&
          snapchat == other.snapchat &&
          phoneNumber == other.phoneNumber &&
          uid == other.uid &&
          username == other.username &&
          whatsapp == other.whatsapp;

  @override
  String toString() {
    return 'User{email: $email, instagram: $instagram, phoneNumber: $phoneNumber, snapchat: $snapchat,   uid: $uid , username: $username, whatsapp: $whatsapp,}';
  }

  UserEntity toEntity() {
    return UserEntity(
        email: email,
        instagram: instagram,
        phoneNumber: phoneNumber,
        snapchat: snapchat,
        uid: uid,
        username: username,
        whatsapp: whatsapp);
  }

  static User fromEntity(UserEntity entity) {
    return User(
        email: entity.email,
        instagram: entity.instagram,
        phoneNumber: entity.phoneNumber,
        snapchat: entity.snapchat,
        uid: entity.uid,
        username: entity.username,
        whatsapp: entity.whatsapp);
  }
}
