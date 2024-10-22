// lib/models/quiz_progress.dart
class QuizProgress {
  int score;
  int level;

  QuizProgress({required this.score, required this.level});

  void updateScore(bool isCorrect) {
    if (isCorrect) {
      score += 10;  // Increase score for correct answers
      if (score >= 50) {
        level++;   // Move to the next level after reaching the threshold
        // Keep the score intact across levels if desired
      }
    } else {
      score = (score - 5).clamp(0, score);  // Prevent score from going below zero
    }
  }
}
