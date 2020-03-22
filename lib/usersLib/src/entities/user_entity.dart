// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.
import 'package:fastswap/usersLib/src/models/user.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../helpers.dart';

class UserEntity extends Equatable {
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

  UserEntity(
      {String displayName,
      String email,
      String instagram,
      String phoneNumber,
      String snapchat,
      @required String uid,
      String username,
      String usernameLowercase,
      List<String> usernameSearchTerms,
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

  Map<String, Object> toJson() {
    return {
      "displayName": displayName,
      "email": email,
      "instagram": instagram,
      "phoneNumber": phoneNumber,
      "snapchat": snapchat,
      "uid": uid,
      "username": username,
      "usernameLowercase": usernameLowercase,
      "usernameSearchTerms": usernameSearchTerms,
      "whatsapp": whatsapp,
    };
  }

  @override
  List<Object> get props => [
        displayName,
        email,
        instagram,
        phoneNumber,
        snapchat,
        uid,
        username,
        usernameLowercase,
        usernameSearchTerms,
        whatsapp
      ];

  @override
  String toString() {
    return 'UserEntity {  displayName: $displayName email: $email, instagram: $instagram, phoneNumber: $phoneNumber, snapchat: $snapchat,   uid: $uid , username: $username, usernameLowercase: $usernameLowercase, usernameSearchTerms: $usernameSearchTerms, whatsapp: $whatsapp,}';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      displayName: json["displayName"] as String,
      email: json["email"] as String,
      instagram: json["instagram"] as String,
      phoneNumber: json["phoneNumber"] as String,
      snapchat: json["snapchat"] as String,
      uid: json["uid"] as String,
      username: json["username"] as String,
      usernameLowercase: json["usernameLowercase"] as String,
      usernameSearchTerms: json["usernameSearchTerms"] as List<String>,
      whatsapp: json["whatsapp"] as String,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    List<dynamic> usernameSearchTerms = snap.data['usernameSearchTerms'];
    List<String> usernameSearchTermsString =
        new List<String>.from(usernameSearchTerms);
    return UserEntity(
      displayName: snap.data["displayName"],
      email: snap.data['email'],
      instagram: snap.data['instagram'],
      phoneNumber: snap.data['phoneNumber'],
      snapchat: snap.data['snapchat'],
      uid: snap.documentID,
      username: snap.data['username'],
      usernameLowercase: snap.data['usernameLowercase'],
      usernameSearchTerms: usernameSearchTermsString,
      whatsapp: snap.data['whatsapp'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "displayName": displayName,
      "email": email,
      "instagram": instagram,
      "phoneNumber": phoneNumber,
      "snapchat": snapchat,
      "username": username,
      "usernameLowercase": usernameLowercase,
      "usernameSearchTerms": usernameSearchTerms,
      "whatsapp": whatsapp,
    };
  }
}
