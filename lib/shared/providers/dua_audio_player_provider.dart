import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class DuaPlayerProvider extends ChangeNotifier {
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double? _dragValue;
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  AudioPlayer? _audioPlayer;
  String _audioUrl = "";
  bool isLoading = true;
  double _speed = 1.0;
  Duration? _lastPosition;
  bool _isLoopMode = false;
  bool get isLoopMode => _isLoopMode;

  double get speed => _speed;
  Duration get duration => _duration;
  Duration get position => _position;
  double? get dragValue => _dragValue;
  AudioPlayer get audioPlayer => _audioPlayer!;

  void initAudioPlayer(String url, BuildContext context) async {
    if (_audioPlayer == null) {
      _init(url, context);
    } else {
      _audioPlayer!.stop();
      _audioPlayer = null;
      _init(url, context);
    }
  }

  setInitData(String url) {
    _audioUrl = url;
    isLoading = true;
    _position = Duration.zero;
    _duration = Duration.zero;
    notifyListeners();
  }

  void _init(String url, BuildContext context) async {
    // Reset all the previous position and data
    setInitData(url);

    // Init audio player
    _audioPlayer = AudioPlayer();
    try {
      await _audioPlayer!.setUrl(url);
      // print('Audio player URL set: $url');
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(e.message!)));
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Error Occur')));
    }
    _audioPlayer!.playerStateStream.listen((event) {
      print('Player state changed: ${event.processingState}');
      setIsPlaying(event.playing);
      if (event.processingState == ProcessingState.buffering) {
        _lastPosition = _position;

        // Update isLoading to true when buffering
        isLoading = true;
        _isPlaying = false;
        notifyListeners();
        print('Buffering...');
      } else if (event.processingState == ProcessingState.ready) {
        // Update isLoading to false when ready
        isLoading = false;
        notifyListeners();
        print('Ready to play');
      } else if (event.processingState == ProcessingState.completed) {
        _audioPlayer!.seek(Duration.zero);
        _audioPlayer!.pause();
      }
    });

    _audioPlayer!.durationStream.listen((duration) {
      if (duration != null) {
        setDuration(duration);
      }
    });
    _audioPlayer!.positionStream.listen((position) {
      setPosition(position);
    });
    // await _audioPlayer!.setFilePath(file);
    // Catching errors during playback (e.g. lost network connection)
    _audioPlayer!.playbackEventStream.listen((state) {},
        onError: (Object e, StackTrace st) {
      if (e is PlayerException) {
        // ScaffoldMessenger.of(RouteHelper.currentContext).showSnackBar(SnackBar(content: Text(e.message!)));
        // print('Error --> ${e.message}');
      } else {
        checkNetwork();
        // ScaffoldMessenger.of(RouteHelper.currentContext).showSnackBar(const SnackBar(content: Text('Network Error')));
        print('An error occurred: $e');
      }
    });
  }

  checkNetwork() async {
    final Connectivity connectivity = Connectivity();
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      connectivityResult = result;
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        await _audioPlayer!.setUrl(_audioUrl);
        _audioPlayer!.seek(_lastPosition);
        await _audioPlayer!.play();
      }
    });
  }

  setSpeed() {
    _speed = _speed + 0.5;
    _audioPlayer!.setSpeed(_speed);
    if (_speed > 2.0) {
      _speed = 0.5;
      _audioPlayer!.setSpeed(1.0);
    }
    notifyListeners();
  }

  Future<void> play() async {
    setIsPlaying(true);
    await _audioPlayer!.play();
  }

  Future<void> pause() async {
    setIsPlaying(false);
    await _audioPlayer!.pause();
  }

  void setIsPlaying(bool isPlay) async {
    _isPlaying = isPlay;
    notifyListeners();
  }

  void setDuration(Duration duration) {
    _duration = duration;
    notifyListeners();
  }

  void setPosition(Duration position) {
    _position = position;
    notifyListeners();
  }

  void seek(Duration position) {
    _dragValue = position.inSeconds.toDouble();
    notifyListeners();
  }

  void setLoopMode(bool value) {
    _isLoopMode = value;
    notifyListeners();
  }

  void closePlayer() {
    if (_isPlaying) {
      _isPlaying = false;
      notifyListeners();
      _audioPlayer!.stop();
      _audioPlayer!.dispose();
    }
  }
}
