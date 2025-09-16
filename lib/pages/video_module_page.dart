import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoModulePage extends StatelessWidget {
  VideoModulePage({super.key});

  final List<Map<String, String>> videos = [
    {
      'id': 'libKVRa01L8',
      'title': 'Penerangan Sistem Suria',
    },
    {
      'id': 'mQrlgH97v94',
      'title': 'Fakta Menarik tentang Planet',
    },
    {
      'id': '79M2lSVZiY4',
      'title': 'Penjelasan Fasa Bulan',
    },
    {
      'id': 'Qd6nLM2QlWw',
      'title': 'Kenali Rasi Bintang',
    },
  ];

  void openPlayer(BuildContext context, String videoId) {
    final controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => YoutubePlayerScaffold(
          controller: controller,
          builder: (context, player) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Tonton Video'),
                backgroundColor: const Color(0xFF81D4FA),
                foregroundColor: Colors.white,
                leading: const BackButton(color: Colors.white),
              ),
              body: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: player,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3DE),
      appBar: AppBar(
        title: const Text('Video Sistem Suria'),
        backgroundColor: const Color(0xFF81D4FA),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFDF6EE),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Video Pembelajaran',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF412E27),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: videos.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final video = videos[index];
                  final thumbnailUrl =
                      "https://img.youtube.com/vi/${video['id']}/0.jpg";

                  return GestureDetector(
                    onTap: () => openPlayer(context, video['id']!),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.network(
                              thumbnailUrl,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  height: 180,
                                  width: double.infinity,
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(
                                    color: Color(0xFF6A704C),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 180,
                                  width: double.infinity,
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.videocam_off,
                                    size: 60,
                                    color: Color(0xFF6A704C),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              video['title'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF412E27),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
