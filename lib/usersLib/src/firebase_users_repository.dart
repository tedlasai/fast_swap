// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastswap/usersLib/users_repository.dart';
import 'entities/entities.dart';

class FirebaseUsersRepository implements UsersRepository {
  final userCollection = Firestore.instance.collection('users');
  final String uid;

  FirebaseUsersRepository({this.uid});

  @override
  Future<void> addNewUser(User User) {
    return userCollection.add(User.toEntity().toDocument());
  }

  Future<QuerySnapshot> findUsers(String query) {
    try {
      return userCollection
          .where("usernameSearchTerms", arrayContains: query)
          .limit(10)
          .getDocuments();
      /*return userCollection
          .where("username", isEqualTo: "tedlasai")
          .getDocuments();*/
    } catch (_) {
      print(_);
    }
  }

  @override
  Future<void> setNewUser(User User) {
    try {
      return userCollection
          .document(User.uid)
          .setData(User.toEntity().toDocument(), merge: true);
    } catch (_) {
      print(_);
    }
  }

  @override
  Future<void> deleteUser(User User) async {
    return userCollection.document(User.uid).delete();
  }

  @override
  Future<DocumentReference> pullUser(User User) async {
    return userCollection.document(User.uid);
  }

  Future<QuerySnapshot> findUsername(String username) async {
    try {
      return userCollection
          .where("username", isEqualTo: username)
          .limit(1)
          .getDocuments();
    } catch (_) {
      print(_);
    }
  }

  @override
  Future<void> updateUser(User update) {
    return userCollection
        .document(update.uid)
        .updateData(update.toEntity().toDocument());
  }
}
