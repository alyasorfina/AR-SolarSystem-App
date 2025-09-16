import 'package:flutter/material.dart';
import 'dart:math';

class SolarSystemModule extends StatefulWidget {
  const SolarSystemModule({super.key});

  @override
  State<SolarSystemModule> createState() => _SolarSystemModuleState();
}

class _SolarSystemModuleState extends State<SolarSystemModule>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _planetRotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();

    _planetRotation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget planet(String name, String imagePath, String description) {
    return Column(
      children: [
        RotationTransition(
          turns: _planetRotation,
          child: Image.asset(imagePath, width: 120),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
          ),
        ),
        const Divider(thickness: 1, height: 40),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistem Suria"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      backgroundColor: const Color(0xFFFFF9C4), // Warna kuning lembut
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            planet("Bumi", 'assets/images/earth.png', "Bumi ialah satu-satunya planet yang menyokong kehidupan."),
            planet("Marikh", 'assets/images/mars.png', "Planet merah dengan kemungkinan pernah mempunyai air."),
            planet("Musytari", 'assets/images/jupiter.png', "Planet terbesar dalam sistem suria kita."),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
