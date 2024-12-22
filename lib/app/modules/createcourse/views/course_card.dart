import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  CourseCard(
      {required this.course, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(course['name']),
        subtitle: Text(course['description']),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
