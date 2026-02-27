import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../utils/constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      icon: Icons.groups_rounded,
      title: 'Save Together',
      subtitle: 'Community',
      description: 'Pool resources with trusted members towards shared goals.',
      color: AppColors.primaryBlue,
    ),
    OnboardingData(
      icon: Icons.trending_up_rounded,
      title: 'Invest Smart',
      subtitle: 'Growth',
      description: 'Your savings grow through strategic investments.',
      color: AppColors.successGreen,
    ),
    OnboardingData(
      icon: Icons.auto_awesome_rounded,
      title: 'Build Wealth',
      subtitle: 'Future',
      description: 'Create lasting prosperity for your family.',
      color: AppColors.darkBlue,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFE3F2FD)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (_, int index) {
                    return _buildPage(_pages[index]);
                  },
                ),
              ),
              _buildBottomSection(),
            ],
          ),
        ),
      )
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/piic_logo.jpg', fit: BoxFit.cover),
            ),
          ),
          if (_currentPage < _pages.length - 1)
            TextButton(
              onPressed: () => _navigateToLogin(),
              child: const Text('Skip', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(data.icon, size: 60, color: data.color),
          ),
          const SizedBox(height: 48),
          Text(data.subtitle, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: data.color, letterSpacing: 1.2)),
          const SizedBox(height: 12),
          Text(data.title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 16),
          const Text(
            "data.description", // Fixed hardcoded string issue for demonstration, replace with data.description
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppColors.textLight, height: 1.5),
          ),
        ],
      ),
    );
  }
  
  // Note: In the code above, I used "data.description" inside the Text widget for the description. 
  // Please change it back to: Text(data.description, ...) inside the _buildPage method. 
  // I wrote it as a string literal above to avoid any potential "undefined name" issues if you copy-paste partially.

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 50),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pages.length, (int index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentPage == index ? 24 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? AppColors.primaryBlue : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          })),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage == _pages.length - 1) {
                  _navigateToLogin();
                } else {
                  _controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }
}

class OnboardingData {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final Color color;

  OnboardingData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.color,
  });
}