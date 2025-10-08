import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade200,
                    child:
                        Icon(Icons.person, size: 32, color: Colors.deepPurple),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Hello Chirag! 👋',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Ready to solve some math problems today?',
                            style: TextStyle(fontSize: 15, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: const [
                        Icon(Icons.favorite, color: Colors.white),
                        SizedBox(width: 4),
                        Text('∞',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (i) {
                  final active = i < 3;
                  return Column(
                    children: [
                      Icon(Icons.favorite,
                          color: active ? Colors.teal : Colors.grey.shade300,
                          size: 28),
                      const SizedBox(height: 4),
                      Text(['S', 'M', 'T', 'W', 'T', 'F', 'S'][i],
                          style: TextStyle(fontSize: 13, color: Colors.grey)),
                    ],
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.teal.shade100),
                ),
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                              'Start your daily math practice and build your streak!',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      padding: const EdgeInsets.all(12),
                      child:
                          Icon(Icons.calculate, color: Colors.white, size: 32),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Your Topics',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _TopicCard(
                      title: 'Numbers',
                      completed: 4,
                      total: 5,
                      icon: Icons.calculate),
                  const SizedBox(width: 12),
                  _TopicCard(
                      title: 'Statistics',
                      completed: 2,
                      total: 5,
                      icon: Icons.show_chart),
                  const SizedBox(width: 12),
                  _TopicCard(
                      title: 'Algebra',
                      completed: 2,
                      total: 5,
                      icon: Icons.track_changes),
                ],
              ),
            ),
            const Spacer(),
            BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'home/index'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bar_chart), label: 'progress/index'),
              ],
              currentIndex: 0,
              onTap: (i) {},
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final String title;
  final int completed;
  final int total;
  final IconData icon;
  const _TopicCard(
      {required this.title,
      required this.completed,
      required this.total,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final percent = completed / total;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 8)],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Practice',
                  style: TextStyle(fontSize: 12, color: Colors.teal)),
            ),
            const SizedBox(height: 8),
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text('$completed/$total completed',
                style: const TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: percent,
              minHeight: 4,
              backgroundColor: Colors.grey.shade200,
              color: Colors.teal,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(icon, color: Colors.teal, size: 24),
            ),
          ],
        ),
      ),
    );
  }
}
