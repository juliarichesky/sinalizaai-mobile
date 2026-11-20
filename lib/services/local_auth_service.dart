import 'dart:convert';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/mock_user.dart';

class LocalAuthException implements Exception {
  const LocalAuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Autenticação local demonstrativa, sem API ou banco externo.
///
/// As contas são armazenadas no armazenamento seguro do dispositivo. A senha
/// nunca é persistida: somente um hash SHA-256 com salt aleatório é salvo.
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
    if (_hashPassword(password, account.salt) != account.passwordHash) {
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

  Future<List<_StoredAccount>> _readAccounts() async {
    if (_usesMemoryFallback) {
      return List<_StoredAccount>.of(_memoryAccounts);
    }
    try {
      final encoded = await _storage.read(key: _accountsKey);
      if (encoded == null || encoded.isEmpty) {
        return [];
      }
      final decoded = jsonDecode(encoded);
      if (decoded is! List) {
        return [];
      }
      return decoded
          .whereType<Map>()
          .map(
            (item) => _StoredAccount.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
    } on MissingPluginException {
      _usesMemoryFallback = true;
      return List<_StoredAccount>.of(_memoryAccounts);
    } on FormatException {
      throw const LocalAuthException(
        'Não foi possível recuperar as contas salvas.',
      );
    } on Exception {
      throw const LocalAuthException(
        'Não foi possível recuperar as contas salvas.',
      );
    }
  }

  Future<void> _writeAccounts(List<_StoredAccount> accounts) async {
    if (_usesMemoryFallback) {
      _memoryAccounts
        ..clear()
        ..addAll(accounts);
      return;
    }
    try {
      await _storage.write(
        key: _accountsKey,
        value: jsonEncode(accounts.map((item) => item.toJson()).toList()),
      );
    } on MissingPluginException {
      _usesMemoryFallback = true;
      _memoryAccounts
        ..clear()
        ..addAll(accounts);
    } on Exception {
      throw const LocalAuthException('Não foi possível salvar a conta.');
    }
  }

  Future<String?> _readSessionEmail() async {
    if (_usesMemoryFallback) {
      return _memorySessionEmail;
    }
    try {
      return await _storage.read(key: _sessionKey);
    } on MissingPluginException {
      _usesMemoryFallback = true;
      return _memorySessionEmail;
    } on Exception {
      throw const LocalAuthException(
        'Não foi possível recuperar a sessão salva.',
      );
    }
  }

  Future<void> _writeSessionEmail(String email) async {
    if (_usesMemoryFallback) {
      _memorySessionEmail = email;
      return;
    }
    try {
      await _storage.write(key: _sessionKey, value: email);
    } on MissingPluginException {
      _usesMemoryFallback = true;
      _memorySessionEmail = email;
    } on Exception {
      throw const LocalAuthException('Não foi possível iniciar a sessão.');
    }
  }

  static String _normalizeEmail(String email) => email.trim().toLowerCase();

  static String _createSalt() {
    final random = math.Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64UrlEncode(bytes);
  }

  static String _hashPassword(String password, String salt) {
    return sha256.convert(utf8.encode('$salt:$password')).toString();
  }
}

class _StoredAccount {
  const _StoredAccount({
    required this.fullName,
    required this.email,
    required this.avatarUrl,
    required this.salt,
    required this.passwordHash,
  });

  final String fullName;
  final String email;
  final String? avatarUrl;
  final String salt;
  final String passwordHash;

  MockUser get user =>
      MockUser(fullName: fullName, email: email, avatarUrl: avatarUrl);

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'avatarUrl': avatarUrl,
    'salt': salt,
    'passwordHash': passwordHash,
  };

  factory _StoredAccount.fromJson(Map<String, dynamic> json) {
    return _StoredAccount(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      salt: json['salt'] as String,
      passwordHash: json['passwordHash'] as String,
    );
  }
}
