import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../data/mock_user.dart';
import '../services/local_auth_service.dart';
import 'main_navigation_screen.dart';

part 'splash/splash_content.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.nextScreen});

  final Widget nextScreen;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  Future<void> _goToNextScreen() async {
    if (!mounted || _hasStarted) {
      return;
    }

    setState(() => _hasStarted = true);
    MockUser? user;
    try {
      user = await LocalAuthService.instance.restoreSession();
    } on LocalAuthException {
      user = null;
    }
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) =>
            user == null ? widget.nextScreen : const MainNavigationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/splash_img.png', fit: BoxFit.cover),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final logoSize = (constraints.maxWidth * 0.72)
                      .clamp(260.0, 330.0)
                      .toDouble();

                  return Column(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: const Alignment(0, -0.36),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: _SplashIdentity(logoSize: logoSize),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                        child: _SplashStartButton(
                          onPressed: _hasStarted ? null : _goToNextScreen,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

