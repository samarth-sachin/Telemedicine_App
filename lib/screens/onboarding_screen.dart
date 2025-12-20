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

  // Splash / logo colors
  static const Color primaryColor = Color(0xFF2E7C9A);
  static const Color secondaryColor = Color(0xFF6FBFCC);

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: Icons.offline_bolt,
      title: 'Completely Offline',
      description:
      'No internet needed. TeleMedi works entirely offline, making healthcare accessible anywhere.',
    ),
    OnboardingPage(
      icon: Icons.psychology,
      title: 'Smart Health Guidance',
      description:
      'Get instant medical guidance based on symptoms using structured medical flows.',
    ),
    OnboardingPage(
      icon: Icons.history,
      title: 'Track Your Health',
      description:
      'Maintain a record of consultations and track symptom patterns over time.',
    ),
    OnboardingPage(
      icon: Icons.security,
      title: 'Privacy First',
      description:
      'All your health data stays on your device. No cloud. No tracking.',
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

  void _skipOnboarding() {
    _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    await PreferencesManager.setFirstLaunch(false);
    await PreferencesManager.setOnboardingComplete(true);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const ChatScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // same as splash
      body: SafeArea(
        child: Column(
          children: [
            // Skip button (logo theme)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skipOnboarding,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontFamily: 'K2D',
                      fontSize: 16,
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
                  return _buildPageContent(_pages[index]);
                },
              ),
            ),

            // Page indicators (logo color)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                    (index) => _buildPageIndicator(index),
              ),
            ),

            const SizedBox(height: 32),

            // Next / Get Started button (logo color)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
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

  Widget _buildPageContent(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container (UNCHANGED icon logic)
          Container(
            padding: const EdgeInsets.all(36),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              page.icon,
              size: 96,
              color: primaryColor, // icon stays consistent
            ),
          ),

          const SizedBox(height: 48),

          // Title (subtle, professional)
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'K2D',
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 18),

          // Description (safe non-null grey)
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

  Widget _buildPageIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: _currentPage == index
            ? primaryColor
            : const Color(0xFFE0E0E0),
      ),
    );
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
  });
}
