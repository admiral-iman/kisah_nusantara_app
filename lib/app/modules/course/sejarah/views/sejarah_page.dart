import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisah_nusantara_app/app/modules/course/sejarah/views/webview_sejarah.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SejarahDetailPage extends StatefulWidget {
  @override
  _SejarahDetailPageState createState() => _SejarahDetailPageState();
}

class _SejarahDetailPageState extends State<SejarahDetailPage> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    // Initialize the YouTube controller with the video ID
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'HHCYODQ9Unw', // Replace with your YouTube video ID
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
                  'Sejarah Indonesia',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3C5B6F),
                  ),
                ),
                SizedBox(height: 16),
                // YouTube Player in a SizedBox
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
                  'Sejarah Indonesia adalah perjalanan panjang bangsa Indonesia dari masa prasejarah hingga era modern yang dipenuhi dengan perjuangan, kemerdekaan, dan perubahan sosial yang sangat berpengaruh terhadap perkembangan budaya dan politik negara. Di materi ini, kamu akan mempelajari berbagai peristiwa sejarah yang membentuk bangsa Indonesia.',
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
                _buildPlaylistItem('Pengenalan Sejarah Indonesia', 20),
                _buildPlaylistItem('Perjuangan Kemerdekaan', 25),
                _buildPlaylistItem('Pembangunan Pasca Kemerdekaan', 30),
                SizedBox(height: 24),
                // Start learning button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to YouTube WebView
                    Get.to(SejarahWebView(
                        url:
                            'https://id.wikipedia.org/wiki/Sejarah_Indonesia'));
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
