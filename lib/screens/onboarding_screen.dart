import 'package:flutter/material.dart';
import '../storage/preferences_manager.dart';
import 'chat_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Brand colors (for dots & buttons only)
  static const Color primaryColor = Color(0xFF2E7C9A);
  static const Color secondaryColor = Color(0xFF6FBFCC);

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: Icons.offline_bolt,
      title: 'Completely Offline',
      description:
      'No internet needed. TeleMedi works entirely offline, making healthcare accessible anywhere.',
      iconColor: const Color(0xFFFF6B6B), // Red
    ),
    OnboardingPage(
      icon: Icons.psychology,
      title: 'Smart Health Guidance',
      description:
      'Get instant medical guidance based on symptoms using structured medical flows.',
      iconColor: const Color(0xFFDA74EA), // Purple
    ),
    OnboardingPage(
      icon: Icons.history,
      title: 'Track Your Health',
      description:
      'Maintain a record of consultations and track symptom patterns over time.',
      iconColor: const Color(0xFFFFAB31), // Orange
    ),
    OnboardingPage(
      icon: Icons.security,
      title: 'Privacy First',
      description:
      'All your health data stays on your device. No cloud. No tracking.',
      iconColor: const Color(0xFF2ABA2A), // Green
    ),
  ];

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    await PreferencesManager.setFirstLaunch(false);
    await PreferencesManager.setOnboardingComplete(true);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ChatScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontFamily: 'K2D',
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                    (i) => _buildIndicator(i),
              ),
            ),

            const SizedBox(height: 32),

            // Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _currentPage == _pages.length - 1
                        ? 'Get Started'
                        : 'Next',
                    style: const TextStyle(
                      fontFamily: 'K2D',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon (semantic color)
          Container(
            padding: const EdgeInsets.all(36),
            decoration: BoxDecoration(
              color: page.iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              page.icon,
              size: 96,
              color: page.iconColor,
            ),
          ),

          const SizedBox(height: 48),

          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'K2D',
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            page.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'K2D',
              fontSize: 16,
              color: Color(0xFF757575),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    final bool active = _currentPage == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: active
            ? const LinearGradient(
          colors: [primaryColor, secondaryColor],
        )
            : null,
        color: active ? null : const Color(0xFFE0E0E0),
      ),
    );
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  final Color iconColor;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.iconColor,
  });
}
