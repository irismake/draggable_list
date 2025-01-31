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
  final bool canWrite;
  final bool enableDrag;
  final DraggableListStyle style;
  final Widget? Function(BuildContext, int)? customListBuilder;
  final ValueChanged<List<String>> listValue;

  const DraggableListView({
    Key? key,
    required this.listNum,
    this.duration = const Duration(milliseconds: 150),
    this.canWrite = false,
    this.enableDrag = true,
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
      if (widget.canWrite) {
        controller.initializeListTextControllers(widget.listNum);
      }
    });
  }

  Widget _buildListWidget(BuildContext context, int index) {
    return widget.canWrite
        ? CustomList(
            enableDrag: widget.enableDrag,
            key: ValueKey(index),
            textEditingController: controller.listTextControllers[index],
            index: index,
            style: widget.style,
            duration: widget.duration,
          )
        : widget.customListBuilder?.call(context, index) ??
            _defaultListWidget(index);
  }

  Widget _defaultListWidget(int index) {
    return Padding(
      key: ValueKey(index),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 10,
        color: const Color(0xff5D3FD3),
        child: const Center(
          child: Text('example'),
        ),
      ),
    );
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
          buildDefaultDragHandles: widget.enableDrag,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.listOrder.length,
          itemBuilder: (context, index) {
            return _buildListWidget(context, index);
          },
          onReorder: (oldIndex, newIndex) {
            controller.reorderList(oldIndex, newIndex);
            if (widget.canWrite) {
              controller.reorderListTextController(oldIndex, newIndex);
            }
            widget.listValue(controller.listOrder);
          }),
    );
  }
}
