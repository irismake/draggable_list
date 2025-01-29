import 'package:draggable_list/widgets/custom_item.dart';
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
  final List<Widget> items = List.generate(
      10,
      (index) => CustomItem(
            key: ValueKey(index),
            onDelete: () {
              // setState(() {
              //   items.remove(index);
              // });
            },
            index: index,
          ));

  @override
  Widget build(BuildContext context) {
    return DraggableListView(
      itemNum: items.length,
      items: items,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = items.removeAt(oldIndex);
          items.insert(newIndex, item);
        });
      },
    );
  }
}
