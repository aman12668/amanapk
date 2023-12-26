import 'package:ENEB_HUB/core/Database/users.service.dart';
import 'package:ENEB_HUB/core/providers/books.provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersNotifier extends ChangeNotifier {
  String? userName;

  getCurrentUserName() async {
    final result = await UserService().getCurrentUsername();
    userName = result;
    notifyListeners();
  }
}

final usersProvider =
    ChangeNotifierProvider<UsersNotifier>((ref) => UsersNotifier());
