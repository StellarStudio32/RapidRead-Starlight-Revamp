import 'package:flutter/material.dart';
import 'package:rapid_read_v2/data/services/import_service.dart';
import 'package:rapid_read_v2/data/services/service_locator.dart';
import 'package:rapid_read_v2/domain/entities/source_document.dart';
import 'package:provider/provider.dart';
import 'package:rapid_read_v2/l10n/generated/app_localizations.dart';
import 'package:rapid_read_v2/presentation/providers/locale_provider.dart';
import 'package:rapid_read_v2/presentation/widgets/file_picker_button.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:intl/intl.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final Isar isar = getIt<Isar>();
  late Stream<List<SourceDocument>> documentsStream;

  @override
  void initState() {
    super.initState();
    documentsStream = isar.sourceDocuments.where().watch(fireImmediately: true);
  }

  void _onFileProcessed(bool success) {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? l10n.fileImportSuccess : l10n.fileImportFailed),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.libraryScreenTitle),
        actions: [
          FilePickerButton(
            importService: getIt<ImportService>(),
            onFileProcessed: _onFileProcessed,
          ),
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (Locale locale) {
              context.read<LocaleProvider>().setLocale(locale);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
              const PopupMenuItem<Locale>(
                value: Locale('en'),
                child: Text('English'),
              ),
              const PopupMenuItem<Locale>(
                value: Locale('es'),
                child: Text('Español'),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<List<SourceDocument>>(
        stream: documentsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noDocumentsFound),
            );
          }

          final documents = snapshot.data!;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final doc = documents[index];
              return ListTile(
                title: Text(doc.title),
                subtitle: Text('Added on ${DateFormat.yMMMd().format(doc.dateAdded.toLocal())}'),
                onTap: () {
                  context.go(
                    '/rsvp',
                    extra: {
                      'text': doc.content,
                      'wpm': '300',
                      'docId': doc.id.toString(),
                      'initialIndex': doc.lastPosition.toString(),
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
