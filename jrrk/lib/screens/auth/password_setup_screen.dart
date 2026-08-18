import 'package:flutter/material.dart';
import 'package:jrrk/core/custom_buttons.dart';
import 'package:jrrk/core/custom_inputs.dart';
import 'package:jrrk/core/eco_background.dart';

class PasswordSetupScreen extends StatefulWidget {
  const PasswordSetupScreen({super.key});

  @override
  State<PasswordSetupScreen> createState() => _PasswordSetupScreenState();
}

class _PasswordSetupScreenState extends State<PasswordSetupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter a password.';
    if (value.length < 6) return 'Password must be at least 6 characters.';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please confirm your password.';
    if (value != _passwordController.text) return 'Passwords do not match.';
    return null;
  }

  void _continue() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/user-portal');
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          const SizedBox(height: 28),
          const Text(
            'Create Password',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Set your account password to continue.',
            style: TextStyle(color: EcoScanTheme.slate, fontSize: 15),
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(
              children: [
                PasswordField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: _obscurePassword,
                  onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                  validator: _validatePassword,
                ),
                const SizedBox(height: 16),
                PasswordField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: _obscureConfirmPassword,
                  onToggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  validator: _validateConfirmPassword,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(label: 'Continue', onPressed: _continue),
        ],
      ),
    );
  }
}
