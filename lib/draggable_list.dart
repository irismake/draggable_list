library reorderable_list;

import 'package:flutter/material.dart';

class DraggableListView extends StatefulWidget {
  final int itemNum;
  final List<Widget> items;
  final void Function(int oldIndex, int newIndex) onReorder;
  final bool enableDrag;

  const DraggableListView({
    Key? key,
    required this.itemNum,
    required this.items,
    required this.onReorder,
    this.enableDrag = true,
  }) : super(key: key);

  @override
  _DraggableListViewState createState() => _DraggableListViewState();
}

class _DraggableListViewState extends State<DraggableListView> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemBuilder: (context, index) => widget.items[index],
      itemCount: widget.items.length,
      onReorder: widget.onReorder,
      buildDefaultDragHandles: widget.enableDrag,
    );
  }
}
