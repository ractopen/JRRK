import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const EcoScanApp());
}

class EcoScanApp extends StatelessWidget {
  const EcoScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoScan+',
      theme: EcoScanTheme.theme,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.register: (_) => const RegisterScreen(),
        AppRoutes.otp: (_) => const OtpScreen(),
        AppRoutes.passwordSetup: (_) => const PasswordSetupScreen(),
        AppRoutes.userPortal: (_) => const UserPortalScreen(),
        AppRoutes.adminPortal: (_) => const AdminPortalScreen(),
        AppRoutes.chat: (_) => const ChatScreen(),
        AppRoutes.history: (_) => const HistoryScreen(),
        AppRoutes.analytics: (_) => const AnalyticsScreen(),
        AppRoutes.settings: (_) => const SettingsScreen(),
      },
    );
  }
}

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String passwordSetup = '/password-setup';
  static const String userPortal = '/user-portal';
  static const String adminPortal = '/admin-portal';
  static const String chat = '/chat';
  static const String history = '/history';
  static const String analytics = '/analytics';
  static const String settings = '/settings';
}

class EcoScanTheme {
  static const Color peach = Color(0xFFF9CBB0);
  static const Color cream = Color(0xFFFCEEE4);
  static const Color mistTeal = Color(0xFFA2C6CE);
  static const Color forestPine = Color(0xFF38616B);
  static const Color slateWhite = Color(0xFFF9FAFB);
  static const Color charcoal = Color(0xFF111111);
  static const Color slate = Color(0xFF5F6771);
  static const Color border = Color(0xFFE5E7EB);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: slateWhite,
      colorScheme: ColorScheme.fromSeed(
        seedColor: forestPine,
        primary: forestPine,
        secondary: mistTeal,
        surface: Colors.white,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w900,
          color: charcoal,
          letterSpacing: -0.7,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: charcoal,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: forestPine, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        hintStyle: const TextStyle(color: Color(0xFF8A8F96), fontSize: 15),
      ),
    );
  }
}

void showPlaceholderDialog(BuildContext context, String feature) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Feature Placeholder'),
      content: Text('$feature is ready for future product integration and design handoff.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

void logoutAndReturnToLogin(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
}

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              EcoScanTheme.peach,
              EcoScanTheme.cream,
              EcoScanTheme.mistTeal,
              EcoScanTheme.forestPine,
            ],
            stops: [0.0, 0.35, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
      final route = _role.value == 'Admin' ? AppRoutes.adminPortal : AppRoutes.userPortal;
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
    return AuthScaffold(
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
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  decoration: const InputDecoration(hintText: 'Email address'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: _validatePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                onTap: () => Navigator.pushNamed(context, AppRoutes.register),
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
      Navigator.pushNamed(context, AppRoutes.otp);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
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
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              decoration: const InputDecoration(hintText: 'Email address'),
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
    Navigator.pushReplacementNamed(context, AppRoutes.passwordSetup);
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
    return AuthScaffold(
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
      Navigator.pushReplacementNamed(context, AppRoutes.userPortal);
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
    return AuthScaffold(
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

class UserPortalScreen extends StatefulWidget {
  const UserPortalScreen({super.key});

  @override
  State<UserPortalScreen> createState() => _UserPortalScreenState();
}

class _UserPortalScreenState extends State<UserPortalScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = const [
    DashboardTab(),
    SearchTab(),
    CreateTab(),
    ActivityTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoScanTheme.slateWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu_rounded, size: 28),
          ),
        ),
        title: const Text(
          'EcoScan+',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: EcoScanTheme.charcoal,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.chat),
            icon: const Icon(Icons.chat_bubble_outline_rounded),
          ),
          IconButton(
            onPressed: () => showPlaceholderDialog(context, 'Notifications'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: [
              Row(
                children: const [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: EcoScanTheme.peach,
                    child: Icon(Icons.person_rounded, color: EcoScanTheme.charcoal),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Profile',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: EcoScanTheme.charcoal,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'user@ecoscan.app',
                          style: TextStyle(color: EcoScanTheme.slate, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...[
                'Dashboard',
                'Chat Support',
                'Activity',
                'History',
                'Analytics',
                'Settings',
                'Log Out',
              ].map(
                (item) => ListTile(
                  title: Text(item),
                  onTap: () {
                    Navigator.pop(context);
                    switch (item) {
                      case 'Dashboard':
                        setState(() => _selectedIndex = 0);
                        break;
                      case 'Chat Support':
                        Navigator.pushNamed(context, AppRoutes.chat);
                        break;
                      case 'Activity':
                        setState(() => _selectedIndex = 3);
                        break;
                      case 'History':
                        Navigator.pushNamed(context, AppRoutes.history);
                        break;
                      case 'Analytics':
                        Navigator.pushNamed(context, AppRoutes.analytics);
                        break;
                      case 'Settings':
                        Navigator.pushNamed(context, AppRoutes.settings);
                        break;
                      case 'Log Out':
                        logoutAndReturnToLogin(context);
                        break;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) => setState(() => _selectedIndex = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search_rounded), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.add_circle_outline_rounded), label: 'Create'),
          NavigationDestination(icon: Icon(Icons.notifications_none_rounded), label: 'Activity'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [EcoScanTheme.peach, EcoScanTheme.mistTeal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome back, user@example.com',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: EcoScanTheme.charcoal,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your next eco opportunity is ready to be organized and explored.',
                  style: TextStyle(color: EcoScanTheme.slate, fontSize: 14, height: 1.6),
                ),
                const SizedBox(height: 18),
                PrimaryButton(
                  label: 'Scan Now',
                  onPressed: () => showPlaceholderDialog(context, 'Quick Scan Flow'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              QuickActionCard(title: 'Entry', icon: Icons.add_rounded, onTap: () => showPlaceholderDialog(context, 'New Entry')),
              QuickActionCard(title: 'Insights', icon: Icons.insights_rounded, onTap: () => Navigator.pushNamed(context, AppRoutes.analytics)),
              QuickActionCard(title: 'History', icon: Icons.history_rounded, onTap: () => Navigator.pushNamed(context, AppRoutes.history)),
              QuickActionCard(title: 'Support', icon: Icons.support_agent_rounded, onTap: () => Navigator.pushNamed(context, AppRoutes.chat)),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Recent Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 10),
          const EmptyStatePanel(label: 'Overview panel ready for future integration'),
        ],
      ),
    );
  }
}

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search items, records or actions',
              prefixIcon: const Icon(Icons.search_rounded, color: EcoScanTheme.slate),
              suffixIcon: IconButton(
                onPressed: () => showPlaceholderDialog(context, 'Search Reset'),
                icon: const Icon(Icons.close_rounded, color: EcoScanTheme.slate),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Search results',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 12),
          const EmptyStatePanel(label: 'Search result placeholder waiting for live index data'),
        ],
      ),
    );
  }
}

class CreateTab extends StatelessWidget {
  const CreateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create / Add Entry',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: EcoScanTheme.border),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'New Record',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: EcoScanTheme.charcoal,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Use this workflow to create a structured item when your data model is connected.',
                  style: TextStyle(color: EcoScanTheme.slate, fontSize: 14),
                ),
                const SizedBox(height: 18),
                PrimaryButton(
                  label: 'Add New Record',
                  onPressed: () => showPlaceholderDialog(context, 'Create Entry Modal'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityTab extends StatelessWidget {
  const ActivityTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Activity & Notifications',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                FilterChipOption(label: 'All', selected: true),
                FilterChipOption(label: 'Category 1'),
                FilterChipOption(label: 'Category 2'),
                FilterChipOption(label: 'Category 3'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ActivityListItem(
            username: 'Alicia Chen',
            time: '2 min ago',
            message: 'Shared a new review on the latest update.',
            unread: true,
            onPressed: () => showPlaceholderDialog(context, 'Activity Detail'),
          ),
          ActivityListItem(
            username: 'Mark Lopez',
            time: '1 hour ago',
            message: 'Uploaded a new project snapshot for review.',
            unread: false,
            onPressed: () => showPlaceholderDialog(context, 'Activity Detail'),
          ),
          ActivityListItem(
            username: 'Nia Patel',
            time: 'Today',
            message: 'Commented on a new entry from the team queue.',
            unread: true,
            onPressed: () => showPlaceholderDialog(context, 'Activity Detail'),
          ),
        ],
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 46,
                backgroundColor: EcoScanTheme.mistTeal,
                child: Icon(Icons.person_rounded, size: 42, color: EcoScanTheme.charcoal),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: EcoScanTheme.charcoal,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit_rounded, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'user@ecoscan.app',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 18),
          const EmptyStatePanel(label: 'Profile summary placeholder ready for connected metrics'),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: EcoScanTheme.border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ProfileQuickLink(title: 'Account', icon: Icons.person_outline_rounded, onTap: () => showPlaceholderDialog(context, 'Account Settings')),
                ProfileQuickLink(title: 'Privacy & Security', icon: Icons.lock_outline_rounded, onTap: () => showPlaceholderDialog(context, 'Privacy & Security')),
                ProfileQuickLink(title: 'Notifications', icon: Icons.notifications_none_rounded, onTap: () => showPlaceholderDialog(context, 'Notifications')),
                ProfileQuickLink(title: 'Theme', icon: Icons.dark_mode_outlined, onTap: () => showPlaceholderDialog(context, 'Theme Settings')),
                ProfileQuickLink(title: 'About', icon: Icons.info_outline_rounded, onTap: () => showPlaceholderDialog(context, 'About')),
                ProfileQuickLink(title: 'Log Out', icon: Icons.logout_rounded, onTap: () => logoutAndReturnToLogin(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdminPortalScreen extends StatefulWidget {
  const AdminPortalScreen({super.key});

  @override
  State<AdminPortalScreen> createState() => _AdminPortalScreenState();
}

class _AdminPortalScreenState extends State<AdminPortalScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = const [
    AdminOverviewTab(),
    AdminUsersTab(),
    AdminModerationTab(),
    AdminLogsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoScanTheme.slateWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu_rounded, size: 28),
          ),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'EcoScan+',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: EcoScanTheme.charcoal,
              ),
            ),
            SizedBox(width: 8),
            Chip(
              label: Text('Admin Mode'),
              side: BorderSide(color: EcoScanTheme.border),
              backgroundColor: EcoScanTheme.cream,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showPlaceholderDialog(context, 'Admin Notifications'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: [
              const Text(
                'Admin Portal',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: EcoScanTheme.charcoal,
                ),
              ),
              const SizedBox(height: 20),
              ...[
                'Admin Dashboard',
                'User Management',
                'Content Moderation',
                'System Logs',
                'Settings',
                'Log Out',
              ].map(
                (item) => ListTile(
                  title: Text(item),
                  onTap: () {
                    Navigator.pop(context);
                    switch (item) {
                      case 'Admin Dashboard':
                        setState(() => _selectedIndex = 0);
                        break;
                      case 'User Management':
                        setState(() => _selectedIndex = 1);
                        break;
                      case 'Content Moderation':
                        setState(() => _selectedIndex = 2);
                        break;
                      case 'System Logs':
                        setState(() => _selectedIndex = 3);
                        break;
                      case 'Settings':
                        Navigator.pushNamed(context, AppRoutes.settings);
                        break;
                      case 'Log Out':
                        logoutAndReturnToLogin(context);
                        break;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) => setState(() => _selectedIndex = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_rounded), label: 'Overview'),
          NavigationDestination(icon: Icon(Icons.groups_rounded), label: 'Users'),
          NavigationDestination(icon: Icon(Icons.shield_rounded), label: 'Moderation'),
          NavigationDestination(icon: Icon(Icons.list_alt_rounded), label: 'Logs'),
        ],
      ),
    );
  }
}

class AdminOverviewTab extends StatelessWidget {
  const AdminOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'System overview',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: EcoScanTheme.charcoal),
          ),
          SizedBox(height: 16),
          EmptyStatePanel(label: 'Total Users placeholder'),
          SizedBox(height: 12),
          EmptyStatePanel(label: 'Pending Actions placeholder'),
          SizedBox(height: 12),
          EmptyStatePanel(label: 'Server Status placeholder'),
        ],
      ),
    );
  }
}

class AdminUsersTab extends StatelessWidget {
  const AdminUsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User management',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: EcoScanTheme.charcoal),
          ),
          const SizedBox(height: 16),
          UserManagementRow(
            name: 'Aida Moore',
            email: 'aida@ecoscan.app',
            role: 'Admin',
            onToggle: () => showPlaceholderDialog(context, 'User status toggle'),
            onEdit: () => showPlaceholderDialog(context, 'Edit user'),
          ),
          UserManagementRow(
            name: 'Ethan Hill',
            email: 'ethan@ecoscan.app',
            role: 'User',
            onToggle: () => showPlaceholderDialog(context, 'User status toggle'),
            onEdit: () => showPlaceholderDialog(context, 'Edit user'),
          ),
          UserManagementRow(
            name: 'Sofia Reed',
            email: 'sofia@ecoscan.app',
            role: 'Moderator',
            onToggle: () => showPlaceholderDialog(context, 'User status toggle'),
            onEdit: () => showPlaceholderDialog(context, 'Edit user'),
          ),
        ],
      ),
    );
  }
}

class AdminModerationTab extends StatelessWidget {
  const AdminModerationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Moderation queue',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: EcoScanTheme.charcoal),
          ),
          const SizedBox(height: 16),
          ModerationItemCard(
            title: 'Pending content review',
            description: 'New update requires a final moderation decision before release.',
            onApprove: () => showPlaceholderDialog(context, 'Approve item'),
            onReject: () => showPlaceholderDialog(context, 'Reject item'),
          ),
          ModerationItemCard(
            title: 'Review flagged activity',
            description: 'A user-submitted record was flagged for manual compliance review.',
            onApprove: () => showPlaceholderDialog(context, 'Approve item'),
            onReject: () => showPlaceholderDialog(context, 'Reject item'),
          ),
        ],
      ),
    );
  }
}

class AdminLogsTab extends StatelessWidget {
  const AdminLogsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'System logs',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: EcoScanTheme.charcoal),
          ),
          SizedBox(height: 16),
          EmptyStatePanel(label: 'System log stream placeholder for audit and debugging data'),
        ],
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: EcoScanTheme.mistTeal,
              child: Icon(Icons.support_agent_rounded, size: 18, color: EcoScanTheme.charcoal),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer Service', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                Text('Online', style: TextStyle(fontSize: 11, color: EcoScanTheme.slate)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () => showPlaceholderDialog(context, 'Voice call'), icon: const Icon(Icons.call_outlined)),
          IconButton(onPressed: () => showPlaceholderDialog(context, 'Video call'), icon: const Icon(Icons.videocam_outlined)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _ChatBubble(text: 'Hi there! How can I help you today?', isIncoming: true),
                    const SizedBox(height: 12),
                    const _ChatBubble(text: 'I need help with my account setup.', isIncoming: false),
                    const SizedBox(height: 12),
                    const _ChatBubble(text: 'Absolutely. We can review your onboarding status and guide the next step.', isIncoming: true),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: EcoScanTheme.border)),
              ),
              child: Row(
                children: [
                  IconButton(onPressed: () => showPlaceholderDialog(context, 'Voice note'), icon: const Icon(Icons.mic_none_rounded)),
                  IconButton(onPressed: () => showPlaceholderDialog(context, 'Emoji picker'), icon: const Icon(Icons.emoji_emotions_outlined)),
                  IconButton(onPressed: () => showPlaceholderDialog(context, 'Attachment upload'), icon: const Icon(Icons.attach_file_rounded)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: EcoScanTheme.slateWhite,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: EcoScanTheme.border),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Text('Type a message', style: TextStyle(color: EcoScanTheme.slate)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: EcoScanTheme.charcoal,
                    child: IconButton(
                      onPressed: () => showPlaceholderDialog(context, 'Send message'),
                      icon: const Icon(Icons.send_rounded, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.text, required this.isIncoming});

  final String text;
  final bool isIncoming;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isIncoming ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isIncoming ? const Color(0xFFE5E7EB) : EcoScanTheme.charcoal,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isIncoming ? EcoScanTheme.charcoal : Colors.white,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          children: const [
            EmptyStatePanel(label: 'Chronological history placeholder ready for connected records'),
          ],
        ),
      ),
    );
  }
}

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            EmptyStatePanel(label: 'Main graph placeholder'),
            SizedBox(height: 12),
            EmptyStatePanel(label: 'Performance summary placeholder'),
            SizedBox(height: 12),
            EmptyStatePanel(label: 'Insights panel placeholder'),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          children: [
            SettingsSectionTile(title: 'Account', icon: Icons.person_outline_rounded, onTap: () => showPlaceholderDialog(context, 'Account Settings')),
            SettingsSectionTile(title: 'Privacy & Security', icon: Icons.lock_outline_rounded, onTap: () => showPlaceholderDialog(context, 'Privacy & Security')),
            SettingsSectionTile(title: 'Notifications', icon: Icons.notifications_none_rounded, onTap: () => showPlaceholderDialog(context, 'Notifications')),
            SettingsSectionTile(title: 'Theme', icon: Icons.dark_mode_outlined, onTap: () => showPlaceholderDialog(context, 'Theme Settings')),
            SettingsSectionTile(title: 'About', icon: Icons.info_outline_rounded, onTap: () => showPlaceholderDialog(context, 'About')),
            SettingsSectionTile(title: 'Log Out', icon: Icons.logout_rounded, onTap: () => logoutAndReturnToLogin(context)),
          ],
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: EcoScanTheme.charcoal,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        child: Text(label),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.label,
    required this.iconText,
    required this.onPressed,
  });

  final String label;
  final String iconText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: EcoScanTheme.charcoal,
          side: const BorderSide(color: EcoScanTheme.border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: EcoScanTheme.cream,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                iconText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: EcoScanTheme.charcoal,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: EcoScanTheme.charcoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFCBD3D7), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: const TextStyle(color: EcoScanTheme.slate, fontWeight: FontWeight.w600),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFCBD3D7), thickness: 1)),
      ],
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.onToggle,
    required this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggle;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: EcoScanTheme.slate,
          ),
        ),
      ),
    );
  }
}

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: EcoScanTheme.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: EcoScanTheme.peach,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: EcoScanTheme.charcoal),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: EcoScanTheme.charcoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityListItem extends StatelessWidget {
  const ActivityListItem({
    super.key,
    required this.username,
    required this.time,
    required this.message,
    required this.unread,
    required this.onPressed,
  });

  final String username;
  final String time;
  final String message;
  final bool unread;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: EcoScanTheme.border)),
        ),
        child: Row(
          children: [
            if (unread)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
            const CircleAvatar(
              radius: 20,
              backgroundColor: EcoScanTheme.mistTeal,
              child: Icon(Icons.person_rounded, size: 18, color: EcoScanTheme.charcoal),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: EcoScanTheme.charcoal,
                        ),
                      ),
                      Text(time, style: const TextStyle(fontSize: 11, color: EcoScanTheme.slate)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(message, style: const TextStyle(fontSize: 13, color: EcoScanTheme.slate)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: EcoScanTheme.slateWhite,
                border: Border.all(color: EcoScanTheme.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.chevron_right_rounded, color: EcoScanTheme.slate),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterChipOption extends StatelessWidget {
  const FilterChipOption({super.key, required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => showPlaceholderDialog(context, '$label filter'),
        backgroundColor: Colors.white,
        selectedColor: EcoScanTheme.charcoal,
        labelStyle: TextStyle(
          color: selected ? Colors.white : EcoScanTheme.charcoal,
          fontWeight: FontWeight.w600,
        ),
        side: const BorderSide(color: EcoScanTheme.border),
      ),
    );
  }
}

class ProfileQuickLink extends StatelessWidget {
  const ProfileQuickLink({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: EcoScanTheme.charcoal),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: EcoScanTheme.charcoal,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: EcoScanTheme.slate),
          ],
        ),
      ),
    );
  }
}

class UserManagementRow extends StatelessWidget {
  const UserManagementRow({
    super.key,
    required this.name,
    required this.email,
    required this.role,
    required this.onToggle,
    required this.onEdit,
  });

  final String name;
  final String email;
  final String role;
  final VoidCallback onToggle;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: EcoScanTheme.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: EcoScanTheme.mistTeal,
            child: Icon(Icons.person_rounded, color: EcoScanTheme.charcoal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: EcoScanTheme.charcoal,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: EcoScanTheme.cream,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        role,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: EcoScanTheme.charcoal,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(email, style: const TextStyle(fontSize: 12, color: EcoScanTheme.slate)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Switch.adaptive(value: true, onChanged: (_) => onToggle()),
          IconButton(onPressed: onEdit, icon: const Icon(Icons.edit_rounded)),
        ],
      ),
    );
  }
}

class ModerationItemCard extends StatelessWidget {
  const ModerationItemCard({
    super.key,
    required this.title,
    required this.description,
    required this.onApprove,
    required this.onReject,
  });

  final String title;
  final String description;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: EcoScanTheme.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(color: EcoScanTheme.slate, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onApprove,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: EcoScanTheme.charcoal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Approve'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: onReject,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Reject'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EmptyStatePanel extends StatelessWidget {
  const EmptyStatePanel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: EcoScanTheme.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: EcoScanTheme.slate,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class SettingsSectionTile extends StatelessWidget {
  const SettingsSectionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: EcoScanTheme.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: EcoScanTheme.charcoal),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right_rounded, color: EcoScanTheme.slate),
        onTap: onTap,
      ),
    );
  }
}
