import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;

      _controller.reverse(); // fade OUT splash

      Future.delayed(const Duration(milliseconds: 600), () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 600),
            pageBuilder: (context, animation, secondaryAnimation) =>
            const OnboardingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // LOGO
              Image.asset(
                'assets/images/app_logo.png',
                height: 190,
              ),

              const SizedBox(height: 36),

              // APP NAME
              const Text(
                'TeleMedi',
                style: TextStyle(
                  fontFamily: 'K2D',
                  fontSize: 38,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E7C9A),
                  letterSpacing: 0.8,
                ),
              ),

              const SizedBox(height: 12),

              // TAGLINE
              const Text(
                'Your Online Health Companion',
                style: TextStyle(
                  fontFamily: 'K2D',
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6FBFCC),
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
