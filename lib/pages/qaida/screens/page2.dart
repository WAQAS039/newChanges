import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../shared/utills/app_colors.dart';

class Page2 extends StatefulWidget {
  bool isMultipleSelectionEnabled;
  final Function(bool) updateMultipleSelectionEnabled;

  Page2({
    Key? key,
    required this.isMultipleSelectionEnabled,
    required this.updateMultipleSelectionEnabled,
  }) : super(key: key);

  @override
  Page2State createState() => Page2State();
}

class Page2State extends State<Page2> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _startIndex;
  int? _endIndex;
  List<String> _selectedAudioFiles = [];
  Set<int> _selectedContainers = {};

  List<bool> containerAudioPlayingStates = List.generate(20, (_) => false);
  int currentlyPlayingIndex = -1;

  Map<String, int> audioIndexMap = {
    'assets/images/qaida/page1/alif.mp3': 0,
    'assets/images/qaida/page2/a01.mp3': 1,
    'assets/images/qaida/page2/a02.mp3': 2,
    'assets/images/qaida/page2/a03.mp3': 3,
    'assets/images/qaida/page2/a04.mp3': 4,
    'assets/images/qaida/page1/baa1.mp3': 5,
    'assets/images/qaida/page2/b01.mp3': 6,
    'assets/images/qaida/page2/b02.mp3': 7,
    'assets/images/qaida/page2/b03.mp3': 8,
    'assets/images/qaida/page2/b04.mp3': 9,
    'assets/images/qaida/page1/taaah.mp3': 10,
    'assets/images/qaida/page2/t01.mp3': 11,
    'assets/images/qaida/page2/t02.mp3': 12,
    'assets/images/qaida/page2/t03.mp3': 13,
    'assets/images/qaida/page2/t04.mp3': 14,
    'assets/images/qaida/page1/saa.mp3': 15,
    'assets/images/qaida/page2/s01.mp3': 16,
    'assets/images/qaida/page2/s02.mp3': 17,
    'assets/images/qaida/page2/s03.mp3': 18,
    'assets/images/qaida/page2/s04.mp3': 19,
  };
  List<String> audioFilePaths = [
    'assets/images/qaida/page1/alif.mp3',
    'assets/images/qaida/page2/a01.mp3',
    'assets/images/qaida/page2/a02.mp3',
    'assets/images/qaida/page2/a03.mp3',
    'assets/images/qaida/page2/a04.mp3',
    'assets/images/qaida/page1/baa1.mp3',
    'assets/images/qaida/page2/b01.mp3',
    'assets/images/qaida/page2/b02.mp3',
    'assets/images/qaida/page2/b03.mp3',
    'assets/images/qaida/page2/b04.mp3',
    'assets/images/qaida/page1/taaah.mp3',
    'assets/images/qaida/page2/t01.mp3',
    'assets/images/qaida/page2/t02.mp3',
    'assets/images/qaida/page2/t03.mp3',
    'assets/images/qaida/page2/t04.mp3',
    'assets/images/qaida/page1/saa.mp3',
    'assets/images/qaida/page2/s01.mp3',
    'assets/images/qaida/page2/s02.mp3',
    'assets/images/qaida/page2/s03.mp3',
    'assets/images/qaida/page2/s04.mp3',
  ];

  void _toggleSelection(int index, String filePath) {
    if (_startIndex != null && _endIndex != null) {
      _selectedContainers.clear();
      _selectedAudioFiles.clear();
      _startIndex = null;
      _endIndex = null;
      AudioListHolder2.audioList.clear();
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
        // print('_selectedAudioFiles: $selectedAudioFiles');
      }

      List<int?> audioIndexes = selectedAudioFiles
          .map((filePath) => audioIndexMap[filePath])
          .toList();

      AudioListHolder2.audioList = selectedAudioFiles;
      AudioListHolder2.audioIndexes = audioIndexes;
      print(audioIndexes);

      widget.isMultipleSelectionEnabled = true;
    }
    setState(() {});
  }

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
            if (currentlyPlayingIndex == index) {
              currentlyPlayingIndex = -1;
            }
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

  void updateCurrentlyPlayingIndex(int index) {
    setState(() {
      currentlyPlayingIndex = index;
    });
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
      AudioListHolder2.audioList.clear();
      widget.isMultipleSelectionEnabled = false;
      widget.updateMultipleSelectionEnabled(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(width: 1),
                                left: BorderSide(width: 1),
                                top: BorderSide(width: 1))),
                        child: const Text(
                          'جدول الحروف الا بجدیۃ',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(width: 1),
                                left: BorderSide(width: 1),
                                top: BorderSide(width: 1))),
                        child: Image.asset(
                          'assets/images/qaida/page2/cont2img.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[2]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 2
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
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
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[2]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(2);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r1c1.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[4]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(4);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r2c1.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[7]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(7);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r3c1.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[9]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(9);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r4c1.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                          top: BorderSide(width: .5),
                                          bottom: BorderSide(width: .5)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    12, audioFilePaths[12]);
                                              }
                                            : () async {
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[12]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(12);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r5c1.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                          top: BorderSide(width: .5),
                                          bottom: BorderSide(width: .8)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    14, audioFilePaths[14]);
                                              }
                                            : () async {
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[14]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(14);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r6c1.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                        top: BorderSide(width: .5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    17, audioFilePaths[17]);
                                              }
                                            : () async {
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[17]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(17);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r7c1.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                          top: BorderSide(width: 1),
                                          bottom: BorderSide(width: 1)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    19, audioFilePaths[19]);
                                              }
                                            : () async {
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[19]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(19);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r8c1.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[1]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 1
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
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
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[1]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(1);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r1c2.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[3]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(3);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r2c2.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[6]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(6);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r3c2.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                          bottom: BorderSide(width: .5)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    8, audioFilePaths[8]);
                                              }
                                            : () async {
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[8]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(8);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r4c2.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                          top: BorderSide(width: .5),
                                          bottom: BorderSide(width: .5)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    11, audioFilePaths[11]);
                                              }
                                            : () async {
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[11]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(11);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r5c2.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                        top: BorderSide(width: .5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    13, audioFilePaths[13]);
                                              }
                                            : () async {
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[13]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(13);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r6c2.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                        top: BorderSide(width: 1),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    16, audioFilePaths[16]);
                                              }
                                            : () async {
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[16]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(16);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r7c2.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                                          top: BorderSide(width: 1),
                                          bottom: BorderSide(width: 1)),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    18, audioFilePaths[18]);
                                              }
                                            : () async {
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[18]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(18);
                                              },
                                        child: Stack(children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/qaida/page2/r8c2.png',
                                              width: 140,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
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
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: containerAudioPlayingStates[0]
                                    ? AppColors.lightBrandingColor
                                    : Colors.transparent,
                                border: const Border(
                                  right: BorderSide(width: 1),
                                  top: BorderSide(width: 1),
                                  bottom: BorderSide(width: 1),
                                ),
                              ),
                              child: InkWell(
                                  onTap: widget.isMultipleSelectionEnabled
                                      ? () {
                                          _toggleSelection(
                                              0, audioFilePaths[0]);
                                        }
                                      : () async {
                                          // await _audioPlayer.stop();
                                          // await _audioPlayer
                                          //     .setAsset(audioFilePaths[0]);
                                          // await _audioPlayer.play();
                                          playSingleAudio(0);
                                        },
                                  child: Stack(children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/images/qaida/page2/aimg.png',
                                        width: 165,
                                        height: 130,
                                        fit: BoxFit.contain,
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
                                  right: BorderSide(width: 1),
                                  left: BorderSide(width: 1),
                                  bottom: BorderSide(width: 1),
                                ),
                              ),
                              child: InkWell(
                                  onTap: widget.isMultipleSelectionEnabled
                                      ? () {
                                          _toggleSelection(
                                              5, audioFilePaths[5]);
                                        }
                                      : () async {
                                          // await _audioPlayer.stop();
                                          // await _audioPlayer
                                          //     .setAsset(audioFilePaths[5]);
                                          // await _audioPlayer.play();
                                          playSingleAudio(5);
                                        },
                                  child: Stack(children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/images/qaida/page2/bimg.png',
                                        width: 165,
                                        height: 130,
                                        fit: BoxFit.contain,
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
                                  right: BorderSide(width: 1),
                                  left: BorderSide(width: 1),
                                  bottom: BorderSide(width: 1),
                                ),
                              ),
                              child: InkWell(
                                  onTap: widget.isMultipleSelectionEnabled
                                      ? () {
                                          _toggleSelection(
                                              10, audioFilePaths[10]);
                                        }
                                      : () async {
                                          // await _audioPlayer.stop();
                                          // await _audioPlayer
                                          //     .setAsset(audioFilePaths[10]);
                                          // await _audioPlayer.play();
                                          playSingleAudio(10);
                                        },
                                  child: Stack(children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/images/qaida/page2/taimg.png',
                                        width: 165,
                                        height: 130,
                                        fit: BoxFit.contain,
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
                                  right: BorderSide(width: 1),
                                  left: BorderSide(width: 1),
                                  bottom: BorderSide(width: 0.5),
                                ),
                              ),
                              child: InkWell(
                                  onTap: widget.isMultipleSelectionEnabled
                                      ? () {
                                          _toggleSelection(
                                              15, audioFilePaths[15]);
                                        }
                                      : () async {
                                          // await _audioPlayer.stop();
                                          // await _audioPlayer
                                          //     .setAsset(audioFilePaths[15]);
                                          // await _audioPlayer.play();
                                          playSingleAudio(15);
                                        },
                                  child: Stack(children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/images/qaida/page2/saimg.png',
                                        width: 165,
                                        height: 130,
                                        fit: BoxFit.contain,
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

class AudioListHolder2 {
  static List<String> audioList = [];
  static List<int?> audioIndexes = [];
  static int pageId = 2;
}
