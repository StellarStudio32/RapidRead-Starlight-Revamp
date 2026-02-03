import 'package:flutter/material.dart';
import 'package:rapid_read_v2/data/services/import_service.dart';
import 'package:rapid_read_v2/l10n/generated/app_localizations.dart';

class FilePickerButton extends StatefulWidget {
  final ImportService importService;
  final Function(bool success) onFileProcessed;

  const FilePickerButton({
    super.key,
    required this.importService,
    required this.onFileProcessed,
  });

  @override
  State<FilePickerButton> createState() => _FilePickerButtonState();
}

class _FilePickerButtonState extends State<FilePickerButton> {
  bool _isLoading = false;

  void _pickFile() async {
    setState(() {
      _isLoading = true;
    });

    final success = await widget.importService.pickAndProcessFile();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      widget.onFileProcessed(success);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ElevatedButton.icon(
            onPressed: _pickFile,
            icon: const Icon(Icons.upload_file),
            label: Text(AppLocalizations.of(context)!.importDocumentButton),
          );
  }
}
