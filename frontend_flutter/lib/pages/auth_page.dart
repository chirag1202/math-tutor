
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  bool _isSignUp = false;
  String? _error;
  bool _loading = false;

  Future<void> _authenticate() async {
    setState(() { _loading = true; _error = null; });
    final supabase = Supabase.instance.client;
    try {
      if (_isSignUp) {
        final response = await supabase.auth.signUp(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (response.user != null) {
          // Call backend to sync profile info
          final uri = Uri.parse('http://localhost:8000/register');
          try {
            await http.post(
              uri,
              headers: {'Content-Type': 'application/json'},
              body: '{"email": "${_emailController.text}", "full_name": "${_fullNameController.text}", "role": "student", "password": "${_passwordController.text}"}',
            );
          } catch (e) {
            // Optionally handle error
          }
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        }
      } else {
        final response = await supabase.auth.signInWithPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (response.session != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        } else {
          setState(() { _error = 'Invalid credentials.'; });
        }
      }
    } catch (e) {
      setState(() { _error = e.toString(); });
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _isSignUp ? 'Sign Up' : 'Sign In',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              if (_isSignUp) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _authenticate,
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(_isSignUp ? 'Sign Up' : 'Sign In'),
                ),
              ),
              TextButton(
                onPressed: _loading
                    ? null
                    : () => setState(() => _isSignUp = !_isSignUp),
                child: Text(_isSignUp
                    ? 'Already have an account? Sign In'
                    : 'Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
