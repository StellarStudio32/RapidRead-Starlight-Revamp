import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rapid_read_v2/data/services/service_locator.dart';
import 'package:rapid_read_v2/domain/entities/source_document.dart';
import 'package:rapid_read_v2/presentation/controllers/rsvp_controller.dart';
import 'package:isar/isar.dart';

class RsvpScreen extends StatefulWidget {
  final String text;
  final int wpm;
  final int docId;
  final int initialIndex;

  const RsvpScreen({
    super.key,
    required this.text,
    this.wpm = 300,
    required this.docId,
    required this.initialIndex,
  });

  @override
  State<RsvpScreen> createState() => _RsvpScreenState();
}

class _RsvpScreenState extends State<RsvpScreen>
    with SingleTickerProviderStateMixin {
  late final RsvpController _controller;
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _controller = RsvpController(
      text: widget.text,
      vsync: this,
      wpm: widget.wpm,
      initialIndex: widget.initialIndex,
    );
    _controller.addListener(_onControllerUpdate);
    _controller.start();

    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
  }

  void _onStateChanged(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _savePosition();
    }
  }

  void _savePosition() async {
    final isar = getIt<Isar>();
    final doc = await isar.sourceDocuments.get(widget.docId);

    if (doc != null) {
      if (_controller.isFinished) {
        doc.lastPosition = 0;
      } else {
        doc.lastPosition = _controller.currentIndex;
      }
      await isar.writeTxn(() async {
        await isar.sourceDocuments.put(doc);
      });
    }
  }

  void _onControllerUpdate() {
    // This is to rebuild the widget when the controller notifies listeners
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller.removeListener(_onControllerUpdate);
    _controller.dispose();
    _listener.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final textScaler = mediaQuery.textScaler.clamp(minScaleFactor: 1.0, maxScaleFactor: 1.5);


    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        _savePosition();

        if (!mounted) return;
        context.pop(_controller.readingSession);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      _controller.currentWord,
                      textAlign: TextAlign.center,
                      textScaler: textScaler,
                      style: const TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous, color: Colors.white),
                      onPressed: () => _controller.skip(-1),
                    ),
                    IconButton(
                      icon: Icon(
                        _controller.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onPressed: _controller.togglePlayPause,
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next, color: Colors.white),
                      onPressed: () => _controller.skip(1),
                    ),
                  ],
                ),
                Slider(
                  value: _controller.wpm.toDouble(),
                  min: 100,
                  max: 800,
                  divisions: 14,
                  label: _controller.wpm.round().toString(),
                  onChanged: (double value) {
                    _controller.updateWpm(value.toInt());
                  },
                ),
              ],
            ),
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
