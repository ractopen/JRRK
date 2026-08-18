import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jrrk/core/custom_buttons.dart';
import 'package:jrrk/core/eco_background.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  String get otpValue => _controllers.map((controller) => controller.text).join();

  bool get isOtpValid => RegExp(r'^\d{6}$').hasMatch(otpValue) && otpValue.length == 6;

  void _handleDigitChange(String value, int index) {
    if (value.length > 1) {
      final digits = value.replaceAll(RegExp(r'\D'), '');
      final nextValue = digits.isEmpty ? '' : digits.substring(digits.length - 1);
      _controllers[index].value = TextEditingValue(
        text: nextValue,
        selection: TextSelection.collapsed(offset: nextValue.length),
      );
    }
    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
    setState(() {});
  }

  void _verify() {
    if (!isOtpValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full 6-digit code.')),
      );
      return;
    }
    Navigator.pushReplacementNamed(context, '/password-setup');
  }

  void _resend() {
    for (final controller in _controllers) {
      controller.clear();
    }
    FocusScope.of(context).requestFocus(_focusNodes.first);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('New verification code sent.')),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
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
            'Enter 6-Digit Code',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'We sent a confirmation code to your email.',
            style: TextStyle(color: EcoScanTheme.slate, fontSize: 15),
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) {
              return SizedBox(
                width: 42,
                child: TextFormField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  textInputAction: index == 5 ? TextInputAction.done : TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(counterText: '', contentPadding: EdgeInsets.zero),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: EcoScanTheme.charcoal,
                  ),
                  onChanged: (value) => _handleDigitChange(value, index),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          PrimaryButton(label: 'Verify', onPressed: _verify),
          const SizedBox(height: 18),
          TextButton(
            onPressed: _resend,
            child: const Text(
              'Resend Code',
              style: TextStyle(
                color: EcoScanTheme.charcoal,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
