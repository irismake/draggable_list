import 'package:flutter/material.dart';

Widget defaultListWidget({required ValueKey key, required String content}) {
  return Padding(
    key: key,
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 100,
      width: 10,
      color: const Color(0xff5D3FD3),
      child: Center(
        child: Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
