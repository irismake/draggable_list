import 'package:flutter/material.dart';
import 'state/list_controller.dart';
import 'draggable_list.dart';

export 'state/list_controller.dart';
export 'style/draggable_list_style.dart';
export 'builder/list_builder.dart';

class DraggableList extends InheritedWidget {
  final ListController controller;
  final bool canWrite;
  final bool enableDrag;
  final Duration duration;

  DraggableList({
    Key? key,
    required List<int> listItems,
    required Widget child,
    required void Function(ListController) initializeController,
    this.canWrite = false,
    this.enableDrag = true,
    this.duration = const Duration(milliseconds: 150),
  })  : controller = ListController(),
        super(key: key, child: child) {
    initializeController(controller);
    controller.initializeListOrder(listItems);
    if (canWrite) {
      controller.initializeListTextControllers();
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static DraggableList? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DraggableList>();
  }
}
