import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../shared/utills/app_colors.dart';

class Page7 extends StatefulWidget {
  bool isMultipleSelectionEnabled;
  final Function(bool) updateMultipleSelectionEnabled;
  Page7({
    Key? key,
    required this.isMultipleSelectionEnabled,
    required this.updateMultipleSelectionEnabled,
  }) : super(key: key);

  @override
  Page7State createState() => Page7State();
}

class Page7State extends State<Page7> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<String> _selectedAudioFiles = [];
  Set<int> _selectedContainers = {};
  List<String> audioFilePaths = [
    'assets/images/qaida/page1/noon.mp3',
    'assets/images/qaida/page7/na1.mp3',
    'assets/images/qaida/page7/na2.mp3',
    'assets/images/qaida/page7/na3.mp3',
    'assets/images/qaida/page7/na4.mp3',
    'assets/images/qaida/page1/wahoo.mp3',
    'assets/images/qaida/page7/wa1.mp3',
    'assets/images/qaida/page7/wa2.mp3',
    'assets/images/qaida/page7/wa3.mp3',
    'assets/images/qaida/page7/wa4.mp3',
    'assets/images/qaida/page1/haah.mp3',
    'assets/images/qaida/page7/han1.mp3',
    'assets/images/qaida/page7/han2.mp3',
    'assets/images/qaida/page7/han3.mp3',
    'assets/images/qaida/page7/han4.mp3',
    'assets/images/qaida/page1/yaa.mp3',
    'assets/images/qaida/page7/ya1.mp3',
    'assets/images/qaida/page7/ya2.mp3',
    'assets/images/qaida/page7/ya3.mp3',
    'assets/images/qaida/page7/ya4.mp3',
  ];
  int? _startIndex;
  int? _endIndex;

  List<bool> containerAudioPlayingStates = List.generate(20, (_) => false);
  int currentlyPlayingIndex = -1;

  void playSingleAudio(int index) async {
    if (containerAudioPlayingStates[index]) {
      await _audioPlayer.stop();
      setState(() {
        containerAudioPlayingStates[index] = false;
      });
    } else {
      final String audioPath = audioFilePaths[index];

      if (_audioPlayer.playing) {
        await _audioPlayer.stop();
      }

      await _audioPlayer.setAsset(audioPath);

      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() {
            containerAudioPlayingStates[index] = false;
          });
        }
      });

      setState(() {
        if (currentlyPlayingIndex != -1) {
          containerAudioPlayingStates[currentlyPlayingIndex] = false;
        }
        containerAudioPlayingStates[index] = true;
        currentlyPlayingIndex = index;
      });

      await _audioPlayer.play();
    }
  }

  void _toggleSelection(int index, String filePath) {
    if (_startIndex != null && _endIndex != null) {
      _selectedContainers.clear();
      _selectedAudioFiles.clear();
      _startIndex = null;
      _endIndex = null;
      AudioListHolder7.audioList.clear();
      widget.isMultipleSelectionEnabled = false;

      widget.updateMultipleSelectionEnabled(false);
    } else if (_startIndex == null) {
      _selectedContainers.clear();
      _selectedAudioFiles.clear();
      _selectedContainers.add(index);
      _startIndex = index;
    } else {
      _selectedContainers.clear();
      _selectedAudioFiles.clear();
      int start = _startIndex!;
      int end = index;
      for (int i = start; i <= end; i++) {
        _selectedContainers.add(i);
      }
      _endIndex = index;
      List<String> selectedAudioFiles = [];
      for (int i = start; i <= end; i++) {
        selectedAudioFiles.add(audioFilePaths[i]);
        print('_selectedAudioFiles: $selectedAudioFiles');
      }
      AudioListHolder7.audioList = selectedAudioFiles;
      widget.isMultipleSelectionEnabled = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadAudioFiles();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> loadAudioFiles() async {
    for (final filePath in audioFilePaths) {
      await _audioPlayer.setAsset(filePath);
    }
  }

  void clearSelection() {
    setState(() {
      _selectedContainers.clear();
      _selectedAudioFiles.clear();
      _startIndex = null;
      _endIndex = null;
      AudioListHolder7.audioList.clear();
      widget.isMultipleSelectionEnabled = false;
      widget.updateMultipleSelectionEnabled(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('widget is being called');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[2]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 1),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    2, audioFilePaths[2]);
                                              }
                                            : () async {
                                                playSingleAudio(2);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r1c1p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(2))
                                            if (_startIndex == 2)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 2)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[4]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 1),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    4, audioFilePaths[4]);
                                              }
                                            : () async {
                                                playSingleAudio(4);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r2c1p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(4))
                                            if (_startIndex == 4)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 4)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[7]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 1),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    7, audioFilePaths[7]);
                                              }
                                            : () async {
                                                playSingleAudio(7);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r3c1p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(7))
                                            if (_startIndex == 7)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 7)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[9]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                          left: BorderSide(width: 1),
                                          top: BorderSide(width: 1),
                                          bottom: BorderSide(width: .5)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    9, audioFilePaths[9]);
                                              }
                                            : () async {
                                                playSingleAudio(9);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r4c1p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(9))
                                            if (_startIndex == 9)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 9)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[12]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                          left: BorderSide(width: 1),
                                          top: BorderSide(width: 0.0),
                                          bottom: BorderSide(width: 0.5)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    12, audioFilePaths[12]);
                                              }
                                            : () async {
                                                playSingleAudio(12);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r5c1p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(12))
                                            if (_startIndex == 12)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 12)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[14]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                          left: BorderSide(width: 1),
                                          top: BorderSide(width: .5)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    14, audioFilePaths[14]);
                                              }
                                            : () async {
                                                playSingleAudio(14);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r6c1p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(14))
                                            if (_startIndex == 14)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 14)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[17]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                          left: BorderSide(width: 1),
                                          top: BorderSide(width: 1)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    17, audioFilePaths[17]);
                                              }
                                            : () async {
                                                playSingleAudio(17);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r7c1p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(17))
                                            if (_startIndex == 17)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 17)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[19]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                          left: BorderSide(width: 1),
                                          bottom: BorderSide(width: 1),
                                          top: BorderSide(width: 1)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    19, audioFilePaths[19]);
                                              }
                                            : () async {
                                                playSingleAudio(19);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r8c1p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(19))
                                            if (_startIndex == 19)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 19)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[1]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                          left: BorderSide(width: 1),
                                          top: BorderSide(width: 1),
                                          right: BorderSide(width: 1)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    1, audioFilePaths[1]);
                                              }
                                            : () async {
                                                playSingleAudio(1);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r1c2p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(1))
                                            if (_startIndex == 1)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 1)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[3]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                          left: BorderSide(width: 1),
                                          top: BorderSide(width: 1),
                                          right: BorderSide(width: 1)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    3, audioFilePaths[3]);
                                              }
                                            : () async {
                                                playSingleAudio(3);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r2c2p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(3))
                                            if (_startIndex == 3)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 3)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[6]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 1),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    6, audioFilePaths[6]);
                                              }
                                            : () async {
                                                playSingleAudio(6);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r3c2p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(6))
                                            if (_startIndex == 6)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 6)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[8]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                          left: BorderSide(width: 1),
                                          top: BorderSide(width: 1),
                                          bottom: BorderSide(width: 0.0)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    8, audioFilePaths[8]);
                                              }
                                            : () async {
                                                playSingleAudio(8);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r4c2p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(8))
                                            if (_startIndex == 8)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 8)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[11]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                          left: BorderSide(width: 1),
                                          top: BorderSide(width: 1),
                                          bottom: BorderSide(width: 0.5)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    11, audioFilePaths[11]);
                                              }
                                            : () async {
                                                playSingleAudio(11);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r5c2p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(11))
                                            if (_startIndex == 11)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 11)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[13]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                          left: BorderSide(width: 1),
                                          top: BorderSide(width: 0.5)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    13, audioFilePaths[13]);
                                              }
                                            : () async {
                                                playSingleAudio(13);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r6c2p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(13))
                                            if (_startIndex == 13)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 13)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[16]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                          left: BorderSide(width: 1),
                                          top: BorderSide(width: 1)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    16, audioFilePaths[16]);
                                              }
                                            : () async {
                                                playSingleAudio(16);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r7c2p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(16))
                                            if (_startIndex == 16)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 16)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[18]
                                          ? AppColors.lightBrandingColor
                                          : Colors.transparent,
                                      border: const Border(
                                          left: BorderSide(width: 1),
                                          bottom: BorderSide(width: 1),
                                          top: BorderSide(width: 1)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    18, audioFilePaths[18]);
                                              }
                                            : () async {
                                                playSingleAudio(18);
                                              },
                                        child: Stack(children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 2.0,
                                                child: Image.asset(
                                                  'assets/images/qaida/page7/r8c2p7.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(18))
                                            if (_startIndex == 18)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_left.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            else if (_endIndex == 18)
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  'assets/images/qaida/arrow_right.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                        ]))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: containerAudioPlayingStates[0]
                                    ? AppColors.lightBrandingColor
                                    : Colors.transparent,
                                border: const Border(
                                    right: BorderSide(width: 1),
                                    bottom: BorderSide(width: 1),
                                    top: BorderSide(width: 1)),
                              ),
                              child: InkWell(
                                  onTap: widget.isMultipleSelectionEnabled
                                      ? () {
                                          _toggleSelection(
                                              0, audioFilePaths[0]);
                                        }
                                      : () async {
                                          playSingleAudio(0);
                                        },
                                  child: Stack(children: [
                                    FractionallySizedBox(
                                      widthFactor: 1.0,
                                      heightFactor: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: AspectRatio(
                                          aspectRatio: 1.1,
                                          child: Image.asset(
                                            'assets/images/qaida/page7/c1p7.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (_selectedContainers.contains(0))
                                      if (_startIndex == 0)
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Image.asset(
                                            'assets/images/qaida/arrow_left.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                        )
                                      else if (_endIndex == 0)
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Image.asset(
                                            'assets/images/qaida/arrow_right.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                        )
                                  ]))),
                        ),
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: containerAudioPlayingStates[5]
                                    ? AppColors.lightBrandingColor
                                    : Colors.transparent,
                                border: const Border(
                                    left: BorderSide(width: 1),
                                    right: BorderSide(width: 1),
                                    bottom: BorderSide(width: 1)),
                              ),
                              child: InkWell(
                                  onTap: widget.isMultipleSelectionEnabled
                                      ? () {
                                          _toggleSelection(
                                              5, audioFilePaths[5]);
                                        }
                                      : () async {
                                          playSingleAudio(5);
                                        },
                                  child: Stack(children: [
                                    FractionallySizedBox(
                                      widthFactor: 1.0,
                                      heightFactor: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: AspectRatio(
                                          aspectRatio: 1.1,
                                          child: Image.asset(
                                            'assets/images/qaida/page7/c2p7.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (_selectedContainers.contains(5))
                                      if (_startIndex == 5)
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Image.asset(
                                            'assets/images/qaida/arrow_left.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                        )
                                      else if (_endIndex == 5)
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Image.asset(
                                            'assets/images/qaida/arrow_right.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                        )
                                  ]))),
                        ),
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: containerAudioPlayingStates[10]
                                    ? AppColors.lightBrandingColor
                                    : Colors.transparent,
                                border: const Border(
                                    left: BorderSide(width: 1),
                                    right: BorderSide(width: 1)),
                              ),
                              child: InkWell(
                                  onTap: widget.isMultipleSelectionEnabled
                                      ? () {
                                          _toggleSelection(
                                              10, audioFilePaths[10]);
                                        }
                                      : () async {
                                          playSingleAudio(10);
                                        },
                                  child: Stack(children: [
                                    FractionallySizedBox(
                                      widthFactor: 1.0,
                                      heightFactor: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: AspectRatio(
                                          aspectRatio: 1.1,
                                          child: Image.asset(
                                            'assets/images/qaida/page7/c3p7.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (_selectedContainers.contains(10))
                                      if (_startIndex == 10)
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Image.asset(
                                            'assets/images/qaida/arrow_left.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                        )
                                      else if (_endIndex == 10)
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Image.asset(
                                            'assets/images/qaida/arrow_right.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                        )
                                  ]))),
                        ),
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: containerAudioPlayingStates[15]
                                    ? AppColors.lightBrandingColor
                                    : Colors.transparent,
                                border: const Border(
                                    left: BorderSide(width: 1),
                                    right: BorderSide(width: 1),
                                    top: BorderSide(width: 1),
                                    bottom: BorderSide(width: 1)),
                              ),
                              child: InkWell(
                                  onTap: widget.isMultipleSelectionEnabled
                                      ? () {
                                          _toggleSelection(
                                              15, audioFilePaths[15]);
                                        }
                                      : () async {
                                          playSingleAudio(15);
                                        },
                                  child: Stack(children: [
                                    FractionallySizedBox(
                                      widthFactor: 1.0,
                                      heightFactor: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: AspectRatio(
                                          aspectRatio: 1.1,
                                          child: Image.asset(
                                            'assets/images/qaida/page7/c4p7.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (_selectedContainers.contains(15))
                                      if (_startIndex == 15)
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Image.asset(
                                            'assets/images/qaida/arrow_left.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                        )
                                      else if (_endIndex == 15)
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Image.asset(
                                            'assets/images/qaida/arrow_right.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                        )
                                  ]))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AudioListHolder7 {
  static List<String> audioList = [];
  static int pageId = 7;
}
