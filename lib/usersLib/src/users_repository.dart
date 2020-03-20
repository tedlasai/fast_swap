// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastswap/usersLib/users_repository.dart';

abstract class UsersRepository {
  Future<void> addNewUser(User user);

  Future<void> setNewUser(User user);

  Future<QuerySnapshot> findUsers(String query);

  Future<void> deleteUser(User user);

  Future<DocumentReference> pullUser(User user);

  Future<void> updateUser(User user);
}
