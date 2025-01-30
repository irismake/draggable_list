import 'package:flutter/material.dart';

import '../custom_drag_listener.dart';
import 'list_widget.dart';

class CustomList extends StatelessWidget {
  final int index;
  final TextEditingController textEditingController;

  const CustomList({
    Key? key,
    required this.index,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDragListener(
      key: Key('$index'),
      delay: const Duration(
        milliseconds: 150,
      ),
      parentContext: context,
      index: index,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: Color(0xFF343a40),
                fontSize: 18,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Flexible(
            child: ListWidget(
              key: ValueKey('$index'),
              textEditingController: textEditingController,
              onDelete: (listKey) {
                // _removeItem(itemKey);
              },
            ),
          ),
        ],
      ),
    );
  }
}
