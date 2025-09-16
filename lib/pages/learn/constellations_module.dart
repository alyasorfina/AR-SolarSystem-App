import 'package:flutter/material.dart';

class ConstellationsModule extends StatelessWidget {
  const ConstellationsModule({super.key});

  Widget constellationCard(String name, String imagePath, String story) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    story,
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: const Text(
          "Modul Pembelajaran: Buruj",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "🌌 Kenali Buruj",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "Buruj ialah kumpulan bintang yang membentuk corak tertentu di langit malam. Mari kenali beberapa buruj yang terkenal!",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            constellationCard(
              "Orion",
              "assets/images/orion.png",
              "Orion ialah seorang pemburu gergasi dalam mitologi Yunani. Buruj ini mudah dikenali kerana terdapat tiga bintang selari di bahagian tengahnya, dikenali sebagai ‘Tali Pinggang Orion’.",
            ),
            constellationCard(
              "Ursa Major",
              "assets/images/ursa_major.jpg",
              "Ursa Major bermaksud 'Beruang Besar'. Ia juga dikenali sebagai Big Dipper kerana bentuknya seperti senduk besar. Ia digunakan untuk mencari arah Utara.",
            ),
            constellationCard(
              "Scorpius",
              "assets/images/scorpius.jpg",
              "Scorpius berbentuk seperti kala jengking. Dalam cerita mitologi, kala jengking ini dikatakan telah membunuh Orion.",
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
