class MockUser {
  const MockUser({required this.fullName, required this.email, this.avatarUrl});

  final String fullName;
  final String email;
  final String? avatarUrl;

  String get initials {
    final names = fullName.trim().split(RegExp(r'\s+'));
    if (names.length == 1) {
      return names.first.substring(0, 1).toUpperCase();
    }
    return '${names.first.substring(0, 1)}${names.last.substring(0, 1)}'
        .toUpperCase();
  }
}

// Fonte única dos dados demonstrativos até a integração com a API.
const mockUser = MockUser(
  fullName: 'Julia Guimarães',
  email: 'julia@email.com',
);

MockUser? activeUser;

void setActiveUser(MockUser user) {
  activeUser = user;
}

void clearActiveUser() {
  activeUser = null;
}
