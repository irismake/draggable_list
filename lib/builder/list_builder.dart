import 'package:draggable_list/builder/custom_reorderable_drag_listener.dart';
import 'package:draggable_list/widget/defalut_list_widget.dart';
import 'package:flutter/material.dart';

import '../draggable_list.dart';
import '../widget/text_list_widget.dart';

class ListBuilder extends StatefulWidget {
  final ListStyle style;
  final Widget? Function(BuildContext, int)? customListBuilder;

  const ListBuilder({
    Key? key,
    this.customListBuilder,
    this.style = const ListStyle(),
  }) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListBuilder> {
  late ListController controller;
  late bool canWrite;
  late bool enableDrag;
  late Duration duration;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final draggableList = DraggableList.of(context);
    controller = draggableList?.controller ?? ListController();
    canWrite = draggableList?.canWrite ?? false;
    enableDrag = draggableList?.enableDrag ?? true;
    duration = draggableList?.duration ?? const Duration(milliseconds: 150);
  }

  Widget _buildListWidget(BuildContext context, int index) {
    return canWrite
        ? TextListWidget(
            enableDrag: enableDrag,
            key: ValueKey(controller.draggableLists.value[index].listOrder),
            textEditingController: controller.listTextControllers.value[index],
            index: index,
            style: widget.style,
          )
        : widget.customListBuilder?.call(
                context, controller.draggableLists.value[index].listOrder) ??
            defaultListWidget(
                key: ValueKey(controller.draggableLists.value[index].listOrder),
                content: controller.draggableLists.value[index].listOrder
                    .toString());
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ListModel>>(
      valueListenable: controller.draggableLists,
      builder: (context, listOrder, child) {
        return ReorderableListView.builder(
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
          buildDefaultDragHandles: enableDrag,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.draggableLists.value.length,
          itemBuilder: (context, index) {
            return CustomReorderableDragListener(
              enableDrag: enableDrag,
              key: ValueKey(
                controller.draggableLists.value[index].listOrder,
              ),
              delay: duration,
              index: index,
              child: _buildListWidget(context, index),
            );
          },
          onReorder: (oldIndex, newIndex) {
            controller.reorderList(oldIndex: oldIndex, newIndex: newIndex);
          },
        );
      },
    );
  }
}
