import 'dart:convert';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/mock_user.dart';

part 'local_auth/local_auth_credentials.dart';
part 'local_auth/local_auth_storage.dart';

class LocalAuthException implements Exception {
  const LocalAuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Autenticação local demonstrativa, sem API ou banco externo.
///
/// As contas são armazenadas no armazenamento seguro do dispositivo. A senha
/// nunca é persistida: somente um hash derivado com salt aleatório é salvo.
class LocalAuthService {
  LocalAuthService._();

  static final LocalAuthService instance = LocalAuthService._();

  static const _accountsKey = 'sinaliza_local_accounts_v1';
  static const _sessionKey = 'sinaliza_local_session_email_v1';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final List<_StoredAccount> _memoryAccounts = [];
  String? _memorySessionEmail;
  bool _usesMemoryFallback = false;

  /// Evita chamadas de plataforma nos testes de widget, onde os plugins
  /// nativos não são registrados. No aplicativo, o armazenamento seguro é
  /// utilizado normalmente.
  void configureInMemoryForTesting() {
    _usesMemoryFallback = true;
  }

  void resetForTesting() {
    _usesMemoryFallback = true;
    _memoryAccounts.clear();
    _memorySessionEmail = null;
    clearActiveUser();
  }

  Future<MockUser?> restoreSession() async {
    final sessionEmail = await _readSessionEmail();
    if (sessionEmail == null) {
      clearActiveUser();
      return null;
    }

    final accounts = await _readAccounts();
    final matching = accounts.where((item) => item.email == sessionEmail);
    if (matching.isEmpty) {
      await logout();
      return null;
    }

    final user = matching.first.user;
    setActiveUser(user);
    return user;
  }

  Future<MockUser> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final normalizedEmail = _normalizeEmail(email);
    final accounts = await _readAccounts();
    if (accounts.any((item) => item.email == normalizedEmail)) {
      throw const LocalAuthException(
        'Não foi possível criar a conta com esses dados.',
      );
    }

    final user = MockUser(fullName: fullName.trim(), email: normalizedEmail);
    final salt = _createSalt();
    accounts.add(
      _StoredAccount(
        fullName: user.fullName,
        email: user.email,
        avatarUrl: user.avatarUrl,
        salt: salt,
        passwordHash: _hashPassword(password, salt),
        passwordAlgorithm: _passwordAlgorithm,
      ),
    );
    await _writeAccounts(accounts);
    return user;
  }

  Future<MockUser> login({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = _normalizeEmail(email);
    final accounts = await _readAccounts();
    final matching = accounts.where((item) => item.email == normalizedEmail);
    if (matching.isEmpty) {
      throw const LocalAuthException('E-mail ou senha incorretos.');
    }

    final account = matching.first;
    if (!_verifyPassword(password, account)) {
      throw const LocalAuthException('E-mail ou senha incorretos.');
    }

    await _writeSessionEmail(account.email);
    final user = account.user;
    setActiveUser(user);
    return user;
  }

  Future<MockUser> updateAvatarPath(String path) async {
    final current = activeUser;
    if (current == null) {
      throw const LocalAuthException('Nenhuma sessão ativa foi encontrada.');
    }

    final accounts = await _readAccounts();
    final index = accounts.indexWhere((item) => item.email == current.email);
    if (index < 0) {
      throw const LocalAuthException('Não foi possível atualizar a foto.');
    }

    final account = accounts[index];
    final updated = _StoredAccount(
      fullName: account.fullName,
      email: account.email,
      avatarUrl: path,
      salt: account.salt,
      passwordHash: account.passwordHash,
      passwordAlgorithm: account.passwordAlgorithm,
    );
    accounts[index] = updated;
    await _writeAccounts(accounts);
    final user = updated.user;
    setActiveUser(user);
    return user;
  }

  Future<void> logout() async {
    _memorySessionEmail = null;
    clearActiveUser();
    if (_usesMemoryFallback) {
      return;
    }
    try {
      await _storage.delete(key: _sessionKey);
    } on Exception {
      // Não impedir o encerramento visual da sessão por uma falha de leitura.
    }
  }


  static String _normalizeEmail(String email) => email.trim().toLowerCase();

}
