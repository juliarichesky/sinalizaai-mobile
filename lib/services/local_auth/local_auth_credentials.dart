part of '../local_auth_service.dart';

String _createSalt() {
  final random = math.Random.secure();
  final bytes = List<int>.generate(16, (_) => random.nextInt(256));
  return base64UrlEncode(bytes);
}

const _passwordAlgorithm = 'pbkdf2-hmac-sha256-v1';
const _passwordIterations = 100000;

String _hashPassword(String password, String salt) {
  final passwordBytes = utf8.encode(password);
  final saltBytes = base64Url.decode(salt);
  final hmac = Hmac(sha256, passwordBytes);
  var block = hmac.convert([...saltBytes, 0, 0, 0, 1]).bytes;
  final derived = List<int>.of(block);

  for (var iteration = 1; iteration < _passwordIterations; iteration++) {
    block = hmac.convert(block).bytes;
    for (var index = 0; index < derived.length; index++) {
      derived[index] ^= block[index];
    }
  }
  return base64UrlEncode(derived);
}

bool _verifyPassword(String password, _StoredAccount account) {
  if (account.passwordAlgorithm == _passwordAlgorithm) {
    return _hashPassword(password, account.salt) == account.passwordHash;
  }
  final legacyHash = sha256
      .convert(utf8.encode('${account.salt}:$password'))
      .toString();
  return legacyHash == account.passwordHash;
}

class _StoredAccount {
  const _StoredAccount({
    required this.fullName,
    required this.email,
    required this.avatarUrl,
    required this.salt,
    required this.passwordHash,
    this.passwordAlgorithm,
  });

  final String fullName;
  final String email;
  final String? avatarUrl;
  final String salt;
  final String passwordHash;
  final String? passwordAlgorithm;

  MockUser get user =>
      MockUser(fullName: fullName, email: email, avatarUrl: avatarUrl);

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'avatarUrl': avatarUrl,
    'salt': salt,
    'passwordHash': passwordHash,
    'passwordAlgorithm': passwordAlgorithm,
  };

  factory _StoredAccount.fromJson(Map<String, dynamic> json) {
    return _StoredAccount(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      salt: json['salt'] as String,
      passwordHash: json['passwordHash'] as String,
      passwordAlgorithm: json['passwordAlgorithm'] as String?,
    );
  }
}
