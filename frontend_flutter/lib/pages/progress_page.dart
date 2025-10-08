import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Your Progress'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Your Progress', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Track your math learning journey, Chirag!', style: TextStyle(fontSize: 15, color: Colors.grey)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatCard(label: 'Average Score', value: '0%', icon: Icons.center_focus_strong),
                  _StatCard(label: 'Day Streak', value: '0', icon: Icons.calendar_today),
                  _StatCard(label: 'Quizzes Taken', value: '0', icon: Icons.menu_book),
                  _StatCard(label: 'Correct Answers', value: '0', icon: Icons.emoji_events),
                ],
              ),
              const SizedBox(height: 32),
              const Text("This Week's Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text('No data yet', style: TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(height: 32),
              const Text('Topic Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: [
                  _TopicPerfCard(title: 'Numbers', percent: 0.8, icon: Icons.calculate),
                  const SizedBox(width: 12),
                  _TopicPerfCard(title: 'Statistics', percent: 0.4, icon: Icons.show_chart),
                  const SizedBox(width: 12),
                  _TopicPerfCard(title: 'Algebra', percent: 0.2, icon: Icons.track_changes),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home/index'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'progress/index'),
        ],
        currentIndex: 1,
        onTap: (i) {},
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _StatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 8)],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: Colors.teal, size: 28),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _TopicPerfCard extends StatelessWidget {
  final String title;
  final double percent;
  final IconData icon;
  const _TopicPerfCard({required this.title, required this.percent, required this.icon});

  @override
  Widget build(BuildContext context) {
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
            Row(
              children: [
                Icon(icon, color: Colors.teal, size: 20),
                const SizedBox(width: 6),
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: percent,
              minHeight: 4,
              backgroundColor: Colors.grey.shade200,
              color: Colors.teal,
            ),
            const SizedBox(height: 8),
            Text('${(percent * 100).toInt()}% completed', style: const TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
