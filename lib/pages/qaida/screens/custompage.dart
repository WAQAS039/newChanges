import 'package:flutter/material.dart';
//import 'dart:math' as math;

class CustomPageIndicator extends StatefulWidget {
  final int total;
  final PageController controller;

  const CustomPageIndicator({
    super.key,
    required this.total,
    required this.controller,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomPageIndicatorState createState() => _CustomPageIndicatorState();
}

class _CustomPageIndicatorState extends State<CustomPageIndicator> {
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.controller.initialPage;
    widget.controller.addListener(() {
      setState(() {
        _currentPage = widget.controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          '${_currentPage + 1}/${widget.total}',
          style: const TextStyle(
            color: Color.fromARGB(255, 114, 1, 1),
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
// @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50.0,
//       child: Align(
//         alignment: Alignment.topCenter,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             color: const Color.fromARGB(255, 0, 0, 0),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             '${_currentPage + 1}/${widget.total}',
//             style: const TextStyle(
//               color: Color.fromARGB(255, 255, 255, 255),
//               fontSize: 20,
//             ),
//           ),
//         ),
//       ),
//     );
//   }