import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeNameField extends StatefulWidget {
  final TextEditingController controller;

  const WelcomeNameField({super.key, required this.controller});

  @override
  State<WelcomeNameField> createState() => _WelcomeNameFieldState();
}

class _WelcomeNameFieldState extends State<WelcomeNameField> {
  final FocusNode _focus = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() => _isFocused = _focus.hasFocus));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What should we call you?',
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: DColors.primary,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 10),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9.r),
            boxShadow: _isFocused
                ? [
              BoxShadow(
                color: DColors.primary.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ]
                : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.07),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: _isFocused
                  ? DColors.primary
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focus,
            textCapitalization: TextCapitalization.words,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D2417),
            ),
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: 'e.g. Sony, Dolon...',
              hintStyle: TextStyle(
                color: const Color(0xFF2D2417).withValues(alpha: 0.3),
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: _isFocused
                    ? DColors.primary
                    : const Color(0xFF2D2417).withValues(alpha: 0.3),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),

          ),
        ),
      ],
    );
  }
}