import 'widgets/welcome_header.dart';
import 'widgets/welcome_slogan.dart';
import 'package:flutter/material.dart';
import 'widgets/welcome_name_field.dart';
import 'widgets/welcome_background.dart';
import 'widgets/welcome_continue_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameCtrl = TextEditingController();
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  bool _canContinue = false;
  String _currentName = '';

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));

    _nameCtrl.addListener(() {

      final trimmed = _nameCtrl.text.trim();
      setState(() {
        _currentName = trimmed;
        _canContinue = trimmed.isNotEmpty;
      });
    });

    // Stagger the entrance animation
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _animCtrl.forward();
    });
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const WelcomeBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      const WelcomeHeader(),
                      const SizedBox(height: 36),
                      const WelcomeSlogan(),
                      const SizedBox(height: 48),
                      WelcomeNameField(controller: _nameCtrl),
                      const SizedBox(height: 28),
                      WelcomeContinueButton(
                        enabled: _canContinue,
                        name: _currentName
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}