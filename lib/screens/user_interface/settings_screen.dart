import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmanager/core/providers/navigation_provider.dart';
import 'package:tmanager/core/routers/app_routers.dart';
import 'package:tmanager/screens/user_interface/widgets/home_logo_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  late SettingsController _settingsController;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _settingsController = SettingsController();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    final index = context.watch<MainNavigationProvider>().currentIndex;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const HomeLogoText(),
      ),
      body: FutureBuilder(
        future: _settingsController.loadSettings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildSettingsList();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: index,
        onTap: (index) {
          context.read<MainNavigationProvider>().setCurrentIndex(index);
          switch (index) {
            case 0:
              context.go(AppRoutes.home.path);
              break;
            case 1:
              context.go(AppRoutes.profile.path);
              break;
            case 2:
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList() {
    return ListView(
      children: [
        _buildAppearanceSection(),
        _buildNotificationsSection(),
        _buildSecuritySection(),
        _buildDataSection(),
        _buildAboutSection(),
      ],
    );
  }

  Widget _buildSectionCard(List<Widget> children, [String? title]) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildAppearanceSection() {
    return _buildSectionCard(
      [
        ListTile(
          title: const Text('Тема', style: TextStyle(color: Colors.white)),
          trailing: DropdownButton<ThemeMode>(
            dropdownColor: Colors.grey[900],
            value: _settingsController.themeMode,
            onChanged: (ThemeMode? newMode) {
              if (newMode != null) {
                setState(() => _settingsController.themeMode = newMode);
                _settingsController.saveThemeMode(newMode);
              }
            },
            items: const [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Text('Системная', style: TextStyle(color: Colors.white)),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Text('Светлая', style: TextStyle(color: Colors.white)),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Text('Тёмная', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
      'Внешний вид',
    );
  }

  Widget _buildNotificationsSection() {
    return _buildSectionCard(
      [
        SwitchListTile(
          title:
              const Text('Уведомления', style: TextStyle(color: Colors.white)),
          value: _settingsController.notificationsEnabled,
          onChanged: (bool value) {
            setState(() => _settingsController.notificationsEnabled = value);
            _settingsController.saveNotificationSettings(value);
          },
        ),
      ],
      'Уведомления',
    );
  }

  Widget _buildSecuritySection() {
    return _buildSectionCard(
      [
        SwitchListTile(
          title: const Text(
            'Биометрическая аутентификация',
            style: TextStyle(color: Colors.white),
          ),
          value: _settingsController.biometricAuthEnabled,
          onChanged: (bool value) async {
            if (value) {
              final canAuthenticate = await _localAuth.canCheckBiometrics;
              if (!canAuthenticate) return;
            }
            setState(() => _settingsController.biometricAuthEnabled = value);
            await _settingsController.saveBiometricSetting(value);
          },
        ),
      ],
      'Безопасность',
    );
  }

  Widget _buildDataSection() {
    return _buildSectionCard(
      [
        ListTile(
          title: const Text(
            'Экспорт задач',
            style: TextStyle(color: Colors.white),
          ),
          trailing: const Icon(Icons.arrow_forward, color: Colors.white),
          onTap: () => _settingsController.exportTasks(),
        ),
        ListTile(
          title: const Text(
            'Удалить выполненные задачи',
            style: TextStyle(color: Colors.white),
          ),
          trailing: const Icon(Icons.arrow_forward, color: Colors.white),
          onTap: () => _settingsController.bulkDeleteCompletedTasks(),
        ),
      ],
      'Данные',
    );
  }

  Widget _buildAboutSection() {
    return _buildSectionCard(
      [
        ListTile(
          title: const Text(
            'Политика конфиденциальности',
            style: TextStyle(color: Colors.white),
          ),
          trailing: const Icon(Icons.launch, color: Colors.white),
          onTap: () => _launchPrivacyPolicy(),
        ),
        ListTile(
          title: const Text(
            'Версия приложения',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            _packageInfo.version,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
      'О приложении',
    );
  }

  void _launchPrivacyPolicy() {
    // Implement privacy policy launch
  }
}

class SettingsController {
  ThemeMode themeMode = ThemeMode.system;
  bool notificationsEnabled = true;
  TimeOfDay defaultAlertTime = const TimeOfDay(hour: 9, minute: 0);
  bool biometricAuthEnabled = false;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    themeMode = ThemeMode.values[prefs.getInt('themeMode') ?? 0];
    notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    biometricAuthEnabled = prefs.getBool('biometricAuthEnabled') ?? false;
    final savedHour = prefs.getInt('alertHour') ?? 9;
    final savedMinute = prefs.getInt('alertMinute') ?? 0;
    defaultAlertTime = TimeOfDay(hour: savedHour, minute: savedMinute);
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
  }

  Future<void> saveNotificationSettings(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', enabled);
  }

  Future<void> saveDefaultAlertTime(TimeOfDay time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('alertHour', time.hour);
    await prefs.setInt('alertMinute', time.minute);
  }

  Future<void> saveBiometricSetting(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometricAuthEnabled', enabled);
  }

  void exportTasks() {
    // Implement export logic
  }

  void bulkDeleteCompletedTasks() {
    // Implement bulk delete
  }
}
