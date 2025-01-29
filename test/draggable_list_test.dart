import 'package:draggable_list/draggable_list.dart';
import 'package:draggable_list/widgets/custom_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReorderableListView Tests', () {
    testWidgets('ReorderableListView displays items correctly', (tester) async {
      final List<Widget> items = List.generate(
          3,
          (index) => CustomItem(
                key: ValueKey(index),
                onDelete: () {
                  // setState(() {
                  //   items.remove(index);
                  // });
                },
                index: index,
              ));

      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: DraggableListView(
        itemNum: items.length,
        items: items,
        onReorder: (oldIndex, newIndex) {
          // setState(() {
          //   if (oldIndex < newIndex) {
          //     newIndex -= 1;
          //   }
          //   final item = items.removeAt(oldIndex);
          //   items.insert(newIndex, item);
          // });
        },
      ))));

      // Verify items are displayed
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('ReorderableListView reorders items', (tester) async {
      final List<Widget> items = List.generate(
          3,
          (index) => CustomItem(
                key: ValueKey(index),
                onDelete: () {
                  // setState(() {
                  //   items.remove(index);
                  // });
                },
                index: index,
              ));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(builder: (context, setState) {
              return DraggableListView(
                items: items,
                itemNum: items.length,
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex < newIndex) newIndex -= 1;
                  final item = items.removeAt(oldIndex);
                  setState(() {
                    items.insert(newIndex, item);
                  });
                },
              );
            }),
          ),
        ),
      );

      // 첫 번째 아이템 찾기
      final firstItemFinder = find.textContaining('1');
      expect(firstItemFinder, findsOneWidget);

      // 첫 번째 아이템을 아래로 드래그
      await tester.drag(firstItemFinder, const Offset(0, 50));
      await tester.pumpAndSettle();

      // 새로운 위치에서 "Item 0"이 여전히 존재하는지 확인
      expect(find.textContaining('1'), findsOneWidget);
    });
  });
}
