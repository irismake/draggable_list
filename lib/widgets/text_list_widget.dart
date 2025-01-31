import 'package:flutter/material.dart';

import '../custom_reorderable_drag_listener.dart';
import '../state/draggable_list_style.dart';

class TextListWidget extends StatefulWidget {
  final bool enableDrag;
  final int index;
  final TextEditingController textEditingController;
  final DraggableListStyle style;
  final Duration duration;

  const TextListWidget({
    Key? key,
    required this.enableDrag,
    required this.index,
    required this.textEditingController,
    this.style = const DraggableListStyle(),
    required this.duration,
  }) : super(key: key);

  @override
  State<TextListWidget> createState() => _TextListWidgetState();
}

class _TextListWidgetState extends State<TextListWidget> {
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
    return CustomReorderableDragListener(
      enableDrag: widget.enableDrag,
      key: Key('${widget.index}'),
      delay: widget.duration,
      parentContext: context,
      index: widget.index,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 30,
            child: Text(
              '${widget.index + 1}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
              ),
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
            ),
          ),
        ],
      ),
    );
  }
}
