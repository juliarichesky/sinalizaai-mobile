import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

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

  void _goToNextScreen() {
    if (!mounted || _hasStarted) {
      return;
    }

    setState(() => _hasStarted = true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => widget.nextScreen),
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

class _SplashIdentity extends StatelessWidget {
  const _SplashIdentity({required this.logoSize});

  final double logoSize;

  @override
  Widget build(BuildContext context) {
    final textShadow = const [
      Shadow(color: AppColors.darkAmethyst, blurRadius: 8),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: logoSize,
          height: logoSize / 1.5,
          fit: BoxFit.contain,
        ),
        Text(
          'Mobilidade inteligente,',
          textAlign: TextAlign.center,
          style: AppTypography.body.copyWith(
            color: Colors.white,
            fontSize: 19,
            height: 1.25,
            shadows: textShadow,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'cidades ',
              style: AppTypography.body.copyWith(
                color: Colors.white,
                fontSize: 19,
                height: 1.25,
                shadows: textShadow,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.hotRose.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(
                  'mais seguras.',
                  style: AppTypography.body.copyWith(
                    color: Colors.white,
                    fontSize: 19,
                    height: 1.15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          width: 72,
          height: 4,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.sunflowerGold, AppColors.hotRose],
            ),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      ],
    );
  }
}

class _SplashStartButton extends StatelessWidget {
  const _SplashStartButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Começar',
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: Material(
          color: Colors.transparent,
          elevation: 5,
          shadowColor: AppColors.darkAmethyst.withValues(alpha: 0.28),
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.hotRose.withValues(alpha: 0.92),
                  AppColors.hotRose,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Começar',
                    style: AppTypography.body.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
