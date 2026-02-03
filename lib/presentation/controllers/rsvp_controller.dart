import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rapid_read_v2/domain/entities/reading_session.dart';

class RsvpController extends ChangeNotifier {
  RsvpController({
    required String text,
    required TickerProvider vsync,
    int wpm = 300,
    int initialIndex = 0,
  })  : _vsync = vsync,
        _wpm = wpm {
    _words = _tokenize(text);
    if (initialIndex >= 0 && initialIndex < _words.length) {
      currentIndex = initialIndex;
    }
    _session = ReadingSession()..words = _words;
    _ticker = _vsync.createTicker(_onTick);
  }

  final TickerProvider _vsync;
  late final Ticker _ticker;
  late final ReadingSession _session;
  late List<String> _words;

  int _wpm;
  int get wpm => _wpm;

  int currentIndex = 0;
  bool isFinished = false;

  String get currentWord {
    if (_words.isEmpty || currentIndex < 0 || currentIndex >= _words.length) {
      return "";
    }
    return _words[currentIndex];
  }

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  Duration _elapsed = Duration.zero;
  DateTime? _pauseStartTime;
  Duration _totalPausedDuration = Duration.zero;

  void start() {
    if (_words.isEmpty) return;
    isFinished = false;
    _session.startTimestamp = DateTime.now();
    _ticker.start();
    _isPlaying = true;
    notifyListeners();
  }

  void togglePlayPause() {
    if (_ticker.isTicking) {
      pause();
    } else {
      _play();
    }
  }

  void _play() {
    if (_pauseStartTime != null) {
      _totalPausedDuration += DateTime.now().difference(_pauseStartTime!);
      _pauseStartTime = null;
    }
    _elapsed = Duration.zero;
    _ticker.start();
    _isPlaying = true;
    notifyListeners();
  }

  void pause() {
    _ticker.stop();
    _isPlaying = false;
    _pauseStartTime = DateTime.now();
    notifyListeners();
  }

  void skip(int wordCount) {
    currentIndex = (currentIndex + wordCount).clamp(0, _words.length - 1);
    notifyListeners();
  }

  void updateWpm(int newWpm) {
    _wpm = newWpm;
    notifyListeners();
  }

  void _onTick(Duration elapsed) {
    final delay = 60000 / _wpm;
    if (elapsed.inMilliseconds - _elapsed.inMilliseconds >= delay) {
      if (currentIndex < _words.length - 1) {
        currentIndex++;
        _elapsed = elapsed;
        notifyListeners();
      } else {
        _endSession();
      }
    }
  }

  ReadingSession get readingSession => _session;

  void _endSession() {
    _ticker.stop();
    _isPlaying = false;
    _session.endTimestamp = DateTime.now();
    final totalDuration = _session.endTimestamp!.difference(_session.startTimestamp);
    _session.totalActiveMilliseconds = (totalDuration - _totalPausedDuration).inMilliseconds;

    isFinished = true;
    notifyListeners();
    // Here you would typically save the session to Isar
  }

  List<String> _tokenize(String text) {
    // This regex splits by whitespace and keeps punctuation attached to the word.
    return text.split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
