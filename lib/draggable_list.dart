library reorderable_list;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state/draggable_list_style.dart';
import 'state/list_controller.dart';
import 'widgets/custom_list.dart';

class DraggableListView extends StatefulWidget {
  final int listNum;
  final DraggableListStyle style;
  final Duration duration;

  const DraggableListView({
    Key? key,
    required this.listNum,
    this.style = const DraggableListStyle(),
    this.duration = const Duration(milliseconds: 150),
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
      controller.initializeLists(widget.listNum);
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
        itemCount: controller.listTextControllers.length,
        itemBuilder: (context, index) {
          return CustomList(
            key: ValueKey(index),
            textEditingController: controller.listTextControllers[index],
            index: index,
            style: widget.style,
            duration: widget.duration,
          );
        },
        onReorder: (oldIndex, newIndex) {
          controller.reorderList(oldIndex, newIndex);
        },
      ),
    );
  }
}
