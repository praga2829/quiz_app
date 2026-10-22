import 'package:flutter/material.dart';

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF2F5FB),
      ),
      home: const QuizHomePage(),
    );
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

const List<QuizQuestion> questions = [
  QuizQuestion(
    question: 'Which language is primarily used to build Flutter apps?',
    options: ['Java', 'Dart', 'Python', 'C'],
    correctIndex: 1,
    explanation: 'Flutter apps are usually written in Dart.',
  ),
  QuizQuestion(
    question: 'Which company created Flutter?',
    options: ['Microsoft', 'Meta', 'Google', 'Amazon'],
    correctIndex: 2,
    explanation: 'Flutter was created by Google.',
  ),
  QuizQuestion(
    question: 'Which widget arranges children vertically?',
    options: ['Row', 'Stack', 'Column', 'Center'],
    correctIndex: 2,
    explanation: 'Column arranges children vertically.',
  ),
  QuizQuestion(
    question: 'What does hot reload help developers do?',
    options: [
      'Delete an app',
      'See code changes quickly',
      'Install Windows',
      'Create a database',
    ],
    correctIndex: 1,
    explanation: 'Hot reload applies supported code changes quickly.',
  ),
  QuizQuestion(
    question: 'Which file lists Flutter project dependencies?',
    options: ['index.html', 'pubspec.yaml', 'main.exe', 'README.png'],
    correctIndex: 1,
    explanation: 'pubspec.yaml contains project dependencies.',
  ),
  QuizQuestion(
    question: 'Which widget can display a clickable button?',
    options: ['Text', 'Icon', 'ElevatedButton', 'Divider'],
    correctIndex: 2,
    explanation: 'ElevatedButton creates a clickable button.',
  ),
  QuizQuestion(
    question: 'What is setState() used for?',
    options: [
      'Close the browser',
      'Tell Flutter the UI state changed',
      'Install packages',
      'Rename a project',
    ],
    correctIndex: 1,
    explanation: 'setState tells Flutter to rebuild after state changes.',
  ),
  QuizQuestion(
    question: 'Which command downloads project dependencies?',
    options: [
      'flutter start',
      'flutter cleanall',
      'flutter pub get',
      'flutter open',
    ],
    correctIndex: 2,
    explanation: 'flutter pub get resolves project dependencies.',
  ),
  QuizQuestion(
    question: 'Which widget provides a dropdown selection field?',
    options: [
      'DropdownButtonFormField',
      'Scaffold',
      'Padding',
      'SizedBox',
    ],
    correctIndex: 0,
    explanation: 'DropdownButtonFormField displays a dropdown.',
  ),
  QuizQuestion(
    question: 'What does MaterialApp provide?',
    options: [
      'Only a database',
      'App theme and navigation configuration',
      'A programming language',
      'Only a web server',
    ],
    correctIndex: 1,
    explanation: 'MaterialApp configures themes and navigation.',
  ),
];

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  int questionIndex = 0;
  int score = 0;
  int? selectedAnswer;
  bool answered = false;
  bool finished = false;

  QuizQuestion get currentQuestion => questions[questionIndex];

  void selectAnswer(int index) {
    if (answered) return;

    setState(() {
      selectedAnswer = index;
      answered = true;
      if (index == currentQuestion.correctIndex) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
        selectedAnswer = null;
        answered = false;
      });
    } else {
      setState(() {
        finished = true;
      });
    }
  }

  void restartQuiz() {
    setState(() {
      questionIndex = 0;
      score = 0;
      selectedAnswer = null;
      answered = false;
      finished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Knowledge Quiz'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: finished ? buildResults() : buildQuiz(),
          ),
        ),
      ),
    );
  }

  Widget buildQuiz() {
    final question = currentQuestion;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          color: Colors.blue.shade800,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const Icon(Icons.quiz, color: Colors.white, size: 38),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Test Your Knowledge',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Question ${questionIndex + 1} of ${questions.length}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Text(
                  '$score pts',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: (questionIndex + 1) / questions.length,
          minHeight: 8,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'QUESTION ${questionIndex + 1}',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    for (int i = 0; i < question.options.length; i++)
                      buildOption(question, i),
                    if (answered) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: selectedAnswer == question.correctIndex
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedAnswer == question.correctIndex
                                  ? 'Correct answer!'
                                  : 'Correct answer: ${question.options[question.correctIndex]}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selectedAnswer == question.correctIndex
                                    ? Colors.green.shade800
                                    : Colors.red.shade800,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(question.explanation),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: answered ? nextQuestion : null,
          icon: Icon(
            questionIndex == questions.length - 1
                ? Icons.emoji_events
                : Icons.arrow_forward,
          ),
          label: Text(
            questionIndex == questions.length - 1
                ? 'See Results'
                : 'Next Question',
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget buildOption(QuizQuestion question, int index) {
    final isSelected = selectedAnswer == index;
    final isCorrect = index == question.correctIndex;

    Color background = Colors.grey.shade50;
    Color border = Colors.grey.shade300;
    IconData? trailingIcon;

    if (answered && isCorrect) {
      background = Colors.green.shade50;
      border = Colors.green;
      trailingIcon = Icons.check_circle;
    } else if (answered && isSelected && !isCorrect) {
      background = Colors.red.shade50;
      border = Colors.red;
      trailingIcon = Icons.cancel;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: answered ? null : () => selectAnswer(index),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Text(String.fromCharCode(65 + index)),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(question.options[index])),
                if (trailingIcon != null) Icon(trailingIcon),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildResults() {
    final percentage = (score * 100 / questions.length).round();
    final message = percentage >= 80
        ? 'Excellent Work!'
        : percentage >= 50
            ? 'Good Effort!'
            : 'Keep Practising!';

    return SingleChildScrollView(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const Icon(
                Icons.emoji_events,
                size: 85,
                color: Colors.amber,
              ),
              const SizedBox(height: 16),
              const Text(
                'Quiz Completed!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(message, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              Text(
                '$score / ${questions.length}',
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const Text('Correct Answers'),
              const SizedBox(height: 12),
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'You have answered all 10 questions. Try again to improve your score!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: restartQuiz,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Restart Quiz'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
