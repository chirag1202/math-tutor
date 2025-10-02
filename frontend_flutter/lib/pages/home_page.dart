import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MathsTutor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to MathsTutor!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement login
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Start quiz
              },
              child: Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
