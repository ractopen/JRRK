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
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.otp: (_) => const OtpScreen(),
        AppRoutes.passwordSetup: (_) => const PasswordSetupScreen(),
        AppRoutes.dashboard: (_) => const MainNavigationShell(),
        AppRoutes.activity: (_) => const ActivityPage(),
        AppRoutes.chat: (_) => const ChatScreen(),
        AppRoutes.history: (_) => const HistoryPage(),
        AppRoutes.analytics: (_) => const AnalyticsPage(),
        AppRoutes.settings: (_) => const SettingsPage(),
      },
      theme: EcoScanTheme.theme,
    );
  }
}

class AppRoutes {
  static const String login = '/login';
  static const String otp = '/otp';
  static const String passwordSetup = '/password-setup';
  static const String dashboard = '/dashboard';
  static const String activity = '/activity';
  static const String chat = '/chat';
  static const String history = '/history';
  static const String analytics = '/analytics';
  static const String settings = '/settings';
}

class EcoScanTheme {
  static const Color peach = Color(0xFFF9CBB0);
  static const Color creamMist = Color(0xFFFCEEE4);
  static const Color tealMist = Color(0xFFA2C6CE);
  static const Color forestTeal = Color(0xFF38616B);
  static const Color charcoal = Color(0xFF111111);
  static const Color slate = Color(0xFF5F6771);
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color appBg = Color(0xFFF8F9FA);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: appBg,
      fontFamily: 'sans-serif',
      colorScheme: ColorScheme.fromSeed(
        seedColor: forestTeal,
        primary: forestTeal,
        secondary: tealMist,
        surface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: appBg,
        elevation: 0,
        foregroundColor: charcoal,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: forestTeal, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        hintStyle: const TextStyle(color: Color(0xFF8A8F96), fontSize: 15),
      ),
    );
  }
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
              EcoScanTheme.creamMist,
              EcoScanTheme.tealMist,
              EcoScanTheme.forestTeal,
            ],
            stops: [0.08, 0.38, 0.72, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'Please enter an email address.';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(trimmed)) {
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
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 18),
          const Center(
            child: Text(
              'EcoScan+',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: EcoScanTheme.charcoal,
                letterSpacing: -0.6,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Create an account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter your email to sign up for this app',
            style: TextStyle(color: EcoScanTheme.slate, fontSize: 15),
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.email],
              decoration: const InputDecoration(hintText: 'email@domain.com'),
              validator: _validateEmail,
            ),
          ),
          const SizedBox(height: 20),
          PrimaryButton(label: 'Continue', onPressed: _continue),
          const SizedBox(height: 26),
          const DividerWithText(text: 'or'),
          const SizedBox(height: 22),
          const SocialButton(label: 'Continue with Google', iconText: 'G'),
          const SizedBox(height: 12),
          const SocialButton(label: 'Continue with Apple', iconText: ''),
          const SizedBox(height: 22),
          const TermsText(),
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
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

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

  String get otpValue =>
      _controllers.map((controller) => controller.text).join();
  bool get isOtpValid =>
      otpValue.length == 6 && RegExp(r'^\d{6}$').hasMatch(otpValue);

  void _handleChange(String value, int index) {
    if (value.length > 1) {
      final digits = value.replaceAll(RegExp(r'\D'), '');
      final nextValue = digits.isEmpty
          ? ''
          : digits.substring(digits.length - 1);
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
        const SnackBar(content: Text('Please enter the full 6-digit OTP.')),
      );
      return;
    }
    Navigator.pushReplacementNamed(context, AppRoutes.passwordSetup);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 18),
          const Center(
            child: Text(
              'EcoScan+',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: EcoScanTheme.charcoal,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Create an account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter your otp to sign up for this app / check your email app',
            style: TextStyle(color: EcoScanTheme.slate, fontSize: 15),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) {
              return SizedBox(
                width: 42,
                child: TextFormField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: EcoScanTheme.charcoal,
                  ),
                  onChanged: (value) => _handleChange(value, index),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          PrimaryButton(label: 'Verify', onPressed: _verify),
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
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a password.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password.';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match.';
    }
    return null;
  }

  void _continue() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 18),
          const Center(
            child: Text(
              'EcoScan+',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: EcoScanTheme.charcoal,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Create an account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Setup Password for the account',
            style: TextStyle(color: EcoScanTheme.slate, fontSize: 15),
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                PasswordField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: _obscurePassword,
                  onToggle: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  validator: _validatePassword,
                ),
                const SizedBox(height: 16),
                PasswordField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: _obscureConfirmPassword,
                  onToggle: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  ),
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

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _selectedIndex = 0;

  void _handleTap(int index) {
    if (index == 2) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const CreateActionSheet(),
      );
      return;
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = const [
      HomeTab(),
      SearchTab(),
      SizedBox.shrink(),
      NotificationsTab(),
      ProfileTab(),
    ];

    return Scaffold(
      body: pages[_selectedIndex == 2 ? 0 : _selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _handleTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: EcoScanTheme.forestTeal,
        unselectedItemColor: Colors.grey.shade700,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_rounded),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: const Text('5'),
              child: const Icon(Icons.notifications_rounded),
            ),
            label: 'Alerts',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoScanTheme.appBg,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, size: 28),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('EcoScan+'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.chat),
            icon: const Icon(Icons.chat_bubble_outline_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 10),
              const Text(
                'EcoScan+',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: EcoScanTheme.charcoal,
                ),
              ),
              const SizedBox(height: 24),
              DrawerItem(
                label: 'Home',
                icon: Icons.home_rounded,
                onTap: () => Navigator.pop(context),
              ),
              DrawerItem(
                label: 'Activity',
                icon: Icons.bar_chart_rounded,
                onTap: () => Navigator.pushNamed(context, AppRoutes.activity),
              ),
              DrawerItem(
                label: 'History',
                icon: Icons.history_rounded,
                onTap: () => Navigator.pushNamed(context, AppRoutes.history),
              ),
              DrawerItem(
                label: 'Analytics',
                icon: Icons.insights_rounded,
                onTap: () => Navigator.pushNamed(context, AppRoutes.analytics),
              ),
              DrawerItem(
                label: 'Settings',
                icon: Icons.settings_rounded,
                onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
              ),
              DrawerItem(
                label: 'Chat',
                icon: Icons.chat_bubble_outline_rounded,
                onTap: () => Navigator.pushNamed(context, AppRoutes.chat),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [EcoScanTheme.peach, EcoScanTheme.tealMist],
                    ),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Welcome back, Explorer! 👋',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: EcoScanTheme.charcoal,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Your overview and metrics will appear here as data becomes available.',
                        style: TextStyle(
                          color: EcoScanTheme.slate,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                const Text(
                  'Quick actions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: EcoScanTheme.charcoal,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: ActionCard(
                        title: 'Upload',
                        subtitle: 'Ready for file intake',
                        icon: Icons.upload_file_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ActionCard(
                        title: 'Share',
                        subtitle: 'Send to team',
                        icon: Icons.share_rounded,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                const Text(
                  'Recent Overview',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: EcoScanTheme.charcoal,
                  ),
                ),
                const SizedBox(height: 12),
                const DashedPlaceholderBox(
                  height: 180,
                  label: 'Overview dashboard ready for future data',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _categories = [
    'All',
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
  ];
  int _selectedIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoScanTheme.appBg,
      appBar: AppBar(title: const Text('Search'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: IconButton(
                    onPressed: () => _searchController.clear(),
                    icon: const Icon(Icons.clear_rounded),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 46,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final active = index == _selectedIndex;
                    return ChoiceChip(
                      label: Text(_categories[index]),
                      selected: active,
                      onSelected: (_) => setState(() => _selectedIndex = index),
                      selectedColor: EcoScanTheme.charcoal,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black12),
                      labelStyle: TextStyle(
                        color: active ? Colors.white : EcoScanTheme.charcoal,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.05,
                  ),
                  itemBuilder: (context, index) => const DashedPlaceholderBox(
                    height: 120,
                    label: 'Result placeholder',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateActionSheet extends StatelessWidget {
  const CreateActionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Quick create',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: EcoScanTheme.charcoal,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: const [
                Expanded(
                  child: QuickActionTile(
                    label: 'Document',
                    icon: Icons.description_rounded,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: QuickActionTile(
                    label: 'Task',
                    icon: Icons.task_alt_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(
                  child: QuickActionTile(
                    label: 'Message',
                    icon: Icons.message_rounded,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: QuickActionTile(
                    label: 'Upload',
                    icon: Icons.upload_file_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            PrimaryButton(
              label: 'Create new',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoScanTheme.appBg,
      appBar: AppBar(title: const Text('Notifications'), centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          children: const [
            NotificationCard(
              title: 'New workflow update',
              subtitle:
                  'The dashboard is ready for future live data integration.',
              time: '2m ago',
            ),
            NotificationCard(
              title: 'Action required',
              subtitle: 'Review and complete the pending setup.',
              time: '15m ago',
              unread: true,
            ),
            NotificationCard(
              title: 'Shared with team',
              subtitle: 'A new update is ready for review.',
              time: '1h ago',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoScanTheme.appBg,
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 26),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      size: 46,
                      color: EcoScanTheme.charcoal,
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: EcoScanTheme.forestTeal,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Explorer',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: EcoScanTheme.charcoal,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Project workspace',
                style: TextStyle(color: EcoScanTheme.slate, fontSize: 14),
              ),
              const SizedBox(height: 24),
              Row(
                children: const [
                  Expanded(
                    child: ProfileStatCard(label: 'Status', value: 'Ready'),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ProfileStatCard(label: 'Role', value: 'Admin'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: const [
                    ProfileInfoRow(label: 'Email', value: 'user@ecoscan.app'),
                    Divider(height: 24),
                    ProfileInfoRow(label: 'Workspace', value: 'EcoScan+ Core'),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const SettingsListTile(
                label: 'Account',
                trailing: Icon(Icons.chevron_right_rounded),
              ),
              const SettingsListTile(
                label: 'Privacy & Security',
                trailing: Icon(Icons.chevron_right_rounded),
              ),
              const SettingsListTile(
                label: 'Appearance',
                trailing: Icon(Icons.chevron_right_rounded),
              ),
              const SettingsListTile(
                label: 'Log Out',
                trailing: Icon(Icons.logout_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoScanTheme.appBg,
      appBar: AppBar(title: const Text('Activity')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CategoryChip(label: 'Category 1'),
                    CategoryChip(label: 'Category 2'),
                    CategoryChip(label: 'Category 3'),
                    CategoryChip(label: 'Category 4'),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView(
                  children: const [
                    ActivityItem(
                      title: 'Workflow review',
                      action: 'Submitted',
                      time: '2m ago',
                    ),
                    ActivityItem(
                      title: 'New assignment',
                      action: 'Queued',
                      time: '18m ago',
                      unread: true,
                    ),
                    ActivityItem(
                      title: 'File processed',
                      action: 'Completed',
                      time: '1h ago',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<_ChatBubble> _messages = [
    const _ChatBubble(
      isOutgoing: false,
      text: 'Hello! How can we help you today?',
    ),
    const _ChatBubble(
      isOutgoing: true,
      text: 'I am setting up the workspace template.',
    ),
  ];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }
    setState(() {
      _messages.add(_ChatBubble(isOutgoing: true, text: text));
      _controller.clear();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoScanTheme.appBg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.person_rounded,
                color: EcoScanTheme.charcoal,
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer Service',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Chatted 11m ago',
                  style: TextStyle(fontSize: 12, color: EcoScanTheme.slate),
                ),
              ],
            ),
          ],
        ),
        actions: const [
          Icon(Icons.call_rounded),
          SizedBox(width: 8),
          Icon(Icons.videocam_rounded),
          SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: message.isOutgoing
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.72,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: message.isOutgoing
                            ? EcoScanTheme.charcoal
                            : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: message.isOutgoing
                            ? null
                            : Border.all(color: Colors.black12),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: message.isOutgoing
                              ? Colors.white
                              : EcoScanTheme.charcoal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.emoji_emotions_rounded),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file_rounded),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Message...',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: EcoScanTheme.charcoal,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _sendMessage,
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

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoScanTheme.appBg,
      appBar: AppBar(title: const Text('History')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: const DashedPlaceholderBox(
            height: 260,
            label: 'History timeline ready for future records',
          ),
        ),
      ),
    );
  }
}

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoScanTheme.appBg,
      appBar: AppBar(title: const Text('Analytics')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DashedPlaceholderBox(
                height: 180,
                label: 'No analytics data yet',
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Expanded(
                    child: DashedPlaceholderBox(
                      height: 120,
                      label: 'Trend placeholder',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: DashedPlaceholderBox(
                      height: 120,
                      label: 'Chart placeholder',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoScanTheme.appBg,
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          children: const [
            SettingsListTile(
              label: 'Account',
              trailing: Icon(Icons.chevron_right_rounded),
            ),
            SettingsListTile(
              label: 'Privacy & Security',
              trailing: Icon(Icons.chevron_right_rounded),
            ),
            SettingsListTile(
              label: 'Notifications',
              trailing: Icon(Icons.chevron_right_rounded),
            ),
            SettingsListTile(
              label: 'Appearance',
              trailing: Icon(Icons.chevron_right_rounded),
            ),
            SettingsListTile(
              label: 'Log Out',
              trailing: Icon(Icons.logout_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        child: Text(label),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.label, required this.iconText});

  final String label;
  final String iconText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: EcoScanTheme.charcoal,
          side: const BorderSide(color: Color(0xFFDBDBDB)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: EcoScanTheme.creamMist,
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
            style: const TextStyle(
              color: EcoScanTheme.slate,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFCBD3D7), thickness: 1)),
      ],
    );
  }
}

class TermsText extends StatelessWidget {
  const TermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'By clicking continue, you agree to our Terms of Service and Privacy Policy',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12, color: EcoScanTheme.slate, height: 1.5),
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
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: EcoScanTheme.slate,
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: EcoScanTheme.creamMist,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: EcoScanTheme.charcoal),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: EcoScanTheme.slate, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: EcoScanTheme.charcoal,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  const ActivityItem({
    super.key,
    required this.title,
    required this.action,
    required this.time,
    this.unread = false,
  });

  final String title;
  final String action;
  final String time;
  final bool unread;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: EcoScanTheme.creamMist,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: EcoScanTheme.charcoal,
                ),
              ),
              if (unread)
                Positioned(
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: EcoScanTheme.charcoal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  action,
                  style: const TextStyle(
                    color: EcoScanTheme.slate,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(color: EcoScanTheme.slate, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Container(
                width: 56,
                height: 32,
                decoration: BoxDecoration(
                  color: EcoScanTheme.creamMist,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: EcoScanTheme.charcoal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.unread = false,
  });

  final String title;
  final String subtitle;
  final String time;
  final bool unread;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: EcoScanTheme.creamMist,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.notifications_rounded,
              color: EcoScanTheme.charcoal,
            ),
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
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: EcoScanTheme.charcoal,
                        ),
                      ),
                    ),
                    if (unread)
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: EcoScanTheme.slate,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            time,
            style: const TextStyle(color: EcoScanTheme.slate, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.label,
    required this.trailing,
  });

  final String label;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(title: Text(label), trailing: trailing, onTap: () {}),
    );
  }
}

class ProfileStatCard extends StatelessWidget {
  const ProfileStatCard({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: EcoScanTheme.slate, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  const ProfileInfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: EcoScanTheme.slate, fontSize: 13),
        ),
        Text(
          value,
          style: const TextStyle(
            color: EcoScanTheme.charcoal,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class QuickActionTile extends StatelessWidget {
  const QuickActionTile({super.key, required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: EcoScanTheme.creamMist,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: EcoScanTheme.charcoal),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: EcoScanTheme.charcoal,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class DashedPlaceholderBox extends StatelessWidget {
  const DashedPlaceholderBox({
    super.key,
    required this.height,
    required this.label,
  });

  final double height;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: CustomPaint(
        painter: DashedBorderPainter(),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: EcoScanTheme.slate,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(18),
        ),
      );

    final metrics = path.computeMetrics();
    const dashWidth = 6.0;
    const dashSpace = 4.0;

    for (final metric in metrics) {
      var start = 0.0;
      while (start < metric.length) {
        final end = start + dashWidth;
        canvas.drawPath(metric.extractPath(start, end), paint);
        start += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ChatBubble {
  const _ChatBubble({required this.isOutgoing, required this.text});

  final bool isOutgoing;
  final String text;
}
