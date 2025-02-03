import 'package:flutter/material.dart';

import '../draggable_list.dart';
import 'text_list_builder.dart';

class ListBuilder extends StatefulWidget {
  final DraggableListStyle style;
  final Widget? Function(BuildContext, int)? customListBuilder;

  const ListBuilder({
    Key? key,
    this.customListBuilder,
    this.style = const DraggableListStyle(),
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
        ? TextListBuilder(
            enableDrag: enableDrag,
            key: ValueKey(controller.listOrder.value[index]),
            textEditingController: controller.listTextControllers.value[index],
            index: index,
            style: widget.style,
            duration: duration,
          )
        : widget.customListBuilder
                ?.call(context, controller.listOrder.value[index]) ??
            _defaultListWidget(index);
  }

  Widget _defaultListWidget(int index) {
    return Padding(
      key: ValueKey(controller.listOrder.value[index]),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 10,
        color: const Color(0xff5D3FD3),
        child: Center(
          child: Text(controller.listOrder.value[index].toString()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<int>>(
      valueListenable: controller.listOrder,
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
          itemCount: controller.listOrder.value.length,
          itemBuilder: (context, index) {
            return _buildListWidget(context, index);
          },
          onReorder: (oldIndex, newIndex) {
            controller.reorderList(
                oldIndex: oldIndex, newIndex: newIndex, canWrite: canWrite);
          },
        );
      },
    );
  }
}
