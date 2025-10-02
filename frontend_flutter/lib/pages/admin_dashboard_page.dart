import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('All Users',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // TODO: Replace with actual user count
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(child: Text('U${index + 1}')),
                      title: Text('User ${index + 1}'),
                      subtitle: Text(
                          'Tests attempted: ${index * 2}, Score: ${60 + index * 4}'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
