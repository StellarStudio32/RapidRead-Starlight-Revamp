import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as p;
import 'package:rapid_read_v2/domain/entities/source_document.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:docx_to_text/docx_to_text.dart';

class ImportService {
  final Isar isar;

  ImportService(this.isar);

  Future<bool> pickAndProcessFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx', 'txt'],
      );

      if (result == null || result.files.single.path == null) {
        return false;
      }

      final file = File(result.files.single.path!);
      final fileName = p.basenameWithoutExtension(file.path);
      String content;

      final extension = p.extension(file.path).toLowerCase();

      switch (extension) {
        case '.pdf':
          content = await _parsePdf(file);
          break;
        case '.docx':
          content = await _parseDocx(file);
          break;
        case '.txt':
          content = await _parseTxt(file);
          break;
        default:
          throw Exception('Unsupported file type: $extension');
      }

      if (content.trim().isEmpty) {
        // Handle empty file case
        return false;
      }

      final sanitizedContent = _sanitizeText(content);

      final document = SourceDocument()
        ..title = fileName
        ..content = sanitizedContent
        ..dateAdded = DateTime.now();

      await isar.writeTxn(() async {
        await isar.sourceDocuments.put(document);
      });

      return true;
    } catch (e) {
      // Handle exceptions, e.g., parsing errors, file system errors
      debugPrint('Error picking and processing file: $e');
      return false;
    }
  }

  Future<String> _parsePdf(File file) async {
    final bytes = await file.readAsBytes();
    final PdfDocument document = PdfDocument(inputBytes: bytes);
    final String text = PdfTextExtractor(document).extractText();
    document.dispose();
    return text;
  }

  Future<String> _parseDocx(File file) async {
    final bytes = await file.readAsBytes();
    return docxToText(bytes);
  }

  Future<String> _parseTxt(File file) async {
    return file.readAsString();
  }

  String _sanitizeText(String text) {
    // Normalize whitespace: replace tabs and multiple spaces with a single space
    // and standardize line breaks.
    return text.replaceAll(RegExp(r'\t|\s{2,}'), ' ').replaceAll(RegExp(r'\r\n|\r'), '\n').trim();
  }
}