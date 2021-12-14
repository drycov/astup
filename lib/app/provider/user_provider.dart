import 'dart:collection';

import 'package:astup/app/helpers/data_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:astup/app/models/user_mock.dart';
class UserProvider extends ChangeNotifier {
  final List<User> _users = DataHelper.dataHelper.users;
  List<User> _foundedUser = [];

  List<User> get users => UnmodifiableListView(_foundedUser);

  UserProvider() {
    getAllUsers();
  }

  getAllUsers() async {
    _foundedUser = _users;
    notifyListeners();
  }

  onSearch(String search) {
    _foundedUser = _users
        .where((user) => user.name.toLowerCase().contains(search))
        .toList();
    notifyListeners();
  }

  toggleUserFollow(int index) {
    users[index].toggleFollowUser();
    notifyListeners();
    getAllUsers();
  }

  updataListUsers() async {}
}