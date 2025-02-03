import 'package:flutter/material.dart';

import '../draggable_list.dart';
import 'custom_reorderable_drag_listener.dart';

class TextListBuilder extends StatefulWidget {
  final bool enableDrag;
  final int index;
  final TextEditingController textEditingController;
  final ListStyle style;
  final Duration duration;

  const TextListBuilder({
    Key? key,
    required this.enableDrag,
    required this.index,
    required this.textEditingController,
    this.style = const ListStyle(),
    required this.duration,
  }) : super(key: key);

  @override
  State<TextListBuilder> createState() => _TextListBuilderState();
}

class _TextListBuilderState extends State<TextListBuilder> {
  late ListController controller;
  late bool canWrite;
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
    canWrite = draggableList?.canWrite ?? false;
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
    return CustomReorderableDragListener(
      enableDrag: widget.enableDrag,
      key: Key('${widget.index}'),
      delay: widget.duration,
      parentContext: context,
      index: widget.index,
      child: Row(
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
                      onTap: () {
                        FocusScope.of(context).unfocus();
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
      ),
    );
  }
}
