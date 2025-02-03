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
  late ListController listController;
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

  List<int> listOrder = [1, 2, 3];
  bool canWrite = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
        child: DraggableList(
          listItems: listOrder,
          canWrite: canWrite,
          enableDrag: true,
          duration: const Duration(milliseconds: 100),
          initializeController: ((controller) {
            listController = controller;
          }),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  listController.addList(canWrite: canWrite);
                },
                child: const Text('Add Item'),
              ),
              ListBuilder(
                style: listStyle,
                customListBuilder: (context, index) {
                  return Padding(
                    key: ValueKey(index),
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 50,
                      color: Colors.amber,
                      margin: const EdgeInsets.only(right: 8.0),
                      child: Center(
                        child: Text(
                          '$index',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
