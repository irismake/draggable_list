import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  final TextEditingController titleController;
  final Function(int) onDelete;

  const ItemWidget({
    Key? key,
    required this.titleController,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  late FocusNode _titleFocusNode;

  late int itemKey;

  @override
  void initState() {
    super.initState();

    _titleFocusNode = FocusNode();

    String keyString = widget.key.toString();
    itemKey = int.tryParse(keyString.replaceAll(RegExp(r'\D'), '')) ?? 0;

    _titleFocusNode.addListener(_onTitleFocusChanged);
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();

    super.dispose();
  }

  void _onTitleFocusChanged() {
    // if (!_titleFocusNode.hasFocus) {
    //   context.read<ItemProvider>().saveItemTitle = {
    //     itemKey: widget.titleController.text
    //   };
    // }
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
                  controller: widget.titleController,
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
              //     widget.onDelete(itemKey);
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
