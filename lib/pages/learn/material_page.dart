import 'package:flutter/material.dart';

// Import the module pages (make sure these files and classes exist)
import 'solar_system_module.dart';
import 'constellations_module.dart';
import 'moon_phases_module.dart';

class LearningMaterialPage extends StatelessWidget {
  const LearningMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9C4), // soft yellow
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          'Topic Pembelajaran',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TopicCard(
              title: 'Sistem Solar',
              description: 'Terokai planet dan fahami mekaniknya.',
              imagePath: 'assets/images/solar_system.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SolarSystemModule()),
                );
              },
            ),
            const SizedBox(height: 20),
            TopicCard(
              title: 'Buruj',
              description: 'Ketahui corak bintang dan sejarahnya.',
              imagePath: 'assets/images/constellations.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConstellationsModule()),
                );
              },
            ),
            const SizedBox(height: 20),
            TopicCard(
              title: 'Fasa Bulan',
              description: 'Memahami kitaran bulan dan kesannya.',
              imagePath: 'assets/images/moon_phases.jpg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MoonPhasesModule()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TopicCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback onTap;

  const TopicCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 60,
              height: 60,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported,
                  size: 60,
                  color: Colors.grey,
                );
              },
            ),

            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
