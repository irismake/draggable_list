import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomDragListener extends ReorderableDragStartListener {
  final Duration delay;
  final BuildContext parentContext;

  const CustomDragListener({
    this.delay = kLongPressTimeout,
    Key? key,
    required Widget child,
    required int index,
    required this.parentContext,
    bool enabled = true,
  }) : super(
          key: key,
          child: child,
          index: index,
          enabled: enabled,
        );

  @override
  MultiDragGestureRecognizer createRecognizer() {
    FocusScope.of(parentContext).unfocus();
    return DelayedMultiDragGestureRecognizer(delay: delay, debugOwner: this);
  }
}
