import 'package:flutter/material.dart';

class MoonPhasesModule extends StatefulWidget {
  const MoonPhasesModule({super.key});

  @override
  State<MoonPhasesModule> createState() => _MoonPhasesModuleState();
}

class _MoonPhasesModuleState extends State<MoonPhasesModule> {
  final List<Map<String, String>> _phases = [
    {
      "name": "Bulan Baru",
      "desc": "Bulan tidak kelihatan dari Bumi.",
      "image": "assets/images/new_moon.png"
    },
    {
      "name": "Suku Pertama",
      "desc": "Separuh bulan kelihatan dari sebelah kanan.",
      "image": "assets/images/first_quarter.png"
    },
    {
      "name": "Bulan Penuh",
      "desc": "Bulan kelihatan sepenuhnya bulat.",
      "image": "assets/images/full_moon.png"
    },
    {
      "name": "Suku Terakhir",
      "desc": "Separuh bulan kelihatan dari sebelah kiri.",
      "image": "assets/images/last_quarter.png"
    },
  ];

  int _currentIndex = 0;

  void _nextPhase() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _phases.length;
    });
  }

  void _prevPhase() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _phases.length) % _phases.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = _phases[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fasa Bulan"),
        backgroundColor: Colors.indigoAccent,
      ),
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                current["name"]!,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(current["image"]!, width: 150),
              const SizedBox(height: 20),
              Text(
                current["desc"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _prevPhase,
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.indigo,
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: _nextPhase,
                    icon: const Icon(Icons.arrow_forward),
                    color: Colors.indigo,
                    iconSize: 30,
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
