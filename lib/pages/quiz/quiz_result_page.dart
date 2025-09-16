import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'quiz_page.dart'; // Pastikan class Question boleh diakses

class QuizResultPage extends StatelessWidget {
  final int score;
  final int total;
  final int? previousScore;
  final List<Question> questions;
  final List<String> selectedAnswers;

  const QuizResultPage({
    super.key,
    required this.score,
    required this.total,
    this.previousScore,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        title: const Text("Keputusan Kuiz"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // 🎉 Lottie animasi confetti
          Center(
            child: Lottie.asset(
              'assets/lotties/confetti.json', // letak fail animasi Lottie di folder assets/lottie/
              height: 150,
              repeat: false,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "🎉 Hebat! Anda dapat $score / $total",
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          if (previousScore != null)
            Center(
              child: Text(
                "Sebelum ini: $previousScore / $total",
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          const SizedBox(height: 20),
          const Text(
            "✨ Semakan Jawapan ✨",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Divider(thickness: 2),
          const SizedBox(height: 10),

          // 📚 Semakan jawapan
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              final userAnswer = selectedAnswers[index];
              final isCorrect = userAnswer == question.answer;

              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: isCorrect ? Colors.green[50] : Colors.red[50],
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "📝 Soalan ${index + 1}: ${question.text}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Jawapan anda: $userAnswer",
                        style: TextStyle(
                          fontSize: 16,
                          color: isCorrect ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (!isCorrect)
                        Text(
                          "Jawapan betul: ${question.answer}",
                          style: const TextStyle(color: Colors.green),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 30),

          // 🌟 Butang kembali
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: const Icon(Icons.home),
              label: const Text(
                "Kembali ke Menu",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
