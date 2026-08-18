import 'package:flutter/material.dart';
import 'package:jrrk/core/custom_buttons.dart';
import 'package:jrrk/core/custom_inputs.dart';
import 'package:jrrk/core/eco_background.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Please enter an email address.';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  void _continue() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/otp');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EcoBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Text(
              'EcoScan+',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                color: EcoScanTheme.charcoal,
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Create an account',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Enter your email to get started.',
            style: TextStyle(color: EcoScanTheme.slate, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: EcoTextField(
              controller: _emailController,
              hintText: 'Email address',
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
          ),
          const SizedBox(height: 12),
          PrimaryButton(label: 'Continue', onPressed: _continue),
          const SizedBox(height: 12),
          const DividerWithText(text: 'or'),
          const SizedBox(height: 12),
          SocialButton(
            label: 'Continue with Google',
            iconText: 'G',
            onPressed: () => showPlaceholderDialog(context, 'Google Sign-Up'),
          ),
          const SizedBox(height: 8),
          SocialButton(
            label: 'Continue with Apple',
            iconText: '',
            onPressed: () => showPlaceholderDialog(context, 'Apple Sign-Up'),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'By clicking continue, you agree to our Terms of Service and Privacy Policy',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: EcoScanTheme.slate, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
