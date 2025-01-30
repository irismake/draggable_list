import 'package:flutter/material.dart';

class DraggableListStyle {
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final TextStyle contentTextStyle;
  final TextStyle hintTextStyle;
  final TextStyle orderTextStyle;
  final String hintText;
  final EdgeInsets listPadding;
  final EdgeInsets textPadding;
  final EdgeInsets orderPadding;

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
    this.orderTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w700,
    ),
    this.hintText = '내용을 입력해주세요',
    this.listPadding = const EdgeInsets.symmetric(vertical: 2.0),
    this.textPadding =
        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
    this.orderPadding = const EdgeInsets.all(16.0),
  });
}
