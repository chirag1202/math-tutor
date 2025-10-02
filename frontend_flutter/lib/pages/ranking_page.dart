import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  int _selectedClass = 4;
  String _selectedTopic = 'Algebra';
  final List<String> topics = [
    'Algebra',
    'Geometry',
    'Arithmetic',
    'Trigonometry'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rankings'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Class:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: _selectedClass,
                  items: List.generate(6, (i) => i + 4)
                      .map((std) => DropdownMenuItem(
                            value: std,
                            child: Text('Class $std'),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedClass = val ?? 4;
                    });
                  },
                ),
                const SizedBox(width: 24),
                const Text('Topic:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedTopic,
                  items: topics
                      .map((topic) => DropdownMenuItem(
                            value: topic,
                            child: Text(topic),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedTopic = val ?? topics[0];
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Top Students',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // TODO: Replace with actual ranking data
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(child: Text('#${index + 1}')),
                      title: Text('Student ${index + 1}'),
                      subtitle: Text('Score: ${90 - index * 3}'),
                      trailing: index == 0
                          ? const Icon(Icons.emoji_events, color: Colors.amber)
                          : null,
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
