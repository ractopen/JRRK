import 'package:flutter/material.dart';
import 'package:jrrk/core/custom_buttons.dart';
import 'package:jrrk/core/custom_inputs.dart';
import 'package:jrrk/core/eco_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<String> _role = ValueNotifier<String>('User');
  bool _obscurePassword = true;

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Please enter an email address.';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Please enter your password.';
    if (password.length < 6) return 'Password must be at least 6 characters.';
    return null;
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      final route = _role.value == 'Admin' ? '/admin-portal' : '/user-portal';
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _role.dispose();
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
            'Welcome Back',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Sign in to your account',
            style: TextStyle(color: EcoScanTheme.slate, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                EcoTextField(
                  controller: _emailController,
                  hintText: 'Email address',
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 16),
                EcoTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: _obscurePassword,
                  validator: _validatePassword,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: EcoScanTheme.slate,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: EcoScanTheme.border),
            ),
            child: ValueListenableBuilder<String>(
              valueListenable: _role,
              builder: (context, selectedRole, _) {
                return Row(
                  children: [
                    Expanded(
                      child: _RoleOption(
                        label: 'User',
                        selected: selectedRole == 'User',
                        onTap: () => _role.value = 'User',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _RoleOption(
                        label: 'Admin',
                        selected: selectedRole == 'Admin',
                        onTap: () => _role.value = 'Admin',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          PrimaryButton(label: 'Sign In', onPressed: _signIn),
          const SizedBox(height: 14),
          const DividerWithText(text: 'or'),
          const SizedBox(height: 12),
          SocialButton(
            label: 'Continue with Google',
            iconText: 'G',
            onPressed: () => showPlaceholderDialog(context, 'Google Sign-In'),
          ),
          const SizedBox(height: 8),
          SocialButton(
            label: 'Continue with Apple',
            iconText: '',
            onPressed: () => showPlaceholderDialog(context, 'Apple Sign-In'),
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text("Don't have an account? ", style: TextStyle(color: EcoScanTheme.slate)),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/register'),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: EcoScanTheme.charcoal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoleOption extends StatelessWidget {
  const _RoleOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? EcoScanTheme.charcoal : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: selected ? EcoScanTheme.charcoal : EcoScanTheme.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : EcoScanTheme.charcoal,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
