library reorderable_list;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state/list_controller.dart';
import 'widgets/custom_list.dart';

class DraggableListView extends StatefulWidget {
  final int listNum;

  const DraggableListView({
    Key? key,
    required this.listNum,
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
        itemCount: controller.listTextControllers.length,
        itemBuilder: (context, index) {
          return CustomList(
            key: ValueKey(index),
            textEditingController: controller.listTextControllers[index],
            index: index,
          );
        },
        onReorder: (oldIndex, newIndex) {
          controller.reorderList(oldIndex, newIndex);
        },
      ),
    );
  }
}
