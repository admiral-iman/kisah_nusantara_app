import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisah_nusantara_app/app/modules/course/bahasa/views/webview_bahasa.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BahasaDetailPage extends StatefulWidget {
  @override
  _BahasaDetailPageState createState() => _BahasaDetailPageState();
}

class _BahasaDetailPageState extends State<BahasaDetailPage> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller YouTube dengan ID video
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'Ll0FkTB9udo', // Ganti dengan ID video YouTube Anda
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF4EDE5),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button and bookmark icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Get.back(),
                    ),
                    IconButton(
                      icon: Icon(Icons.bookmark_outline),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Title
                Text(
                  'Pengertian Bahasa Indonesia',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3C5B6F),
                  ),
                ),
                SizedBox(height: 16),
                // YouTube Player dalam SizedBox
                SizedBox(
                  height: 200,
                  child: YoutubePlayer(
                    controller: _youtubeController,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                    onReady: () {
                      print('YouTube Player is ready.');
                    },
                  ),
                ),
                SizedBox(height: 24),
                // Tabs for Description and Playlist
                Row(
                  children: [
                    _buildTabButton('Deskripsi', true),
                    SizedBox(width: 16),
                    _buildTabButton('Playlist', false),
                  ],
                ),
                SizedBox(height: 16),
                // Course description
                Text(
                  'Bahasa Indonesia adalah bahasa resmi negara Indonesia yang digunakan sebagai alat komunikasi antarwarga negara dari berbagai daerah dengan bahasa daerah yang berbeda. Bahasa ini juga menjadi identitas bangsa yang memiliki kedudukan penting dalam kehidupan sosial, budaya, dan pendidikan di Indonesia.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF3C5B6F),
                  ),
                ),
                SizedBox(height: 24),
                // Playlist section
                Text(
                  'Playlist',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3C5B6F),
                  ),
                ),
                SizedBox(height: 12),
                _buildPlaylistItem('Pengenalan Bahasa Indonesia', 18),
                _buildPlaylistItem('Sejarah Perkembangan Bahasa', 20),
                _buildPlaylistItem('Peranan Bahasa dalam Kehidupan ', 22),
                SizedBox(height: 24),
                // Start learning button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to YouTube WebView
                    Get.to(BahasaWebView(
                        url: 'https://id.wikipedia.org/wiki/Bahasa_Indonesia'));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF3C5B6F),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Mulai Belajar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for tab button
  Widget _buildTabButton(String title, bool isSelected) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF3C5B6F) : Color(0xFFDFD0B8),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFF3C5B6F),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Widget for playlist item
  Widget _buildPlaylistItem(String title, int duration) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.play_circle_fill, color: Color(0xFF3C5B6F), size: 30),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3C5B6F),
                ),
              ),
              Text(
                '$duration menit',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7C8A9A),
                ),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.lock_outline, color: Color(0xFF7C8A9A)),
        ],
      ),
    );
  }
}
