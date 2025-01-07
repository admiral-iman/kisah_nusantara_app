import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controllers/feedback_controller.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final FeedbackController _feedbackController = FeedbackController();
  int _selectedRating = 4;
  final List<String> likedOptions = [
    "Mudah digunakan",
    "Lengkap",
    "Membantu",
    "Nyaman",
    "Tampilan bagus"
  ];
  final List<String> improvementOptions = [
    "Bisa lebih banyak fitur",
    "Kompleks",
    "Hanya tersedia dalam bahasa Indonesia"
  ];
  final Set<String> selectedLikes = {};
  final Set<String> selectedImprovements = {};
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFD0B8),
        title: const Text(
          "Umpan Balik",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pembayaran Anda sudah selesai.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF153448),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Bagaimana Anda menilai Aplikasi Edukasi Budaya Nusantara?",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF153448),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedRating = index + 1;
                      });
                    },
                    icon: Icon(
                      Icons.star,
                      color: index < _selectedRating
                          ? const Color(0xFFFFD700)
                          : const Color(0xFF3C5B6F).withOpacity(0.4),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              const Text(
                "Apa yang Anda sukai?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF153448),
                ),
              ),
              Wrap(
                spacing: 8,
                children: likedOptions.map((option) {
                  return ChoiceChip(
                    label: Text(option),
                    selected: selectedLikes.contains(option),
                    labelStyle: TextStyle(
                      color: selectedLikes.contains(option)
                          ? Colors.white
                          : const Color(0xFF153448),
                    ),
                    backgroundColor: const Color(0xFFDFD0B8),
                    selectedColor: const Color(0xFF3C5B6F),
                    onSelected: (isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedLikes.add(option);
                        } else {
                          selectedLikes.remove(option);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                "Apa yang bisa ditingkatkan?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF153448),
                ),
              ),
              Wrap(
                spacing: 8,
                children: improvementOptions.map((option) {
                  return ChoiceChip(
                    label: Text(option),
                    selected: selectedImprovements.contains(option),
                    labelStyle: TextStyle(
                      color: selectedImprovements.contains(option)
                          ? Colors.white
                          : const Color(0xFF153448),
                    ),
                    backgroundColor: const Color(0xFFDFD0B8),
                    selectedColor: const Color(0xFF3C5B6F),
                    onSelected: (isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedImprovements.add(option);
                        } else {
                          selectedImprovements.remove(option);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                "Ada saran lain?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF153448),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: "Tuliskan di sini.",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: const Color(0xFFDFD0B8).withOpacity(0.3),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await _feedbackController.submitFeedback(
                      rating: _selectedRating,
                      likes: selectedLikes,
                      improvements: selectedImprovements,
                      comments: _commentController.text,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Feedback berhasil dikirim!")),
                    );

                    setState(() {
                      _selectedRating = 4;
                      selectedLikes.clear();
                      selectedImprovements.clear();
                      _commentController.clear();
                    });

                    Get.toNamed('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDFD0B8),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    "Kirim",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
