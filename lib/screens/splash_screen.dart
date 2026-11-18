import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _timer = Timer(const Duration(seconds: 2), _finishLoading);
  }

  void _finishLoading() {
    if (!mounted) {
      return;
    }

    setState(() => _showLoading = false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
            Align(
              alignment: const Alignment(0, -0.45),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sinaliza.Ai',
                      textAlign: TextAlign.center,
                      style: AppTypography.heading.copyWith(
                        color: Colors.white,
                        fontSize: 34,
                        shadows: const [
                          Shadow(color: AppColors.darkAmethyst, blurRadius: 8),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mobilidade inteligente, cidades mais seguras.',
                      textAlign: TextAlign.center,
                      style: AppTypography.subtitle.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        shadows: const [
                          Shadow(color: AppColors.darkAmethyst, blurRadius: 6),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_showLoading)
              const Positioned(
                bottom: 48,
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.sunflowerGold,
                      strokeWidth: 2.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
