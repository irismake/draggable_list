import 'package:flutter/material.dart';

import '../custom_drag_listener.dart';
import '../state/draggable_list_style.dart';

class CustomList extends StatefulWidget {
  final int index;
  final TextEditingController textEditingController;
  final DraggableListStyle style;

  const CustomList({
    Key? key,
    required this.index,
    required this.textEditingController,
    this.style = const DraggableListStyle(),
  }) : super(key: key);

  @override
  State<CustomList> createState() => _CustomListState();
}

class _CustomListState extends State<CustomList> {
  late FocusNode _titleFocusNode;

  @override
  void initState() {
    super.initState();

    _titleFocusNode = FocusNode();

    // String keyString = widget.key.toString();
    // listKey = int.tryParse(keyString.replaceAll(RegExp(r'\D'), '')) ?? 0;
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDragListener(
      key: Key('${widget.index}'),
      delay: const Duration(
        milliseconds: 150,
      ),
      parentContext: context,
      index: widget.index,
      child: Row(
        children: [
          Padding(
            padding: widget.style.orderPadding,
            child: Text(
              '${widget.index + 1}',
              style: widget.style.orderTextStyle,
            ),
          ),
          Flexible(
            child: Padding(
              padding: widget.style.listPadding,
              child: Container(
                decoration: BoxDecoration(
                  border: widget.style.border,
                  color: widget.style.backgroundColor,
                  borderRadius: widget.style.borderRadius,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        focusNode: _titleFocusNode,
                        keyboardType: TextInputType.multiline,
                        controller: widget.textEditingController,
                        textAlignVertical: TextAlignVertical.top,
                        textInputAction: TextInputAction.newline,
                        maxLines: null,
                        style: widget.style.contentTextStyle,
                        decoration: InputDecoration(
                          hintText: widget.style.hintText,
                          hintStyle: widget.style.hintTextStyle,
                          isDense: true,
                          contentPadding: widget.style.textPadding,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     FocusScope.of(context).unfocus();
                    //     widget.onDelete(listKey);
                    //   },
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(vertical: 20.0),
                    //     child: Image.asset(
                    //       'assets/icons/icon_delete_fill.png',
                    //       width: 20.0,
                    //       color: Color(0xFF343a40),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
