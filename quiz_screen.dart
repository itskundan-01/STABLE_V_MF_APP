// lib/screens/quiz_screen.dart
import 'dart:async'; // Import the dart:async package for Timer functionality
import 'package:flutter/material.dart';
import '../models/quiz_progress.dart';
import '../models/question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuizProgress _progress = QuizProgress(score: 0, level: 1);
  int _currentQuestionIndex = 0;
  List<Question> _questions = [];
  String? _feedback; // Variable to hold feedback message
  Timer? _timer; // Timer for counting down
  int _timeLeft = 30; // Time limit for each question in seconds

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _startTimer(); // Start the timer when the quiz is loaded
  }

  void _loadQuestions() {
    setState(() {
      _questions = shuffleQuestions(_getQuestionsForLevel(_progress.level));
    });
  }

  List<Question> _getQuestionsForLevel(int level) {
    if (level == 1) {
      return easyQuestions;
    } else if (level == 2) {
      return mediumQuestions;
    } else {
      return hardQuestions;
    }
  }

  void _startTimer() {
    _timeLeft = 30; // Reset the timer for the new question
    _timer?.cancel(); // Cancel any existing timer

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer?.cancel(); // Stop the timer when it reaches zero
          _handleTimeOut(); // Handle timeout
        }
      });
    });
  }

  void _handleTimeOut() {
    setState(() {
      _feedback = "Time's up! The correct answer was: ${_questions[_currentQuestionIndex].options[_questions[_currentQuestionIndex].correctOption]}";
      // Update score or move to next question based on your preference
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _startTimer(); // Restart the timer for the next question
      } else {
        _showQuizResult(); // End of quiz
      }
    });
  }

  void _answerQuestion(int selectedOption) {
    setState(() {
      bool isCorrect = _questions[_currentQuestionIndex].correctOption == selectedOption;
      _progress.updateScore(isCorrect);
      _feedback = isCorrect ? "Correct!" : "Incorrect! The correct answer was: ${_questions[_currentQuestionIndex].options[_questions[_currentQuestionIndex].correctOption]}";

      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _startTimer(); // Restart the timer for the next question
      } else {
        _showQuizResult();  // End of quiz
      }
    });
  }

  void _showQuizResult() {
    _timer?.cancel(); // Stop the timer when the quiz is complete
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Quiz Complete!'),
        content: Text('Your score: ${_progress.score}, Level: ${_progress.level}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _restartQuiz(); // Reset the quiz
            },
            child: const Text('Restart'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();  // Exit quiz screen
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _progress = QuizProgress(score: 0, level: 1); // Reset progress
      _loadQuestions();  // Reload questions based on the current level
      _feedback = null; // Reset feedback
    });
    _startTimer(); // Start the timer for the new quiz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: _questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _questions[_currentQuestionIndex].questionText,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          ..._questions[_currentQuestionIndex].options.asMap().entries.map(
                (entry) {
              return ElevatedButton(
                onPressed: () {
                  _answerQuestion(entry.key);
                },
                child: Text(entry.value),
              );
            },
          ),
          // Display current score and level
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Score: ${_progress.score} | Level: ${_progress.level} | Time left: $_timeLeft seconds',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          // Display feedback message
          if (_feedback != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _feedback!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
