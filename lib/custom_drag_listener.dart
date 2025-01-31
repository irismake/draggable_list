import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomDragListener extends ReorderableDragStartListener {
  final Duration delay;
  final BuildContext parentContext;
  final bool enableDrag;

  const CustomDragListener({
    this.delay = kLongPressTimeout,
    Key? key,
    required Widget child,
    required int index,
    required this.parentContext,
    required this.enableDrag,
  }) : super(
          key: key,
          child: child,
          index: index,
          enabled: enableDrag,
        );

  @override
  MultiDragGestureRecognizer createRecognizer() {
    FocusScope.of(parentContext).unfocus();

    if (!enableDrag) {
      return ImmediateMultiDragGestureRecognizer(debugOwner: this);
    }

    return DelayedMultiDragGestureRecognizer(delay: delay, debugOwner: this);
  }
}
