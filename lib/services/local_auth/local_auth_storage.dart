part of '../local_auth_service.dart';

extension on LocalAuthService {
  Future<List<_StoredAccount>> _readAccounts() async {
    if (_usesMemoryFallback) {
      return List<_StoredAccount>.of(_memoryAccounts);
    }
    try {
      final encoded = await _storage.read(
        key: LocalAuthService._accountsKey,
      );
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
        key: LocalAuthService._accountsKey,
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
      return await _storage.read(key: LocalAuthService._sessionKey);
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
      await _storage.write(
        key: LocalAuthService._sessionKey,
        value: email,
      );
    } on MissingPluginException {
      _usesMemoryFallback = true;
      _memorySessionEmail = email;
    } on Exception {
      throw const LocalAuthException('Não foi possível iniciar a sessão.');
    }
  }
}
