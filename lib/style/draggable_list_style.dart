import 'package:flutter/material.dart';

class DraggableListStyle {
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final TextStyle contentTextStyle;
  final TextStyle hintTextStyle;

  final String hintText;
  final EdgeInsets listPadding;
  final EdgeInsets textPadding;

  final double animateBeginScale;
  final double animateEndScale;

  const DraggableListStyle({
    this.backgroundColor = Colors.white,
    this.borderRadius,
    this.border,
    this.contentTextStyle = const TextStyle(
      decorationThickness: 0,
      color: Color(0xff495057),
      fontSize: 14,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w500,
      height: 1.43,
    ),
    this.hintTextStyle = const TextStyle(
      color: Color(0xffADB5BD),
      fontSize: 14,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w500,
      height: 1.43,
    ),
    this.hintText = '내용을 입력해주세요',
    this.listPadding = const EdgeInsets.symmetric(vertical: 2.0),
    this.textPadding =
        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
    this.animateBeginScale = 1.0,
    this.animateEndScale = 1.1,
  });
}
