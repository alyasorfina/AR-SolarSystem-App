import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ar_page.dart';
import 'quiz/quiz_page.dart';
import 'learn/material_page.dart';
import 'video_module_page.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8DC),
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          "Menu Utama",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/images/logo.png', height: 120),
            const SizedBox(height: 15),
            const Text(
              'Selamat Datang ke Aplikasi Sistem Suria AR!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.indigo,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Butang untuk setiap ciri
            MenuButton(
              title: "🌌 Terokai Sistem Suria (AR)",
              onPressed: () {
                Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) => const ARPage())
                );
              },
            ),
            const SizedBox(height: 15),
            MenuButton(
              title: "🧠 Kuiz Interaktif",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizPage()),
                );
              },
            ),
            const SizedBox(height: 15),
            MenuButton(
              title: "📚 Bahan Pembelajaran",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LearningMaterialPage()),
                );
              },
            ),
            const SizedBox(height: 15),
            MenuButton(
              title: "🎥 Video Pembelajaran",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoModulePage()),
                );
              },
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: const Icon(Icons.logout),
              label: const Text("Log Keluar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget butang boleh guna semula
class MenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlueAccent,
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
