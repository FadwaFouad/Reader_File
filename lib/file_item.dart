import 'package:flutter/material.dart';

class FileItem extends StatelessWidget {
  const FileItem(this.filePath, {super.key});
  final filePath;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      color: Colors.grey.shade100,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          backgroundImage: AssetImage(
            "images/pdf.png",
          ),
        ),
        trailing: Icon(
          Icons.star_border_purple500,
          color: Colors.yellow.shade600,
        ),
        title: Text(
          "${filePath.split("/").last}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
