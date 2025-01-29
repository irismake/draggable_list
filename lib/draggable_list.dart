library reorderable_list;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state/item_controller.dart';
import 'widgets/custom_item.dart';

class DraggableListView extends StatefulWidget {
  final int itemNum;

  const DraggableListView({
    Key? key,
    required this.itemNum,
  }) : super(key: key);

  @override
  _DraggableListViewState createState() => _DraggableListViewState();
}

class _DraggableListViewState extends State<DraggableListView> {
  final ItemController controller = Get.put(ItemController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initializeItems(widget.itemNum);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ReorderableListView.builder(
        itemCount: controller.itemTextControllers.length,
        itemBuilder: (context, index) {
          return CustomItem(
            key: ValueKey(index),
            titleController: controller.itemTextControllers[index],
            index: index,
          );
        },
        onReorder: (oldIndex, newIndex) {
          controller.reorderItem(oldIndex, newIndex);
        },
      ),
    );
  }
}
