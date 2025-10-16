import 'package:flutter/material.dart';
import 'dart:math';
import 'results_page.dart';

class QuizPage extends StatefulWidget {
  final String topic;
  final int totalQuestions;

  const QuizPage({
    Key? key,
    required this.topic,
    this.totalQuestions = 10,
  }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with SingleTickerProviderStateMixin {
  int currentQuestion = 0;
  int correctAnswers = 0;
  List<Question> questions = [];
  int? selectedAnswer;
  bool showFeedback = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _generateQuestions();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _generateQuestions() {
    final random = Random();
    for (int i = 0; i < widget.totalQuestions; i++) {
      int num1 = random.nextInt(20) + 1;
      int num2 = random.nextInt(20) + 1;
      String operation = ['+', '-', '×'][random.nextInt(3)];
      int correctAnswer;
      
      switch (operation) {
        case '+':
          correctAnswer = num1 + num2;
          break;
        case '-':
          if (num1 < num2) {
            int temp = num1;
            num1 = num2;
            num2 = temp;
          }
          correctAnswer = num1 - num2;
          break;
        case '×':
          num1 = random.nextInt(10) + 1;
          num2 = random.nextInt(10) + 1;
          correctAnswer = num1 * num2;
          break;
        default:
          correctAnswer = 0;
      }

      List<int> options = [correctAnswer];
      while (options.length < 4) {
        int wrongAnswer = correctAnswer + random.nextInt(20) - 10;
        if (!options.contains(wrongAnswer) && wrongAnswer >= 0) {
          options.add(wrongAnswer);
        }
      }
      options.shuffle();

      questions.add(Question(
        questionText: '$num1 $operation $num2 = ?',
        options: options,
        correctAnswer: correctAnswer,
      ));
    }
  }

  void _selectAnswer(int answer) {
    if (showFeedback) return;

    setState(() {
      selectedAnswer = answer;
      showFeedback = true;
      if (answer == questions[currentQuestion].correctAnswer) {
        correctAnswers++;
        _animationController.forward().then((_) => _animationController.reverse());
      }
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (currentQuestion < questions.length - 1) {
        setState(() {
          currentQuestion++;
          selectedAnswer = null;
          showFeedback = false;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultsPage(
              totalQuestions: widget.totalQuestions,
              correctAnswers: correctAnswers,
              topic: widget.topic,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final question = questions[currentQuestion];
    final progress = (currentQuestion + 1) / widget.totalQuestions;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar with progress
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.topic,
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                            backgroundColor: theme.colorScheme.surface,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${currentQuestion + 1}/${widget.totalQuestions}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Question Card
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary.withOpacity(0.1),
                            theme.colorScheme.secondary.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Text(
                            'Solve This!',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: Text(
                              question.questionText,
                              style: theme.textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Icon(
                            Icons.calculate,
                            size: 48,
                            color: theme.colorScheme.secondary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Answer Options
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: question.options.length,
                      itemBuilder: (context, index) {
                        final option = question.options[index];
                        final isSelected = selectedAnswer == option;
                        final isCorrect = option == question.correctAnswer;
                        
                        Color? backgroundColor;
                        Color? borderColor;
                        Color? textColor;

                        if (showFeedback) {
                          if (isCorrect) {
                            backgroundColor = Colors.green.withOpacity(0.2);
                            borderColor = Colors.green;
                            textColor = Colors.green.shade700;
                          } else if (isSelected && !isCorrect) {
                            backgroundColor = Colors.red.withOpacity(0.2);
                            borderColor = Colors.red;
                            textColor = Colors.red.shade700;
                          }
                        } else if (isSelected) {
                          backgroundColor = theme.colorScheme.primary.withOpacity(0.1);
                          borderColor = theme.colorScheme.primary;
                        }

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          child: Material(
                            color: backgroundColor ?? theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                            elevation: isSelected ? 8 : 4,
                            child: InkWell(
                              onTap: showFeedback ? null : () => _selectAnswer(option),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: borderColor ?? theme.colorScheme.primary.withOpacity(0.3),
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    option.toString(),
                                    style: theme.textTheme.displaySmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Encouraging message
            if (showFeedback)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: AnimatedOpacity(
                  opacity: showFeedback ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: selectedAnswer == question.correctAnswer
                          ? Colors.green.withOpacity(0.2)
                          : Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          selectedAnswer == question.correctAnswer
                              ? Icons.celebration
                              : Icons.lightbulb_outline,
                          color: selectedAnswer == question.correctAnswer
                              ? Colors.green
                              : Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          selectedAnswer == question.correctAnswer
                              ? 'Awesome! 🎉'
                              : 'Good try! Keep going! 💪',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: selectedAnswer == question.correctAnswer
                                ? Colors.green.shade700
                                : Colors.orange.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<int> options;
  final int correctAnswer;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });
}
