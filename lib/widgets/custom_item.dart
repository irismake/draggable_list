import 'package:flutter/material.dart';

import '../custom_drag_listener.dart';

class CustomItem extends StatelessWidget {
  final Function()? onDelete;
  final int index;

  const CustomItem({Key? key, this.onDelete, required this.index})
      : super(key: key);

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
              child:
                  // ItemWidget(
                  //   key: ValueKey(_itemIndexOrder[index]),
                  //   titleController: _titleControllers[index],
                  //   onDelete: (itemKey) {
                  //     _removeItem(itemKey);
                  //   },
                  // ),
                  Container(
            color: Colors.cyan,
          )),
        ],
      ),
    );
  }
}
