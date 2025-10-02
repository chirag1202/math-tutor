import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.light);

  final ValueNotifier<bool> _loginLoading = ValueNotifier(false);
  final ValueNotifier<bool> _quizLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (context, themeMode, _) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          themeMode: themeMode,
          home: Scaffold(
            backgroundColor:
                themeMode == ThemeMode.light ? Colors.white : Colors.black,
            appBar: AppBar(
              title: const Text('MathsTutor'),
              backgroundColor: Colors.deepPurple,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.account_circle, size: 32),
                  tooltip: 'Profile',
                  onPressed: () {
                    // TODO: Navigate to profile page
                  },
                ),
                IconButton(
                  icon: Icon(themeMode == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode),
                  tooltip: 'Switch Theme',
                  onPressed: () {
                    _themeMode.value = themeMode == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/AI_Tutor.png',
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported,
                                  size: 80, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Welcome to MathsTutor!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Learn, practice, and master mathematics with interactive quizzes.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: _loginLoading,
                          builder: (context, loading, _) {
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTapDown: (_) => _loginLoading.value = true,
                                onTapUp: (_) => _loginLoading.value = false,
                                onTapCancel: () => _loginLoading.value = false,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(
                                    color: loading
                                        ? Colors.deepPurple.shade700
                                        : Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.deepPurple.withOpacity(0.15),
                                        blurRadius: loading ? 8 : 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      splashColor: Colors.white24,
                                      highlightColor:
                                          Colors.deepPurple.shade900,
                                      onTap: () async {
                                        _loginLoading.value = true;
                                        await Future.delayed(
                                            const Duration(seconds: 1));
                                        _loginLoading.value = false;
                                        // TODO: Implement login
                                      },
                                      child: SizedBox(
                                        height: 56,
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.login,
                                                color: Colors.white),
                                            const SizedBox(width: 12),
                                            loading
                                                ? const SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.white,
                                                      strokeWidth: 2.5,
                                                    ),
                                                  )
                                                : const Text(
                                                    'Login',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        const SizedBox(height: 8),
                        ValueListenableBuilder<bool>(
                          valueListenable: _quizLoading,
                          builder: (context, loading, _) {
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTapDown: (_) => _quizLoading.value = true,
                                onTapUp: (_) => _quizLoading.value = false,
                                onTapCancel: () => _quizLoading.value = false,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(
                                    color: loading
                                        ? Colors.orange.shade700
                                        : Colors.orange,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.orange.withOpacity(0.15),
                                        blurRadius: loading ? 8 : 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      splashColor: Colors.white24,
                                      highlightColor: Colors.orange.shade900,
                                      onTap: () async {
                                        _quizLoading.value = true;
                                        await Future.delayed(
                                            const Duration(seconds: 1));
                                        _quizLoading.value = false;
                                        // TODO: Start quiz
                                      },
                                      child: SizedBox(
                                        height: 56,
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.quiz,
                                                color: Colors.white),
                                            const SizedBox(width: 12),
                                            loading
                                                ? const SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.white,
                                                      strokeWidth: 2.5,
                                                    ),
                                                  )
                                                : const Text(
                                                    'Start Quiz',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Image.asset(
                    'assets/AI_Tutor.png',
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported, size: 80),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
