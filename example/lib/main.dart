import 'package:draggable_list/state/draggable_list_style.dart';
import 'package:flutter/material.dart';
import 'package:draggable_list/draggable_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Draggable List Example')),
        body: MyDraggableList(),
      ),
    );
  }
}

class MyDraggableList extends StatefulWidget {
  @override
  _MyDraggableListState createState() => _MyDraggableListState();
}

class _MyDraggableListState extends State<MyDraggableList> {
  @override
  Widget build(BuildContext context) {
    return DraggableListView(
      listNum: 10,
      style: DraggableListStyle(
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
          style: BorderStyle.solid,
        ),
        contentTextStyle: const TextStyle(
          decorationThickness: 0,
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w500,
          height: 1.43,
        ),
        hintTextStyle: const TextStyle(
          decorationThickness: 0,
          color: Color(0xffADB5BD),
          fontSize: 14,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w500,
          height: 1.43,
        ),
        orderTextStyle: const TextStyle(
          decorationThickness: 0,
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w500,
          height: 1.43,
        ),
        hintText: '내용',
        orderPadding: const EdgeInsets.only(left: 10.0),
        listPadding:
            const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
        textPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      ),
    );
  }
}
