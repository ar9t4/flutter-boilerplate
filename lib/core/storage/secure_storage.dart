import 'dart:convert';

import 'package:flutter_boilerplate/features/users/data/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  User? _user;
  late FlutterSecureStorage secureStorage;

  SecureStorage() {
    _init();
  }

  void _init() {
    secureStorage = FlutterSecureStorage(
      aOptions:
          AndroidOptions(resetOnError: true, encryptedSharedPreferences: true),
      iOptions: const IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device),
    );
  }

  Future<void> saveUser(User? user) async {
    if (user == null) return;
    String userJson = jsonEncode(user.toJson());
    await secureStorage.write(key: 'user_data', value: userJson);
    _user = user;
  }

  Future<User?> getUser() async {
    if (_user == null) {
      String? userJson = await secureStorage.read(key: 'user_data');
      if (userJson == null) return null;
      Map<String, dynamic> userMap = jsonDecode(userJson);
      _user = User.fromJson(userMap);
    }
    return _user;
  }

  Future<void> removeUser() async {
    await secureStorage.delete(key: 'user_data');
    _user = null;
  }

  Future<String?> getAccessToken() async {
    final user = await getUser();
    return user?.token;
  }

  Future<String?> getRefreshToken() async {
    final user = await getUser();
    return user?.refreshToken;
  }
}
