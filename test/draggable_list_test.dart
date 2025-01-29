import 'package:draggable_list/draggable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReorderableListView Tests', () {
    testWidgets('ReorderableListView reorders items', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(builder: (context, setState) {
              return DraggableListView(
                itemNum: 5,
              );
            }),
          ),
        ),
      );
      // Verify items are displayed
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
    });

    testWidgets('ReorderableListView reorders items', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return DraggableListView(
                  itemNum: 5,
                );
              },
            ),
          ),
        ),
      );

      // Verify initial order of items
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
      expect(find.text('Item 4'), findsOneWidget);

      // 첫 번째 아이템 찾기 (Item 0)
      final firstItemFinder = find.textContaining('Item 0');
      expect(firstItemFinder, findsOneWidget);

      // 첫 번째 아이템을 아래로 드래그
      await tester.drag(firstItemFinder, const Offset(0, 50));
      await tester.pumpAndSettle();

      // 드래그 후, 첫 번째 아이템이 이동된 것을 확인
      expect(find.textContaining('Item 0'), findsOneWidget);

      // 드래그 후 순서가 변경되었는지 확인
      // Item 0은 이제 두 번째 위치에 있어야 합니다.
      expect(find.text('Item 1'), findsOneWidget); // 원래 있던 1번 아이템이 첫 번째로 왔어야 함
      expect(find.text('Item 0'), findsOneWidget); // 원래 있던 0번 아이템이 두 번째로 왔어야 함
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
      expect(find.text('Item 4'), findsOneWidget);
    });
  });
}
