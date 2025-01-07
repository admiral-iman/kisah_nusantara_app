import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ulasan Pengguna"),
        backgroundColor: const Color(0xFFDFD0B8),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('feedbacks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Terjadi kesalahan: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada ulasan yang tersedia.",
                style: TextStyle(fontSize: 16, color: Color(0xFF948979)),
              ),
            );
          }

          final feedbacks = snapshot.data!.docs;

          return ListView.builder(
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              final feedback = feedbacks[index].data() as Map<String, dynamic>?;

              if (feedback == null) {
                return const Text("Data tidak valid.");
              }

              final rating = feedback['rating'] ?? 0;
              final likes = feedback['likes'] ?? [];
              final improvements = feedback['improvements'] ?? [];
              final comments = feedback['comments'] ?? "Tidak ada komentar";

              return Card(
                color: Colors.white, // Warna putih untuk card
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rating: ${'⭐' * rating}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3C5B6F),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (likes.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Suka:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF153448),
                              ),
                            ),
                            Text(
                              (likes as List<dynamic>).join(', '),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      if (improvements.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            const Text(
                              "Peningkatan:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF153448),
                              ),
                            ),
                            Text(
                              (improvements as List<dynamic>).join(', '),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text(
                        "Komentar:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF153448),
                        ),
                      ),
                      Text(
                        comments,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
