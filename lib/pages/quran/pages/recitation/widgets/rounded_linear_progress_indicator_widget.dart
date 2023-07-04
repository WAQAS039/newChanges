import 'package:flutter/material.dart';

class RoundedLinearProgressIndicator extends StatelessWidget {
  final double value;
  final double borderRadius;
  final bool isRight;

  const RoundedLinearProgressIndicator({
    Key? key,
    required this.value,
    this.borderRadius = 2.5,
    this.isRight = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: isRight ? Radius.zero : Radius.circular(borderRadius),
            topRight: isRight ? Radius.circular(borderRadius) : Radius.zero,
            bottomLeft: isRight ? Radius.zero : Radius.circular(borderRadius),
            bottomRight: isRight ? Radius.circular(borderRadius) : Radius.zero,
          ),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.transparent,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        );
      },
    );
  }
}
