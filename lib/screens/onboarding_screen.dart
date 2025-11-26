import 'package:flutter/material.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  final Color themeBlue = const Color(0xFF4DA3FF);
  final Color themeGreen = const Color(0xFF8CC63F);
  final Color themeGold = const Color(0xFFFDBD00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() => isLastPage = index == 2);
        },
        children: [
          buildPage(
            icon: Icons.savings_rounded,
            title: 'Grow Your Pooled Savings',
            desc: 'Securely grow money together as a community.',
            color: themeBlue,
          ),
          buildPage(
            icon: Icons.house_rounded,
            title: 'Invest in Real Estate',
            desc: 'Your savings help you invest in long-term property.',
            color: themeGreen,
          ),
          buildPage(
            icon: Icons.groups_rounded,
            title: 'Wealth Creation for Generations',
            desc: 'Build sustainable wealth for yourself and your family.',
            color: themeGold,
          ),
        ],
      ),

      bottomSheet: isLastPage
          ? Container(
              height: 70,
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 55,
                    decoration: BoxDecoration(
                      color: themeBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Container(
              height: 70,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text('Skip'),
                    onPressed: () => _controller.jumpToPage(2),
                  ),
                  TextButton(
                    child: const Text('Next'),
                    onPressed: () => _controller.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildPage({
    required IconData icon,
    required String title,
    required String desc,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: color.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 120, color: color),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}
