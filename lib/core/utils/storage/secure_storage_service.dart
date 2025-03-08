import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const AndroidOptions _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );
  static const IOSOptions _iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock_this_device,
  );

  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(aOptions: _androidOptions);

  Future<void> write({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value, iOptions: _iosOptions);
  }

  Future<void> writeList({required String key, required List<String> value}) async {
    await _secureStorage.write(key: key, value: jsonEncode(value), iOptions: _iosOptions);
  }

  Future<String?> read({required String key}) async {
    return await _secureStorage.read(key: key, iOptions: _iosOptions);
  }

  Future<List<String>?> readList({required String key}) async {
    final String? value = await _secureStorage.read(key: key, iOptions: _iosOptions);
    final list = jsonDecode(value!) as List;
    return list.map((element) => element.toString()).toList();
  }

  Future<void> delete({required String key}) async {
    await _secureStorage.delete(key: key, iOptions: _iosOptions);
  }

  Future<void> clear() async {
    await _secureStorage.deleteAll(iOptions: _iosOptions);
  }

  Future<List<String>> getAllKeysContaining({required String search}) async {
    final keys = (await _secureStorage.readAll(iOptions: _iosOptions)).keys;
    return keys.where((element) => element.toUpperCase().contains(search.toUpperCase())).toList();
  }
}
