import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:rapid_read_v2/data/services/service_locator.dart';
import 'package:rapid_read_v2/presentation/controllers/rsvp_controller.dart';

class RsvpScreen extends StatefulWidget {
  final String text;
  final int wpm;
  final int docId;
  final int initialIndex;
  final int? sessionId;

  const RsvpScreen({
    super.key,
    required this.text,
    this.wpm = 300,
    required this.docId,
    required this.initialIndex,
    this.sessionId,
  });

  @override
  State<RsvpScreen> createState() => _RsvpScreenState();
}

class _RsvpScreenState extends State<RsvpScreen>
    with SingleTickerProviderStateMixin {
  late final RsvpController _controller;
  late final AppLifecycleListener _listener;
  Timer? _autoSaveTimer;
  bool _wasPlaying = false;
  bool _didSaveCompletion = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _controller = RsvpController(
      text: widget.text,
      vsync: this,
      documentId: widget.docId,
      wpm: widget.wpm,
      initialIndex: widget.initialIndex,
    );
    if (widget.sessionId != null) {
      _controller.readingSession.id = widget.sessionId!;
    }
    _controller.addListener(_onControllerUpdate);
    _controller.start();
    _startAutoSaveTimer();
    _persistSession();

    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
  }

  void _onStateChanged(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _persistSession();
    }
  }

  Future<void> _persistSession() async {
    final isar = getIt<Isar>();
    final session = _controller.readingSession;
    session
      ..documentId = widget.docId
      ..currentWordIndex = _controller.currentIndex
      ..totalWords = _controller.totalWords
      ..isCompleted = _controller.isFinished;

    await isar.writeTxn(() async {
      final sessionId = await isar.readingSessions.put(session);
      session.id = sessionId;
    });
  }

  void _onControllerUpdate() {
    if (_wasPlaying && !_controller.isPlaying) {
      _persistSession();
    }
    _wasPlaying = _controller.isPlaying;
    if (_controller.isFinished && !_didSaveCompletion) {
      _didSaveCompletion = true;
      _persistSession();
    }
    // This is to rebuild the widget when the controller notifies listeners
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller.removeListener(_onControllerUpdate);
    _autoSaveTimer?.cancel();
    _persistSession();
    _controller.dispose();
    _listener.dispose();
    super.dispose();
  }

  void _startAutoSaveTimer() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_controller.isPlaying) {
        _persistSession();
      }
    });
  }

  double _progressValue() {
    if (_controller.totalWords == 0) {
      return 0.0;
    }
    return (_controller.currentIndex / _controller.totalWords).clamp(0.0, 1.0);
  }



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final textScaler = mediaQuery.textScaler.clamp(minScaleFactor: 1.0, maxScaleFactor: 1.5);


    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        await _persistSession();

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0,
                      end: _progressValue(),
                    ),
                    duration: const Duration(milliseconds: 200),
                    builder: (context, value, child) {
                      return LinearProgressIndicator(
                        value: value,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      );
                    },
                  ),
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
