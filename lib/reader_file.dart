import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

///Responsible for opening the PDF file
class ReaderFile extends StatefulWidget {
  const ReaderFile({super.key, required this.document});
  final File document;

  @override
  State<ReaderFile> createState() => _ReaderFileState();
}

class _ReaderFileState extends State<ReaderFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfViewPinch(
        controller: PdfControllerPinch(
            document: PdfDocument.openFile(widget.document.path)),
      ),
    );
  }
}
