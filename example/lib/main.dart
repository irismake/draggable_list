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
      itemNum: 5,
    );
  }
}
