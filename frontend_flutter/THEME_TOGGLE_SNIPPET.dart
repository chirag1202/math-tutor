/// Theme Toggle Implementation Snippet for Math Tutor App
/// 
/// This file provides a complete, working example of how to implement
/// the Light/Dark theme toggle in the Math Tutor app.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ============================================================
// 1. THEME PROVIDER (State Management)
// ============================================================

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  /// Toggle between light and dark theme
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  /// Set theme explicitly
  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}

// ============================================================
// 2. THEME TOGGLE BUTTON WIDGET
// ============================================================

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: theme.colorScheme.primary,
        ),
        onPressed: () {
          themeProvider.toggleTheme();
        },
        tooltip: themeProvider.isDarkMode
            ? 'Switch to Light Mode'
            : 'Switch to Dark Mode',
      ),
    );
  }
}

// ============================================================
// 3. ANIMATED THEME TOGGLE BUTTON (Enhanced Version)
// ============================================================

class AnimatedThemeToggleButton extends StatelessWidget {
  const AnimatedThemeToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: themeProvider.isDarkMode
              ? [
                  const Color(0xFF1E293B),
                  const Color(0xFF334155),
                ]
              : [
                  Colors.white,
                  Colors.grey.shade50,
                ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: animation,
              child: child,
            );
          },
          child: Icon(
            themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            key: ValueKey(themeProvider.isDarkMode),
            color: theme.colorScheme.primary,
          ),
        ),
        onPressed: () {
          themeProvider.toggleTheme();
        },
      ),
    );
  }
}

// ============================================================
// 4. THEME TOGGLE SWITCH (Alternative UI)
// ============================================================

class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.light_mode,
          color: themeProvider.isDarkMode
              ? Colors.grey
              : theme.colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Switch(
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            themeProvider.toggleTheme();
          },
          activeColor: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.dark_mode,
          color: themeProvider.isDarkMode
              ? theme.colorScheme.primary
              : Colors.grey,
          size: 20,
        ),
      ],
    );
  }
}

// ============================================================
// 5. USAGE IN MAIN APP
// ============================================================

class ExampleMainApp extends StatelessWidget {
  const ExampleMainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Math Tutor',
            debugShowCheckedModeBanner: false,
            // Define your light theme
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: const Color(0xFF6366F1),
              // ... other theme properties
            ),
            // Define your dark theme
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: const Color(0xFF818CF8),
              // ... other theme properties
            ),
            // Toggle between themes
            themeMode: themeProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const ExampleHomePage(),
          );
        },
      ),
    );
  }
}

// ============================================================
// 6. USAGE IN A SCREEN
// ============================================================

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Tutor'),
        actions: [
          // Simple button version
          const ThemeToggleButton(),
          const SizedBox(width: 8),
          
          // Or animated version
          // const AnimatedThemeToggleButton(),
          
          const SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello, Math Student! 👋',
              style: theme.textTheme.displaySmall,
            ),
            const SizedBox(height: 20),
            
            // Switch version in body
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Theme Settings',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    const ThemeToggleSwitch(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 7. ACCESSING THEME IN ANY WIDGET
// ============================================================

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get current theme
    final theme = Theme.of(context);
    
    // Get theme provider
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    // Check if dark mode
    final isDark = themeProvider.isDarkMode;
    
    return Container(
      color: theme.colorScheme.surface,
      child: Text(
        isDark ? 'Dark Mode Active' : 'Light Mode Active',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

// ============================================================
// 8. MANUAL THEME SETTING
// ============================================================

void setThemeManually(BuildContext context, bool isDark) {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  themeProvider.setTheme(isDark);
}

// Usage:
// setThemeManually(context, true);  // Set to dark
// setThemeManually(context, false); // Set to light

// ============================================================
// 9. SAVE THEME PREFERENCE (with SharedPreferences)
// ============================================================

/*
To persist theme selection, add this to ThemeProvider:

import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  static const String _themeKey = 'isDarkMode';

  ThemeProvider() {
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }

  Future<void> setTheme(bool isDark) async {
    _isDarkMode = isDark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }
}

Don't forget to add to pubspec.yaml:
dependencies:
  shared_preferences: ^2.2.2
*/

// ============================================================
// 10. TESTING
// ============================================================

/*
To test the theme toggle:

1. Run the app
2. Click the theme toggle button
3. Observe colors changing smoothly
4. Navigate between screens to verify consistency
5. Restart app to check if preference is saved (if using SharedPreferences)

Expected behavior:
- Icon changes from sun to moon (or vice versa)
- All colors update smoothly
- No flash or jarring transitions
- Theme persists across app restarts (if saved)
*/
