import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisah_nusantara_app/app/modules/course/budaya/views/webview_budaya.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BudayaDetailPage extends StatefulWidget {
  @override
  _BudayaDetailPageState createState() => _BudayaDetailPageState();
}

class _BudayaDetailPageState extends State<BudayaDetailPage> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller YouTube dengan ID video
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'Qq67SHLWM-I', // Ganti dengan ID video YouTube Anda
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
                  'Pengertian Budaya',
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
                    _buildTabButton('Description', true),
                    SizedBox(width: 16),
                    _buildTabButton('Playlist', false),
                  ],
                ),
                SizedBox(height: 16),
                // Course description
                Text(
                  'Budaya adalah keseluruhan sistem gagasan, tindakan, dan hasil karya manusia dalam kehidupan masyarakat yang dipelajari serta diwariskan turun-temurun. Pada materi ini, kamu akan mempelajari berbagai aspek budaya yang ada di Nusantara.',
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
                _buildPlaylistItem('Perkenalan Budaya', 23),
                _buildPlaylistItem('Macam Budaya Indonesia', 15),
                _buildPlaylistItem('Melestarikan Kebudayaan', 30),
                SizedBox(height: 24),
                // Start learning button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to YouTube WebView
                    Get.to(BudayaWebView(
                        url: 'https://id.wikipedia.org/wiki/Budaya_Indonesia'));
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
                '$duration minutes',
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
