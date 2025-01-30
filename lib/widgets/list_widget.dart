import 'package:flutter/material.dart';

class ListWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(int) onDelete;

  const ListWidget({
    Key? key,
    required this.textEditingController,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  late FocusNode _titleFocusNode;

  late int listKey;

  @override
  void initState() {
    super.initState();

    _titleFocusNode = FocusNode();

    String keyString = widget.key.toString();
    listKey = int.tryParse(keyString.replaceAll(RegExp(r'\D'), '')) ?? 0;
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffF5F6F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
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
                  style: TextStyle(
                    decorationThickness: 0,
                    color: Color(0xff495057),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 1.43,
                  ),
                  decoration: InputDecoration(
                    hintText: '내용을 입력해주세요.',
                    hintStyle: TextStyle(
                      color: Color(0xffADB5BD),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      height: 1.43,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
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
    );
  }
}
