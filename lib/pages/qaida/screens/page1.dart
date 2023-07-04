import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nour_al_quran/shared/utills/app_colors.dart';
import 'package:provider/provider.dart';
import '../../settings/pages/app_colors/app_colors_provider.dart';

// ignore: must_be_immutable
class Page1 extends StatefulWidget {
  bool isMultipleSelectionEnabled;
  final Function(bool) updateMultipleSelectionEnabled;

  Page1({
    Key? key,
    required this.isMultipleSelectionEnabled,
    required this.updateMultipleSelectionEnabled,
  }) : super(key: key);

  @override
  Page1State createState() => Page1State();
}

class Page1State extends State<Page1> {
  int? _startIndex;
  int? _endIndex;

  // ignore: prefer_final_fields
  AudioPlayer _audioPlayer = AudioPlayer();
  // OverlayEntry? _overlayEntry;
  // Map<int, GlobalKey> _containerKeys = {};
  // ignore: prefer_final_fields
  List<String> _selectedAudioFiles = [];
  // ignore: prefer_final_fields
  Set<int> _selectedContainers = {};

  List<bool> containerAudioPlayingStates = List.generate(30, (_) => false);
  int currentlyPlayingIndex = -1;

  Map<String, int> audioIndexMap = {
    'assets/images/qaida/page1/alif.mp3': 0,
    'assets/images/qaida/page1/baa1.mp3': 1,
    'assets/images/qaida/page1/taaah.mp3': 2,
    'assets/images/qaida/page1/saa.mp3': 3,
    'assets/images/qaida/page1/geem.mp3': 4,
    'assets/images/qaida/page1/haa.mp3': 5,
    'assets/images/qaida/page1/khaa.mp3': 6,
    'assets/images/qaida/page1/daal.mp3': 7,
    'assets/images/qaida/page1/zaal.mp3': 8,
    'assets/images/qaida/page1/raaa.mp3': 9,
    'assets/images/qaida/page1/zaaa.mp3': 10,
    'assets/images/qaida/page1/seen.mp3': 11,
    'assets/images/qaida/page1/sheen.mp3': 12,
    'assets/images/qaida/page1/suaad.mp3': 13,
    'assets/images/qaida/page1/zaad.mp3': 14,
    'assets/images/qaida/page1/taaaah.mp3': 15,
    'assets/images/qaida/page1/zaaah.mp3': 16,
    'assets/images/qaida/page1/aaen.mp3': 17,
    'assets/images/qaida/page1/gaen.mp3': 18,
    'assets/images/qaida/page1/faa.mp3': 19,
    'assets/images/qaida/page1/qaaf.mp3': 20,
    'assets/images/qaida/page1/kaaf.mp3': 21,
    'assets/images/qaida/page1/laam.mp3': 22,
    'assets/images/qaida/page1/meem.mp3': 23,
    'assets/images/qaida/page1/noon.mp3': 24,
    'assets/images/qaida/page1/wahoo.mp3': 25,
    'assets/images/qaida/page1/haah.mp3': 26,
    'assets/images/qaida/page1/hamza.mp3': 27,
    'assets/images/qaida/page1/yaa.mp3': 28,
    'assets/images/qaida/page1/yaah.mp3': 29,
  };

  List<String> audioFilePaths = [
    'assets/images/qaida/page1/alif.mp3',
    'assets/images/qaida/page1/baa1.mp3',
    'assets/images/qaida/page1/taaah.mp3',
    'assets/images/qaida/page1/saa.mp3',
    'assets/images/qaida/page1/geem.mp3',
    'assets/images/qaida/page1/haa.mp3',
    'assets/images/qaida/page1/khaa.mp3',
    'assets/images/qaida/page1/daal.mp3',
    'assets/images/qaida/page1/zaal.mp3',
    'assets/images/qaida/page1/raaa.mp3',
    'assets/images/qaida/page1/zaaa.mp3',
    'assets/images/qaida/page1/seen.mp3',
    'assets/images/qaida/page1/sheen.mp3',
    'assets/images/qaida/page1/suaad.mp3',
    'assets/images/qaida/page1/zaad.mp3',
    'assets/images/qaida/page1/taaah.mp3',
    'assets/images/qaida/page1/zaaah.mp3',
    'assets/images/qaida/page1/aaen.mp3',
    'assets/images/qaida/page1/gaen.mp3',
    'assets/images/qaida/page1/faa.mp3',
    'assets/images/qaida/page1/qaaf.mp3',
    'assets/images/qaida/page1/kaaf.mp3',
    'assets/images/qaida/page1/laam.mp3',
    'assets/images/qaida/page1/meem.mp3',
    'assets/images/qaida/page1/noon.mp3',
    'assets/images/qaida/page1/wahoo.mp3',
    'assets/images/qaida/page1/haah.mp3',
    'assets/images/qaida/page1/hamza.mp3',
    'assets/images/qaida/page1/yaa.mp3',
    'assets/images/qaida/page1/yaah.mp3',
  ];

  void _toggleSelection(int index, String filePath) {
    if (_startIndex != null && _endIndex != null) {
      _selectedContainers.clear();
      _selectedAudioFiles.clear();
      _startIndex = null;
      _endIndex = null;
      AudioListHolder1.audioList.clear();
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

      if (start > end) {
        int temp = start;
        start = end;
        end = temp;
      }

      for (int i = start; i <= end; i++) {
        _selectedContainers.add(i);
      }
      _endIndex = index;

      List<String> selectedAudioFiles = [];
      for (int i = start; i <= end; i++) {
        selectedAudioFiles.add(audioFilePaths[i]);
        //print('_selectedAudioFiles: $selectedAudioFiles');
      }

      List<int?> audioIndexes = selectedAudioFiles
          .map((filePath) => audioIndexMap[filePath])
          .toList();
      print('Audio Indexes: $audioIndexes');

      AudioListHolder1.audioList = selectedAudioFiles;
      AudioListHolder1.audioIndexes = audioIndexes;

      widget.isMultipleSelectionEnabled = true;
    }
    setState(() {});
  }

  void clearSelection() {
    setState(() {
      _selectedContainers.clear();
      _selectedAudioFiles.clear();
      _startIndex = null;
      _endIndex = null;
      AudioListHolder1.audioList.clear();
      widget.isMultipleSelectionEnabled = false;
      widget.updateMultipleSelectionEnabled(false);
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

  // void _showOverlay(String imagePath, RenderBox containerRenderBox) {
  //   setState(() {
  //     if (_overlayEntry != null) {
  //       _overlayEntry!.remove();
  //       _overlayEntry = null;
  //     }
  //     _overlayEntry = OverlayEntry(
  //       builder: (BuildContext context) {
  //         final Size containerSize = containerRenderBox.size;
  //         final Offset containerPosition =
  //             containerRenderBox.localToGlobal(Offset.zero);
  //         return Positioned(
  //           left: containerPosition.dx - (containerSize.width * 0.10),
  //           top: containerPosition.dy - (containerSize.height * 0.10),
  //           child: GestureDetector(
  //             onTap: () {
  //               setState(() {
  //                 _overlayEntry!.remove();
  //                 _overlayEntry = null;
  //               });
  //             },
  //             child: Stack(
  //               children: [
  //                 Container(
  //                   width: containerSize.width * 1.15,
  //                   height: containerSize.height * 1.05,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(8.0),
  //                     boxShadow: const [
  //                       BoxShadow(
  //                         color: Colors.black54,
  //                         offset: Offset(0, 2),
  //                         blurRadius: 4.0,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   width: containerSize.width * 1.10,
  //                   height: containerSize.height * 1.00,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(8.0),
  //                     color: const Color.fromARGB(255, 255, 241, 232),
  //                   ),
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(8.0),
  //                     child: Center(
  //                       child: Image.asset(
  //                         imagePath,
  //                         width: containerSize.width,
  //                         height: containerSize.height,
  //                         fit: BoxFit.contain,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //     Overlay.of(context).insert(_overlayEntry!);
  //   });
  // }

  // void _hideOverlay() {
  //   _overlayEntry?.remove();
  //   _overlayEntry = null;
  // }

  // GlobalKey<State<StatefulWidget>>? _getContainerKey(int index) {
  //   if (!_containerKeys.containsKey(index)) {
  //     _containerKeys[index] = GlobalKey();
  //   }
  //   return _containerKeys[index];
  // }

  @override
  Widget build(BuildContext context) {
    // var appColors = context.read<AppColorsProvider>();
    // var isDark = context.read<ThemProvider>().isDark;
    // AudioPlayerManager _audioPlayerManager = AudioPlayerManager();
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
                        child: Center(
                          child: Image.asset(
                            'assets/images/qaida/page1/bis.png',
                            width: 300,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
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
                      child: Consumer<AppColorsProvider>(
                        builder: (context, value, child) => Container(
                          decoration: BoxDecoration(
                              color: value.mainBrandingColor,
                              border: const Border(
                                right: BorderSide(width: 1),
                                left: BorderSide(width: 1),
                                top: BorderSide(width: 1),
                                bottom: BorderSide(width: 1),
                              )),
                          child: const Text(
                            ' حروف الهجاء المفردة',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                letterSpacing: 1.5),
                            textAlign: TextAlign.center,
                          ),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: containerAudioPlayingStates[4]
                                        ? AppColors.lightBrandingColor
                                        : (currentlyPlayingIndex == 4
                                            ? AppColors.lightBrandingColor
                                            : Colors.transparent),
                                    border: const Border(
                                      left: BorderSide(width: 1),
                                      right: BorderSide(width: .1),
                                      top: BorderSide(width: 0.5),
                                      bottom: BorderSide(width: 0.5),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: widget.isMultipleSelectionEnabled
                                        ? () {
                                            _toggleSelection(
                                                4, audioFilePaths[4]);
                                          }
                                        : () async {
                                            // // String img =
                                            // //     'assets/images/qaida/page1/jem1.png';
                                            // // RenderBox containerRenderBox =
                                            // //     _getContainerKey(4)
                                            // //             ?.currentContext!
                                            // //             .findRenderObject()
                                            // //         as RenderBox;
                                            // // await _audioPlayer.stop();
                                            // // _hideOverlay();
                                            // // _showOverlay(
                                            // //     img, containerRenderBox);
                                            // await _audioPlayer.stop();
                                            // await _audioPlayer
                                            //     .setAsset(audioFilePaths[4]);
                                            // // _audioPlayerManager.playAudio(4);
                                            // await _audioPlayer.play();
                                            // // _hideOverlay();
                                            // setState(() {
                                            //   isAudioPlaying = true;
                                            // });

                                            // if (isAudioPlaying) {
                                            //   await _audioPlayer.stop();
                                            //   setState(() {
                                            //     isAudioPlaying = false;
                                            //   });
                                            // } else {
                                            //   await _audioPlayer
                                            //       .setAsset(audioFilePaths[4]);
                                            //   await _audioPlayer.play();
                                            //   setState(() {
                                            //     isAudioPlaying = true;
                                            //   });
                                            // }
                                            playSingleAudio(4);
                                          },
                                    child: Stack(
                                      children: [
                                        FractionallySizedBox(
                                          widthFactor: 1.0,
                                          heightFactor: 1,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: AspectRatio(
                                              aspectRatio: 1.1,
                                              child: Image.asset(
                                                'assets/images/qaida/page1/jeemp1.png',
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    //   key: _getContainerKey(9),
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[9]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 9
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    9, audioFilePaths[9]);
                                              }
                                            : () async {
                                                // // String img =
                                                // //     'assets/images/qaida/page1/raa1.png';
                                                // // RenderBox containerRenderBox =
                                                // //     _getContainerKey(9)
                                                // //             ?.currentContext!
                                                // //             .findRenderObject()
                                                // //         as RenderBox;
                                                // await _audioPlayer.stop();
                                                // // _hideOverlay();
                                                // // _showOverlay(
                                                // //     img, containerRenderBox);
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[9]);
                                                // await _audioPlayer.play();
                                                // //    _hideOverlay();
                                                playSingleAudio(9);
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
                                                  'assets/images/qaida/page1/raap1.png',
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
                                    //     key: _getContainerKey(14),
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[14]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 14
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    14, audioFilePaths[14]);
                                              }
                                            : () async {
                                                // // String img =
                                                // //     'assets/images/qaida/page1/zoa1.png';
                                                // // RenderBox containerRenderBox =
                                                // //     _getContainerKey(14)
                                                // //             ?.currentContext!
                                                // //             .findRenderObject()
                                                // //         as RenderBox;
                                                // await _audioPlayer.stop();
                                                // // _hideOverlay();
                                                // // _showOverlay(
                                                // //     img, containerRenderBox);
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[14]);
                                                // await _audioPlayer.play();
                                                // //       _hideOverlay();
                                                playSingleAudio(14);
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
                                                  'assets/images/qaida/page1/zoadp1.png',
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
                                    //      key: _getContainerKey(19),
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[19]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 19
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    19, audioFilePaths[19]);
                                              }
                                            : () async {
                                                // // String img =
                                                // //     'assets/images/qaida/page1/fa1.png';
                                                // // RenderBox containerRenderBox =
                                                // //     _getContainerKey(19)
                                                // //             ?.currentContext!
                                                // //             .findRenderObject()
                                                // //         as RenderBox;
                                                // await _audioPlayer.stop();
                                                // // _hideOverlay();
                                                // // _showOverlay(
                                                // //     img, containerRenderBox);
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[19]);
                                                // await _audioPlayer.play();
                                                // //    _hideOverlay();
                                                playSingleAudio(19);
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
                                                  'assets/images/qaida/page1/faap1.png',
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
                              Expanded(
                                child: Container(
                                    //     key: _getContainerKey(24),
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[24]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 24
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    24, audioFilePaths[24]);
                                              }
                                            : () async {
                                                // // String img =
                                                // //     'assets/images/qaida/page1/non1.png';
                                                // // RenderBox containerRenderBox =
                                                // //     _getContainerKey(24)
                                                // //             ?.currentContext!
                                                // //             .findRenderObject()
                                                // //         as RenderBox;
                                                // await _audioPlayer.stop();
                                                // // _hideOverlay();
                                                // // _showOverlay(
                                                // //     img, containerRenderBox);
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[24]);
                                                // await _audioPlayer.play();
                                                // //      _hideOverlay();
                                                playSingleAudio(24);
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
                                                  'assets/images/qaida/page1/noonp1.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(24))
                                            if (_startIndex == 24)
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
                                            else if (_endIndex == 24)
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
                                    //           key: _getContainerKey(29),
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[29]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 29
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 1),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    29, audioFilePaths[29]);
                                              }
                                            : () async {
                                                // // String img =
                                                // //     'assets/images/qaida/page1/ya1.png';
                                                // // RenderBox containerRenderBox =
                                                // //     _getContainerKey(29)
                                                // //             ?.currentContext!
                                                // //             .findRenderObject()
                                                // //         as RenderBox;
                                                // await _audioPlayer.stop();
                                                // // _hideOverlay();
                                                // // _showOverlay(
                                                // //     img, containerRenderBox);
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[29]);
                                                // await _audioPlayer.play();
                                                // //       _hideOverlay();
                                                playSingleAudio(29);
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
                                                  'assets/images/qaida/page1/yap1.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(29))
                                            if (_startIndex == 29)
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
                                            else if (_endIndex == 29)
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
                                      color: containerAudioPlayingStates[3]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 3
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: .5),
                                        top: BorderSide(width: 0.5),
                                        right: BorderSide(width: .5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: widget.isMultipleSelectionEnabled
                                          ? () {
                                              _toggleSelection(
                                                  3, audioFilePaths[3]);
                                            }
                                          : () async {
                                              // // String img =
                                              // //     'assets/images/qaida/page1/sa1.png';
                                              // // RenderBox containerRenderBox =
                                              // //     _getContainerKey(3)
                                              // //             ?.currentContext!
                                              // //             .findRenderObject()
                                              // //         as RenderBox;
                                              // await _audioPlayer.stop();
                                              // // _hideOverlay();
                                              // // _showOverlay(
                                              // //     img, containerRenderBox);
                                              // await _audioPlayer.stop();
                                              // await _audioPlayer
                                              //     .setAsset(audioFilePaths[3]);
                                              // await _audioPlayer.play();
                                              // //      _hideOverlay();
                                              playSingleAudio(3);
                                            },
                                      child: Stack(
                                        children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 1.1,
                                                child: Image.asset(
                                                  'assets/images/qaida/page1/saap1.png',
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
                                        ],
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[8]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 8
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        right: BorderSide(width: .5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
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
                                                aspectRatio: 1.1,
                                                child: Image.asset(
                                                  'assets/images/qaida/page1/zaalp1.png',
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
                                      color: containerAudioPlayingStates[13]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 13
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        right: BorderSide(width: .5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
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
                                                aspectRatio: 1.1,
                                                child: Image.asset(
                                                  'assets/images/qaida/page1/saadp1.png',
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
                                      color: containerAudioPlayingStates[18]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 18
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        right: BorderSide(width: .5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
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
                                                aspectRatio: 1.1,
                                                child: Image.asset(
                                                  'assets/images/qaida/page1/gaeenp1.png',
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
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[23]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 23
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        right: BorderSide(width: .5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    23, audioFilePaths[23]);
                                              }
                                            : () async {
                                                playSingleAudio(23);
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
                                                  'assets/images/qaida/page1/meemp1.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(23))
                                            if (_startIndex == 23)
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
                                            else if (_endIndex == 23)
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
                                      color: containerAudioPlayingStates[28]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 28
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        right: BorderSide(width: .5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    28, audioFilePaths[28]);
                                              }
                                            : () async {
                                                playSingleAudio(28);
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
                                                  'assets/images/qaida/page1/yaap1.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(28))
                                            if (_startIndex == 28)
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
                                            else if (_endIndex == 28)
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
                                      color: containerAudioPlayingStates[2]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 2
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        top: BorderSide(width: 0.5),
                                        right: BorderSide(width: .5),
                                        bottom: BorderSide(width: 0.5),
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
                                      child: Stack(
                                        children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 1.1,
                                                child: Image.asset(
                                                  'assets/images/qaida/page1/taap1.png',
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
                                        ],
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[7]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 7
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
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
                                                aspectRatio: 1.1,
                                                child: Image.asset(
                                                  'assets/images/qaida/page1/daalp1.png',
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
                                      color: containerAudioPlayingStates[12]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 12
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
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
                                                aspectRatio: 1.1,
                                                child: Image.asset(
                                                  'assets/images/qaida/page1/sheenp1.png',
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
                                      color: containerAudioPlayingStates[17]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 17
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
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
                                                aspectRatio: 1.1,
                                                child: Image.asset(
                                                  'assets/images/qaida/page1/aeenp1.png',
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
                                      color: containerAudioPlayingStates[22]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 22
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    22, audioFilePaths[22]);
                                              }
                                            : () async {
                                                playSingleAudio(22);
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
                                                  'assets/images/qaida/page1/laamp1.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(22))
                                            if (_startIndex == 22)
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
                                            else if (_endIndex == 22)
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
                                      color: containerAudioPlayingStates[27]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 27
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    27, audioFilePaths[27]);
                                              }
                                            : () async {
                                                playSingleAudio(27);
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
                                                  'assets/images/qaida/page1/hamzap1.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(27))
                                            if (_startIndex == 27)
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
                                            else if (_endIndex == 27)
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
                                          : (currentlyPlayingIndex == 1
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: .1),
                                        top: BorderSide(width: 0.5),
                                        //  right: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
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
                                      child: Stack(
                                        children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 1.1,
                                                child: Image.asset(
                                                  'assets/images/qaida/page1/bap1.png',
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
                                        ],
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[6]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 6
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: .5),
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
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
                                                aspectRatio: 1.1,
                                                child: Image.asset(
                                                  'assets/images/qaida/page1/khap1.png',
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
                                      color: containerAudioPlayingStates[11]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 11
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: .5),
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
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
                                                aspectRatio: 1.1,
                                                child: Image.asset(
                                                  'assets/images/qaida/page1/seenp1.png',
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
                                      color: containerAudioPlayingStates[16]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 16
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: .5),
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
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
                                                aspectRatio: 1.1,
                                                child: Image.asset(
                                                  'assets/images/qaida/page1/zoap1.png',
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
                                      color: containerAudioPlayingStates[21]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 21
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: .5),
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    21, audioFilePaths[21]);
                                              }
                                            : () async {
                                                playSingleAudio(21);
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
                                                  'assets/images/qaida/page1/qaafp1.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(21))
                                            if (_startIndex == 21)
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
                                            else if (_endIndex == 21)
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
                                      color: containerAudioPlayingStates[26]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 26
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: .5),
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    26, audioFilePaths[26]);
                                              }
                                            : () async {
                                                playSingleAudio(26);
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
                                                  'assets/images/qaida/page1/haap1.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(26))
                                            if (_startIndex == 26)
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
                                            else if (_endIndex == 26)
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
                                      color: containerAudioPlayingStates[0]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 0
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        right: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkResponse(
                                      onTap: widget.isMultipleSelectionEnabled
                                          ? () {
                                              _toggleSelection(
                                                  0, audioFilePaths[0]);
                                            }
                                          : () async {
                                              playSingleAudio(0);
                                            },
                                      child: Stack(
                                        children: [
                                          FractionallySizedBox(
                                            widthFactor: 1.0,
                                            heightFactor: 1,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AspectRatio(
                                                aspectRatio: 1.1,
                                                child: Image.asset(
                                                  'assets/images/qaida/page1/alifp1.png',
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
                                        ],
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[5]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 5
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        right: BorderSide(width: 1),
                                        bottom: BorderSide(width: 0.5),
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
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[5]);
                                                // await _audioPlayer.play();
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
                                                  'assets/images/qaida/page1/hap1.png',
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
                                          : (currentlyPlayingIndex == 10
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        right: BorderSide(width: 1),
                                        bottom: BorderSide(width: 0.5),
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
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[10]);
                                                // await _audioPlayer.play();
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
                                                  'assets/images/qaida/page1/zap1.png',
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
                                          : (currentlyPlayingIndex == 15
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        right: BorderSide(width: 1),
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
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[15]);
                                                // await _audioPlayer.play();
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
                                                  'assets/images/qaida/page1/tap1.png',
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
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: containerAudioPlayingStates[20]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 20
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        right: BorderSide(width: 1),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    20, audioFilePaths[20]);
                                              }
                                            : () async {
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[20]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(20);
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
                                                  'assets/images/qaida/page1/qafp1.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(20))
                                            if (_startIndex == 20)
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
                                            else if (_endIndex == 20)
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
                                      color: containerAudioPlayingStates[25]
                                          ? AppColors.lightBrandingColor
                                          : (currentlyPlayingIndex == 25
                                              ? AppColors.lightBrandingColor
                                              : Colors.transparent),
                                      border: const Border(
                                        left: BorderSide(width: 1),
                                        top: BorderSide(width: 0.5),
                                        right: BorderSide(width: 1),
                                        bottom: BorderSide(width: 0.5),
                                      ),
                                    ),
                                    child: InkWell(
                                        onTap: widget.isMultipleSelectionEnabled
                                            ? () {
                                                _toggleSelection(
                                                    25, audioFilePaths[25]);
                                              }
                                            : () async {
                                                // await _audioPlayer.stop();
                                                // await _audioPlayer.setAsset(
                                                //     audioFilePaths[25]);
                                                // await _audioPlayer.play();
                                                playSingleAudio(25);
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
                                                  'assets/images/qaida/page1/wowp1.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_selectedContainers.contains(25))
                                            if (_startIndex == 25)
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
                                            else if (_endIndex == 25)
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
          ],
        ),
      ),
    );
  }
}

class AudioListHolder1 {
  static List<String> audioList = [];
  static List<int?> audioIndexes = [];
  static int pageId = 1;
}

class AudioPlayerManager {
  AudioPlayer _audioPlayer = AudioPlayer();
  List<String> audioFilePaths = [
    'assets/images/qaida/page1/alif.mp3',
    'assets/images/qaida/page1/baa1.mp3',
    'assets/images/qaida/page1/taaah.mp3',
    'assets/images/qaida/page1/saa.mp3',
    'assets/images/qaida/page1/geem.mp3',
    'assets/images/qaida/page1/haa.mp3',
    'assets/images/qaida/page1/khaa.mp3',
    'assets/images/qaida/page1/daal.mp3',
    'assets/images/qaida/page1/zaal.mp3',
    'assets/images/qaida/page1/raaa.mp3',
    'assets/images/qaida/page1/zaaa.mp3',
    'assets/images/qaida/page1/seen.mp3',
    'assets/images/qaida/page1/sheen.mp3',
    'assets/images/qaida/page1/suaad.mp3',
    'assets/images/qaida/page1/zaad.mp3',
    'assets/images/qaida/page1/taaah.mp3',
    'assets/images/qaida/page1/zaaah.mp3',
    'assets/images/qaida/page1/aaen.mp3',
    'assets/images/qaida/page1/gaen.mp3',
    'assets/images/qaida/page1/faa.mp3',
    'assets/images/qaida/page1/qaaf.mp3',
    'assets/images/qaida/page1/kaaf.mp3',
    'assets/images/qaida/page1/laam.mp3',
    'assets/images/qaida/page1/meem.mp3',
    'assets/images/qaida/page1/noon.mp3',
    'assets/images/qaida/page1/wahoo.mp3',
    'assets/images/qaida/page1/haah.mp3',
    'assets/images/qaida/page1/hamza.mp3',
    'assets/images/qaida/page1/yaa.mp3',
    'assets/images/qaida/page1/yaah.mp3',
    // Add more audio file paths
  ];

  Future<void> playAudio(int index) async {
    if (index < 0 || index >= audioFilePaths.length) {
      // Handle invalid index
      return;
    }

    final filePath = audioFilePaths[index];

    if (_audioPlayer != null) {
      await _audioPlayer.stop();
      await _audioPlayer.dispose();
    }

    _audioPlayer = AudioPlayer();
    await _audioPlayer.setAsset(filePath);
    await _audioPlayer.play();
  }

  Future<void> stopAudio() async {
    if (_audioPlayer != null) {
      await _audioPlayer.stop();
      await _audioPlayer.dispose();
    }
  }
}



//-> TESTS CLEARED
//-> ~ Single AudioPlay working
//-> ~ Multiple Select working tested Scenarios:
//-> ~ When the single letter is selected and I press on play button
//->     It wont play untill the range is selected.
//-> ~ Audio is cleared when the range is cleared.
//-> ~ when range is cleared _isMultipleSelectionEnabled is set to false.
//-> ~ AudioPlay is much faster now!!!


//->  TODO TESTS
//->  ~When I SWIPE TO NEXT PAGE THE RANGE SHOULD BE CLEARED AND THE
//->  VALUE OF isMultipleSelectionEnabled should be set to false and
//->  should be updated back in SwipePages.