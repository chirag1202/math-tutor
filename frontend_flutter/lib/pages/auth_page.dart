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
  String _selectedBoard = 'ICSE';
  int _selectedStandard = 4;

  Future<void> _authenticate() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final supabase = Supabase.instance.client;
    try {
      if (_isSignUp) {
        final response = await supabase.auth.signUp(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (response.user != null) {
          // Call backend to sync profile info
          final uri = Uri.parse('http://192.168.31.91:8000/register');
          try {
            await http.post(
              uri,
              headers: {'Content-Type': 'application/json'},
              body:
                  '{"email": "${_emailController.text}", "full_name": "${_fullNameController.text}", "role": "student", "password": "${_passwordController.text}", "board": "${_selectedBoard}", "standard": ${_selectedStandard}}',
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
          setState(() {
            _error = 'Invalid credentials.';
          });
        }
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -80,
            left: -80,
            child: Image.asset(
              'assets/AI_Tutor.png',
              height: 200,
              color: theme.colorScheme.primary.withOpacity(0.1),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -60,
            child: Image.asset(
              'assets/AI_Tutor.png',
              height: 160,
              color: theme.colorScheme.secondary.withOpacity(0.1),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/AI_Tutor.png',
                      height: 80,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _isSignUp ? 'Create Account' : 'Sign In',
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email, color: theme.colorScheme.primary),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: theme.colorScheme.primary),
                      ),
                      obscureText: true,
                    ),
                    if (_isSignUp) ...[
                      const SizedBox(height: 16),
                      TextField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person, color: theme.colorScheme.primary),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedBoard,
                        decoration: const InputDecoration(
                          labelText: 'Board',
                        ),
                        items: ['ICSE', 'CBSE', 'SSC']
                            .map((board) => DropdownMenuItem(
                                  value: board,
                                  child: Text(board),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedBoard = val ?? 'ICSE';
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<int>(
                        initialValue: _selectedStandard,
                        decoration: const InputDecoration(
                          labelText: 'Standard',
                        ),
                        items: List.generate(6, (i) => i + 4)
                            .map((std) => DropdownMenuItem(
                                  value: std,
                                  child: Text('Class $std'),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedStandard = val ?? 4;
                          });
                        },
                      ),
                    ],
                    const SizedBox(height: 24),
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          _error!,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _authenticate,
                        child: _loading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                _isSignUp ? 'Sign Up' : 'Sign In',
                              ),
                      ),
                    ),
                    TextButton(
                      onPressed: _loading
                          ? null
                          : () => setState(() => _isSignUp = !_isSignUp),
                      child: Text(
                        _isSignUp
                            ? 'Already have an account? Sign In'
                            : 'Don\'t have an account? Sign Up',
                        style: TextStyle(color: theme.colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
