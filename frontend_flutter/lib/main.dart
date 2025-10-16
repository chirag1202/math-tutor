
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'pages/auth_page.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://fldmzcgwygtooaboinsi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZsZG16Y2d3eWd0b29hYm9pbnNpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk0MTY0NzgsImV4cCI6MjA3NDk5MjQ3OH0.FeNifv6sM2xKROAIrAkSwcQooRyQUHANBL5WKBE_K4c', // Replace with your Supabase anon key
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MathsTutorApp(),
    ),
  );
}

class MathsTutorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      title: 'Math Tutor',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: AuthPage(),
    );
  }
}
