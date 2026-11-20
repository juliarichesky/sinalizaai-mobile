part of '../profile_screen.dart';

extension on ProfileScreen {
  Widget _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: showBottomNavigation
          ? AppBottomNavigation(
              selectedIndex: 4,
              onItemSelected: (index) => _handleNavigation(context, index),
            )
          : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 32,
                ),
                child: Column(
                  children: [
                    _ProfileHeader(
                      onBack: () => _goBack(context),
                      showBackButton: true,
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder<MockUser?>(
                      valueListenable: activeUserNotifier,
                      builder: (context, user, _) => _UserSummary(
                        user: user ?? mockUser,
                        onEditPhoto: () => _changePhoto(context),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...[
                      (Icons.person_outline, 'Meus dados'),
                      (Icons.settings_outlined, 'Preferências'),
                      (Icons.accessibility_new, 'Acessibilidade'),
                      (Icons.help_outline, 'Ajuda e suporte'),
                      (Icons.info_outline, 'Sobre o app'),
                    ].map(
                      (option) => Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: _ProfileOption(
                          icon: option.$1,
                          label: option.$2,
                          onTap: () => _openOption(context, option.$2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _SignOutButton(onTap: () => _confirmSignOut(context)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
