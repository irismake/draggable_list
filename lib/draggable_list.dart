import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state/list_controller.dart';
import 'widgets/custom_list.dart';

import 'state/draggable_list_style.dart';
export 'state/list_controller.dart';
export 'state/draggable_list_style.dart';
export 'widgets/custom_list.dart';

class DraggableListView extends StatefulWidget {
  final int listNum;
  final Duration duration;

  final DraggableListStyle style;

  final Widget? Function(BuildContext, int)? customListBuilder;
  final ValueChanged<List<String>> listValue;

  const DraggableListView({
    Key? key,
    required this.listNum,
    this.duration = const Duration(milliseconds: 150),
    this.customListBuilder,
    this.style = const DraggableListStyle(),
    required this.listValue,
  }) : super(key: key);

  @override
  _DraggableListViewState createState() => _DraggableListViewState();
}

class _DraggableListViewState extends State<DraggableListView> {
  final ListController controller = Get.put(ListController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initializeListOrder(widget.listNum);
      if (widget.customListBuilder == null) {
        controller.initializeListTextControllers(widget.listNum);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReorderableListView.builder(
        proxyDecorator: (child, index, animation) {
          return Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: animation.drive(
                Tween<double>(
                        begin: widget.style.animateBeginScale,
                        end: widget.style.animateEndScale)
                    .chain(
                  CurveTween(curve: Curves.linear),
                ),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: child,
              ),
            ),
          );
        },
        buildDefaultDragHandles: true,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.listOrder.length,
        itemBuilder: (context, index) {
          return widget.customListBuilder?.call(context, index) ??
              CustomList(
                key: ValueKey(index),
                textEditingController: controller.listTextControllers[index],
                index: index,
                style: widget.style,
                duration: widget.duration,
              );
        },
        onReorder: (oldIndex, newIndex) {
          controller.reorderList(oldIndex, newIndex);
          if (widget.customListBuilder == null) {
            controller.reorderListTextController(oldIndex, newIndex);
          }
          widget.listValue(controller.listOrder);
        },
      ),
    );
  }
}
