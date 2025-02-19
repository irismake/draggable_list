import 'package:flutter/material.dart';
import 'draggable_list.dart';

export 'state/list_controller.dart';
export 'model/list_style.dart';
export 'builder/list_builder.dart';
export 'model/list_model.dart';

class DraggableList extends InheritedWidget {
  final ListController controller;
  final bool canWrite;
  final bool enableDrag;
  final Duration duration;

  DraggableList({
    Key? key,
    List<ListModel> initListValues = const [],
    required Widget child,
    required void Function(ListController) initializeController,
    this.canWrite = false,
    this.enableDrag = true,
    this.duration = const Duration(milliseconds: 150),
  })  : controller = ListController(),
        super(
            key: key,
            child: Listener(
              onPointerDown: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: child,
              ),
            )) {
    initializeController(controller);
    controller.saveWriteState = canWrite;
    controller.initializeListOrder(initListValues);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static DraggableList? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DraggableList>();
  }
}
