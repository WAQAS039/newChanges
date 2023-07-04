import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class StoryAndBasicPlayerProvider extends ChangeNotifier {
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double? _dragValue;
  bool _isPlaying = false;
  AudioPlayer? _audioPlayer;
  String _audioUrl = "";
  bool isLoading = true;

  Duration get position => _position;
  double? get dragValue => _dragValue;
  bool get isPlaying => _isPlaying;
  Duration get duration => _duration;
  AudioPlayer get audioPlayer => _audioPlayer!;
  String _image = "";
  String get image => _image;
  double _speed = 1.0;
  double get speed => _speed;
  Duration? _lastPosition;

  setImage(String image) {
    _image = image;
    notifyListeners();
  }

  void initAudioPlayer(String url, String image, BuildContext context) async {
    setImage(image);
    if (_audioPlayer == null) {
      _init(url, context);
    } else {
      _audioPlayer!.stop();
      _audioPlayer = null;
      _init(url, context);
    }
  }

  void initAudioPlayer2(String url, BuildContext context) async {
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
    /// to reset all the previous position and data
    setInitData(url);

    /// init audio player
    _audioPlayer = AudioPlayer();
    try {
      await _audioPlayer!.setUrl(url);
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
      setIsPlaying(event.playing);
      if (event.processingState == ProcessingState.buffering) {
        _lastPosition = _position;
        isLoading = true;
        _isPlaying = false;
        notifyListeners();
      } else if (event.processingState == ProcessingState.loading) {
        isLoading = true;
        notifyListeners();
      } else if (event.processingState == ProcessingState.ready) {
        isLoading = false;
        notifyListeners();
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

  void closePlayer() {
    if (_isPlaying) {
      _isPlaying = false;
      notifyListeners();
      _audioPlayer!.stop();
      _audioPlayer!.dispose();
    }
  }
}
