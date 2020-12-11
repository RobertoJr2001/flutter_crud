import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USERS};
  List<User> get all {
    return [..._items.values];
  }

  get length => _items.length;

  get values => _items.values;

  void put(User user) {
    if (user==null) return;
  }

  final id = Random().nextDouble().toString();
  _items.putIfAbsent(id, () => User()

    id: id,
    name: user.name,
    email: user.email,
    avatarUrl: user.avatarUrl,

   )

   @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}
