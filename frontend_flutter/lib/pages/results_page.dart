import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class ResultsPage extends StatefulWidget {
  final int totalQuestions;
  final int correctAnswers;
  final String topic;

  const ResultsPage({
    Key? key,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.topic,
  }) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Trigger animations and confetti if score is good
    Future.delayed(const Duration(milliseconds: 300), () {
      _animationController.forward();
      final percentage = (widget.correctAnswers / widget.totalQuestions) * 100;
      if (percentage >= 60) {
        _confettiController.play();
      }
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  String _getEncouragingMessage() {
    final percentage = (widget.correctAnswers / widget.totalQuestions) * 100;
    if (percentage >= 90) {
      return "Amazing! You're a math superstar! 🌟";
    } else if (percentage >= 75) {
      return "Great job! You're doing wonderful! 🎉";
    } else if (percentage >= 60) {
      return "Good work! Keep practicing! 💪";
    } else if (percentage >= 40) {
      return "Nice try! You're learning! 📚";
    } else {
      return "Don't give up! Practice makes perfect! 🎯";
    }
  }

  Color _getScoreColor() {
    final percentage = (widget.correctAnswers / widget.totalQuestions) * 100;
    if (percentage >= 75) {
      return Colors.green;
    } else if (percentage >= 50) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  IconData _getScoreIcon() {
    final percentage = (widget.correctAnswers / widget.totalQuestions) * 100;
    if (percentage >= 90) {
      return Icons.emoji_events;
    } else if (percentage >= 75) {
      return Icons.stars;
    } else if (percentage >= 60) {
      return Icons.thumb_up;
    } else {
      return Icons.local_fire_department;
    }
  }

  int _getStarsEarned() {
    final percentage = (widget.correctAnswers / widget.totalQuestions) * 100;
    if (percentage >= 90) return 3;
    if (percentage >= 70) return 2;
    if (percentage >= 50) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentage = (widget.correctAnswers / widget.totalQuestions) * 100;
    final scoreColor = _getScoreColor();
    final starsEarned = _getStarsEarned();

    return Scaffold(
      body: Stack(
        children: [
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 5,
              minBlastForce: 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.3,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
                Colors.yellow,
              ],
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    
                    // Header
                    Text(
                      'Quiz Complete!',
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    Text(
                      widget.topic,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    // Score Circle with Animation
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              scoreColor.withOpacity(0.3),
                              scoreColor.withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: scoreColor.withOpacity(0.3),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RotationTransition(
                                turns: _rotationAnimation,
                                child: Icon(
                                  _getScoreIcon(),
                                  size: 60,
                                  color: scoreColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '${percentage.toInt()}%',
                                style: theme.textTheme.displayLarge?.copyWith(
                                  color: scoreColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${widget.correctAnswers}/${widget.totalQuestions}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: scoreColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Stars Earned
                    if (starsEarned > 0)
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                index < starsEarned ? Icons.star : Icons.star_border,
                                size: 48,
                                color: index < starsEarned
                                    ? const Color(0xFFFFD700)
                                    : Colors.grey.shade400,
                              ),
                            );
                          }),
                        ),
                      ),

                    const SizedBox(height: 30),

                    // Encouraging Message
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        _getEncouragingMessage(),
                        style: theme.textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Stats Cards
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            icon: Icons.check_circle,
                            label: 'Correct',
                            value: widget.correctAnswers.toString(),
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _StatCard(
                            icon: Icons.cancel,
                            label: 'Wrong',
                            value: (widget.totalQuestions - widget.correctAnswers)
                                .toString(),
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Action Buttons
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      child: const Text('Try Again'),
                    ),

                    const SizedBox(height: 16),

                    OutlinedButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        side: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Back to Home',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.displayMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
