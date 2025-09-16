import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'quiz_result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> questions = [
    Question(
      text: "Planet manakah yang paling hampir dengan Matahari?",
      options: ["Bumi", "Utarid", "Marikh", "Zuhrah"],
      answer: "Utarid",
    ),
    Question(
      text: "Objek manakah yang mengeluarkan cahaya sendiri di angkasa?",
      options: ["Bulan", "Bintang", "Planet", "Bumi"],
      answer: "Bintang",
    ),
    Question(
      text: "Planet manakah yang mempunyai gelang?",
      options: ["Musytari", "Uranus", "Marikh", "Zuhal"],
      answer: "Zuhal",
    ),
    Question(
      text: "Bulan mengelilingi __________.",
      options: ["Matahari", "Bintang", "Bumi", "Musytari"],
      answer: "Bumi",
    ),
    Question(
      text: "Apakah fasa Bulan apabila ia kelihatan bulat sepenuhnya?",
      options: ["Bulan Baru", "Bulan Penuh", "Bulan Sabit", "Bulan Separuh"],
      answer: "Bulan Penuh",
    ),
    Question(
      text: "Planet manakah dikenali sebagai 'Planet Merah'?",
      options: ["Marikh", "Musytari", "Venus", "Bumi"],
      answer: "Marikh",
    ),
    Question(
      text: "Apakah fungsi utama Matahari kepada Bumi?",
      options: ["Mengorbit Bumi", "Memberi cahaya dan haba", "Menyebabkan siang dan malam", "Memantulkan cahaya"],
      answer: "Memberi cahaya dan haba",
    ),
    Question(
      text: "Yang manakah bukan planet?",
      options: ["Pluto", "Zuhrah", "Bumi", "Matahari"],
      answer: "Matahari",
    ),
    Question(
      text: "Apakah nama sistem yang mengandungi planet, Matahari dan objek angkasa lain?",
      options: ["Galaksi", "Sistem Suria", "Orbit", "Alam Semesta"],
      answer: "Sistem Suria",
    ),
    Question(
      text: "Planet manakah paling besar dalam Sistem Suria?",
      options: ["Musytari", "Bumi", "Zuhal", "Neptun"],
      answer: "Musytari",
    ),
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  List<String> selectedAnswers = [];

  void checkAnswer(String selectedOption) {
    selectedAnswers.add(selectedOption);

    if (selectedOption == questions[currentQuestionIndex].answer) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      saveScoreAndNavigate();
    }
  }

  Future<void> saveScoreAndNavigate() async {
    User? user = FirebaseAuth.instance.currentUser;
    int? previousScore;

    if (user != null) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('quiz_scores')
            .where('uid', isEqualTo: user.uid)
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          previousScore = snapshot.docs.first['score'];
        }

        await FirebaseFirestore.instance.collection('quiz_scores').add({
          'uid': user.uid,
          'email': user.email,
          'score': score,
          'total': questions.length,
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Skor berjaya disimpan!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ Gagal simpan skor: $e")),
        );
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultPage(
          score: score,
          total: questions.length,
          previousScore: previousScore,
          questions: questions,
          selectedAnswers: selectedAnswers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuiz Angkasa!'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Soalan ${currentQuestionIndex + 1} daripada ${questions.length}",
              style: const TextStyle(fontSize: 22, fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 20),
            Text(
              questions[currentQuestionIndex].text,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...questions[currentQuestionIndex].options.map(
                  (option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    option,
                    style: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),
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
  final String text;
  final List<String> options;
  final String answer;

  Question({required this.text, required this.options, required this.answer});
}
