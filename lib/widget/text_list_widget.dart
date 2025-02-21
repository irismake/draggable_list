import 'package:flutter/material.dart';

import '../draggable_list.dart';

class TextListWidget extends StatefulWidget {
  final bool enableDrag;
  final int index;
  final TextEditingController textEditingController;
  final ListStyle style;

  const TextListWidget({
    Key? key,
    required this.enableDrag,
    required this.index,
    required this.textEditingController,
    this.style = const ListStyle(),
  }) : super(key: key);

  @override
  State<TextListWidget> createState() => _TextListBuilderState();
}

class _TextListBuilderState extends State<TextListWidget> {
  late ListController controller;
  late FocusNode _textFocusNode;

  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    _textFocusNode.addListener(_onFocusChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final draggableList = DraggableList.of(context);
    controller = draggableList?.controller ?? ListController();
  }

  void _onFocusChanged() {
    if (!_textFocusNode.hasFocus) {
      controller.draggableLists.value[widget.index].listContent =
          widget.textEditingController.text;
    }
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        widget.enableDrag
            ? Container(
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
              )
            : const SizedBox.shrink(),
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
                      focusNode: _textFocusNode,
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
                  InkWell(
                    key: Key('deleteButton_${widget.key}'),
                    onTap: () {
                      controller.removeList(widget.index);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      child: widget.style.deleteIcon,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
