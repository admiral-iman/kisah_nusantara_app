import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitFeedback({
    required int rating,
    required Set<String> likes,
    required Set<String> improvements,
    required String comments,
  }) async {
    try {
      // Menyimpan data feedback ke koleksi 'feedbacks' di Firestore
      await _firestore.collection('feedbacks').add({
        'rating': rating,
        'likes':
            likes.toList(), // Ubah ke list karena Firestore tidak mendukung set
        'improvements': improvements.toList(),
        'comments': comments,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Feedback berhasil dikirim!");
    } catch (e) {
      print("Terjadi kesalahan saat mengirim feedback: $e");
    }
  }
}
