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
  final DraggableListStyle listStyle = DraggableListStyle(
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
    hintText: '내용',
    listPadding: const EdgeInsets.symmetric(vertical: 2.0),
    textPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
    animateBeginScale: 1.0,
    animateEndScale: 1.2,
  );
  List<Color> colors = [
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.purple
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
        child: DraggableListView(
          listNum: colors.length,
          style: listStyle,

          // There is no need to enter text in the list, and input is required when using the desired list.
          // canWrite: true,
          // enableDrag: false,
          customListBuilder: (context, index) {
            return Padding(
              key: ValueKey(index),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 50,
                color: colors[index],
                margin: const EdgeInsets.only(right: 8.0),
                child: Center(
                    child: Text('${index}',
                        style: TextStyle(color: Colors.white))),
              ),
            );
          },
          listValue: (value) {
            print(value);
          },
        ),
      ),
    );
  }
}
