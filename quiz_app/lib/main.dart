import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF245FD6),
        ),
        scaffoldBackgroundColor: const Color(0xFFF2F5FB),
      ),
      home: const QuizHomePage(),
    );
  }
}

class QuizQuestion {
  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
}

const List<QuizQuestion> quizQuestions = [
  QuizQuestion(
    question: 'Which language is primarily used to build Flutter apps?',
    options: ['Java', 'Dart', 'Python', 'C'],
    correctIndex: 1,
    explanation: 'Flutter apps are usually written in the Dart programming language.',
  ),
  QuizQuestion(
    question: 'Which company created Flutter?',
    options: ['Microsoft', 'Meta', 'Google', 'Amazon'],
    correctIndex: 2,
    explanation: 'Flutter is an open-source UI toolkit created by Google.',
  ),
  QuizQuestion(
    question: 'Which widget arranges children vertically in Flutter?',
    options: ['Row', 'Stack', 'Column', 'Center'],
    correctIndex: 2,
    explanation: 'Column lays out its children vertically.',
  ),
  QuizQuestion(
    question: 'What does the hot reload feature help developers do?',
    options: [
      'Delete an app',
      'See code changes quickly',
      'Install Windows',
      'Create a database automatically',
    ],
    correctIndex: 1,
    explanation: 'Hot reload applies many code changes without restarting the entire app.',
  ),
  QuizQuestion(
    question: 'Which file lists a Flutter project’s dependencies?',
    options: ['index.html', 'pubspec.yaml', 'main.exe', 'README.png'],
    correctIndex: 1,
    explanation: 'pubspec.yaml contains package dependencies and project metadata.',
  ),
  QuizQuestion(
    question: 'Which widget is commonly used to respond to a button tap?',
    options: ['Text', 'Icon', 'ElevatedButton', 'Divider'],
    correctIndex: 2,
    explanation: 'ElevatedButton provides a button with an onPressed callback.',
  ),
  QuizQuestion(
    question: 'What is the purpose of setState() in a StatefulWidget?',
    options: [
      'Close the browser',
      'Tell Flutter that state changed and the UI should update',
      'Install packages',
      'Rename the project',
    ],
    correctIndex: 1,
    explanation: 'setState notifies Flutter that state has changed and the widget should rebuild.',
  ),
  QuizQuestion(
    question: 'Which command downloads the packages listed in pubspec.yaml?',
    options: [
      'flutter start',
      'flutter cleanall',
      'flutter pub get',
      'flutter open',
    ],
    correctIndex: 2,
    explanation: 'flutter pub get resolves and downloads the project dependencies.',
  ),
  QuizQuestion(
    question: 'Which widget can let a user select one option from a short list?',
    options: ['DropdownButtonFormField', 'Scaffold', 'Padding', 'SizedBox'],
    correctIndex: 0,
    explanation: 'DropdownButtonFormField displays a dropdown selection control.',
  ),
  QuizQuestion(
    question: 'What does MaterialApp usually provide?',
    options: [
      'Only a database',
      'App-level navigation, theme, and Material design configuration',
      'A programming language',
      'A web server only',
    ],
    correctIndex: 1,
    explanation: 'MaterialApp sets up common app-level features such as themes and navigation.',
  ),
];

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  int _questionIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _answered = false;
  bool _finished = false;

  QuizQuestion get _currentQuestion => quizQuestions[_questionIndex];

  void _selectAnswer(int index) {
    if (_answered) return;

    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _currentQuestion.correctIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_questionIndex < quizQuestions.length - 1) {
      setState(() {
        _questionIndex++;
        _selectedAnswer = null;
        _answered = false;
      });
    } else {
      setState(() {
        _finished = true;
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
      _selectedAnswer = null;
      _answered = false;
      _finished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Knowledge Quiz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF174A9C),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _finished ? _buildResults() : _buildQuiz(),
          ),
        ),
      ),
    );
  }

  Widget _buildQuiz() {
    final question = _currentQuestion;
    final progress = (_questionIndex + 1) / quizQuestions.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF174A9C), Color(0xFF3478EE)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.quiz_rounded, color: Colors.white, size: 42),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Test your knowledge',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Question ${_questionIndex + 1} of ${quizQuestions.length}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Text(
                '$_score pts',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: const Color(0xFFDCE5F4),
          ),
        ),
        const SizedBox(height: 22),
        Expanded(
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'QUESTION ${_questionIndex + 1}',
                      style: const TextStyle(
                        color: Color(0xFF2764D7),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 22),
                    ...List.generate(
                      question.options.length,
                      (index) => _buildOption(question, index),
                    ),
                    if (_answered) ...[
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _selectedAnswer == question.correctIndex
                              ? const Color(0xFFE5F7EC)
                              : const Color(0xFFFFEAEA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedAnswer == question.correctIndex
                                  ? 'Correct answer!'
                                  : 'Not quite. Correct answer: ${question.options[question.correctIndex]}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _selectedAnswer == question.correctIndex
                                    ? const Color(0xFF187447)
                                    : const Color(0xFFB3261E),
                              ),
                            ),
                            const SizedBox(height: 5),
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
        const SizedBox(height: 14),
        FilledButton.icon(
          onPressed: _answered ? _nextQuestion : null,
          icon: Icon(
            _questionIndex == quizQuestions.length - 1
                ? Icons.emoji_events
                : Icons.arrow_forward,
          ),
          label: Text(
            _questionIndex == quizQuestions.length - 1
                ? 'See Results'
                : 'Next Question',
          ),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildOption(QuizQuestion question, int index) {
    final isSelected = _selectedAnswer == index;
    final isCorrect = index == question.correctIndex;

    Color background = const Color(0xFFF7F9FD);
    Color border = const Color(0xFFDCE3EF);
    IconData? trailingIcon;

    if (_answered && isCorrect) {
      background = const Color(0xFFE5F7EC);
      border = const Color(0xFF26965F);
      trailingIcon = Icons.check_circle;
    } else if (_answered && isSelected && !isCorrect) {
      background = const Color(0xFFFFEAEA);
      border = const Color(0xFFD64545);
      trailingIcon = Icons.cancel;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(13),
        child: InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: _answered ? null : () => _selectAnswer(index),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: border,
                width: isSelected || (_answered && isCorrect) ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(question.options[index])),
                if (trailingIcon != null) Icon(trailingIcon, size: 21),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResults() {
    final percentage = (_score / quizQuestions.length * 100).round();
    final message = percentage >= 80
        ? 'Excellent work!'
        : percentage >= 50
            ? 'Good effort!'
            : 'Keep practising!';

    return SingleChildScrollView(
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                size: 90,
                color: Color(0xFFE6A323),
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
              Text(
                message,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF174A9C), Color(0xFF3478EE)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      '$_score / ${quizQuestions.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Correct answers',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'You have answered all 10 questions. Try again to improve your score!',
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _restartQuiz,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Restart Quiz'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
