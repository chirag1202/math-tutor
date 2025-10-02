
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/auth_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://fldmzcgwygtooaboinsi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZsZG16Y2d3eWd0b29hYm9pbnNpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk0MTY0NzgsImV4cCI6MjA3NDk5MjQ3OH0.FeNifv6sM2xKROAIrAkSwcQooRyQUHANBL5WKBE_K4c', // Replace with your Supabase anon key
  );
  runApp(MathsTutorApp());
}

class MathsTutorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MathsTutor',
      theme: ThemeData(primarySwatch: Colors.blue),
  home: AuthPage(),
    );
  }
}
