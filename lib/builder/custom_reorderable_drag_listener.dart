import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomReorderableDragListener extends ReorderableDragStartListener {
  final Duration delay;
  final bool enableDrag;

  const CustomReorderableDragListener({
    this.delay = kLongPressTimeout,
    Key? key,
    required Widget child,
    required int index,
    required this.enableDrag,
  }) : super(
          key: key,
          child: child,
          index: index,
          enabled: enableDrag,
        );

  @override
  MultiDragGestureRecognizer createRecognizer() {
    if (!enableDrag) {
      return ImmediateMultiDragGestureRecognizer(debugOwner: this);
    }

    return DelayedMultiDragGestureRecognizer(delay: delay, debugOwner: this);
  }
}
