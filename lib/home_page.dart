import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_reader/file_repo.dart';
import 'package:file_reader/reader_file.dart';
import 'package:flutter/material.dart';

import 'file_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var fileRepo = FileRepo();
  var filesAccessed = <String>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Reader"),
        backgroundColor: Color.fromARGB(255, 156, 26, 26),
      ),
      body: FutureBuilder(
        future: fileRepo.getFiles(),
        builder: ((context, snapshot) {
          if (snapshot.data == null) return CircularProgressIndicator();

          // assign data to list of file accessed
          filesAccessed = snapshot.data as List<String>;
          return ListView.builder(
              itemCount: filesAccessed.length,
              itemBuilder: (context, index) {
                var filePath = filesAccessed[index];
                return Dismissible(
                  key: Key(filePath),
                  onDismissed: ((direction) {
                    fileRepo.removeFile(filePath);
                    filesAccessed.remove(filePath);
                    setState(() {});
                  }),
                  child: InkWell(
                    onTap: (() => openPageReader(context, File(filePath))),
                    child: FileItem(filePath),
                  ),
                );
              });
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.folder_open),
        onPressed: () async {
          await _selectFile(context);
        },
      ),
    );
  }

  Future<void> _selectFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      String path = result.files.single.path!;
      File file = File(path);

      openPageReader(context, file);

      setState(() {
        filesAccessed.add(path);
        // save to storage
        fileRepo.saveFiles(filesAccessed);
      });
    } else {
      // User canceled the picke
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("File Selection Cancelled")));
    }
  }

  void openPageReader(BuildContext context, File file) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ReaderFile(document: file)));
  }
}
