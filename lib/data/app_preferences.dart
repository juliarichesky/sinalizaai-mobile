import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppPreferences {
  AppPreferences._();

  static final AppPreferences instance = AppPreferences._();
  static const _notificationsKey = 'sinaliza_notifications_enabled_v1';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final ValueNotifier<bool> notificationsEnabled = ValueNotifier(false);
  bool _usesMemoryFallback = false;
  String? _memoryNotificationsValue;

  Future<void> load() async {
    final value = await _readNotificationsValue();
    notificationsEnabled.value = value == 'true';
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    notificationsEnabled.value = enabled;
    final value = enabled.toString();
    if (_usesMemoryFallback) {
      _memoryNotificationsValue = value;
      return;
    }
    try {
      await _storage.write(key: _notificationsKey, value: value);
    } on MissingPluginException {
      _usesMemoryFallback = true;
      _memoryNotificationsValue = value;
    } on Exception {
      notificationsEnabled.value = !enabled;
    }
  }

  void configureInMemoryForTesting() {
    _usesMemoryFallback = true;
  }

  void resetForTesting() {
    _usesMemoryFallback = true;
    _memoryNotificationsValue = null;
    notificationsEnabled.value = false;
  }

  Future<String?> _readNotificationsValue() async {
    if (_usesMemoryFallback) {
      return _memoryNotificationsValue;
    }
    try {
      return await _storage.read(key: _notificationsKey);
    } on MissingPluginException {
      _usesMemoryFallback = true;
      return _memoryNotificationsValue;
    } on Exception {
      return null;
    }
  }
}
