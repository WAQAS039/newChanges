import 'dart:ui';

class Dimensions{
  static final screenSize = window.physicalSize / window.devicePixelRatio;
  static final height = screenSize.height;
  static final width = screenSize.width;
}