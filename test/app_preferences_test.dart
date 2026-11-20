import 'package:flutter_test/flutter_test.dart';
import 'package:sinaliza_ai/data/app_preferences.dart';

void main() {
  final preferences = AppPreferences.instance;

  setUp(preferences.resetForTesting);

  test('persiste e restaura a preferência de notificações', () async {
    await preferences.setNotificationsEnabled(true);
    preferences.notificationsEnabled.value = false;

    await preferences.load();

    expect(preferences.notificationsEnabled.value, isTrue);
  });

  test('usa falso quando nenhuma preferência foi salva', () async {
    preferences.notificationsEnabled.value = true;

    await preferences.load();

    expect(preferences.notificationsEnabled.value, isFalse);
  });
}
