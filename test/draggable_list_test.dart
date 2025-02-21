import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:draggable_list/draggable_list.dart';
import 'package:draggable_list/builder/custom_reorderable_drag_listener.dart';

void main() {
  group('DraggableList Tests', () {
    testWidgets('Test : DraggableList 기본 위젯 렌더링', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraggableList(
              initListValues: [ListModel(listContent: 'Item 0', listOrder: 0)],
              initializeController: (controller) {},
              child: Column(
                children: [
                  ListBuilder(),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(DraggableList), findsOneWidget);
    });

    testWidgets('Test : DraggableList 커스텀 위젯 렌더링', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraggableList(
              initListValues: [ListModel(listContent: 'Item 0', listOrder: 0)],
              initializeController: (controller) {},
              child: Column(
                children: [
                  ListBuilder(
                    customListBuilder: (context, index) {
                      return Container(
                        key: ValueKey(index),
                        child: Center(
                          child: Text(
                            'Customized lists $index',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(DraggableList), findsOneWidget);
    });

    testWidgets('Test : DraggableList 텍스트 필드 리스트 위젯 렌더링',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraggableList(
              canWrite: true,
              initListValues: [ListModel(listContent: 'Item 0', listOrder: 0)],
              initializeController: (controller) {},
              child: Column(
                children: [
                  ListBuilder(),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(DraggableList), findsOneWidget);
    });

    testWidgets('Test : 기본 리스트 아이템 추가 및 삭제', (WidgetTester tester) async {
      late ListController controller = ListController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraggableList(
              initListValues: [ListModel(listContent: 'Item 0', listOrder: 0)],
              initializeController: (ctrl) {
                controller = ctrl;
              },
              child: Column(
                children: [
                  ElevatedButton(
                    key: const Key('addButton'),
                    onPressed: () {
                      controller.addList();
                    },
                    child: const Text('Add list'),
                  ),
                  ElevatedButton(
                    key: const Key('removeButton'),
                    onPressed: () {
                      controller.removeList(0);
                    },
                    child: const Text('Remove list'),
                  ),
                  ListBuilder(),
                ],
              ),
            ),
          ),
        ),
      );

      expect(controller.draggableLists.value.length, 1);
      expect(controller.draggableLists.value.first.listOrder, 0);

      await tester.tap(find.byKey(const Key('addButton')));
      await tester.pump();

      expect(controller.draggableLists.value.length, 2);
      expect(controller.draggableLists.value.last.listOrder, 1);

      await tester.tap(find.byKey(const Key('removeButton')));
      await tester.pump();

      expect(controller.draggableLists.value.length, 1);
      expect(controller.draggableLists.value.first.listOrder, 1);
    });

    testWidgets('Test : 텍스트 필드 리스트 아이템 추가 및 삭제', (WidgetTester tester) async {
      late ListController controller = ListController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraggableList(
              canWrite: true,
              initListValues: [
                ListModel(listContent: 'Item 0', listOrder: 0),
                ListModel(listContent: 'Item 1', listOrder: 1)
              ],
              initializeController: (ctrl) {
                controller = ctrl;
              },
              child: Column(
                children: [
                  ElevatedButton(
                    key: const Key('addButton'),
                    onPressed: () {
                      controller.addList();
                    },
                    child: const Text('Add list'),
                  ),
                  ElevatedButton(
                    key: const Key('removeButton'),
                    onPressed: () {
                      controller.removeList(0);
                    },
                    child: const Text('Remove list'),
                  ),
                  ListBuilder(),
                ],
              ),
            ),
          ),
        ),
      );

      expect(controller.draggableLists.value.length, 2);

      await tester.tap(find.byKey(const Key('addButton')));
      await tester.pump();

      expect(controller.draggableLists.value.length, 3);
      expect(controller.draggableLists.value.last.listOrder, 2);

      await tester.tap(find.byKey(const Key('removeButton')));
      await tester.pump();

      expect(controller.draggableLists.value.length, 2);
      expect(controller.draggableLists.value.first.listOrder, 1);

      await tester.tap(find.byKey(const Key('deleteButton_0')));
      await tester.pump();

      expect(controller.draggableLists.value.length, 1);
      expect(controller.draggableLists.value.first.listOrder, 2);
    });

    testWidgets('Test : 텍스트 필드 리스트 드래그 앤 드롭', (WidgetTester tester) async {
      late ListController controller = ListController();
      final List<ListModel> items = [
        ListModel(listContent: 'Item 0', listOrder: 0),
        ListModel(listContent: 'Item 1', listOrder: 1),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraggableList(
                canWrite: true,
                initListValues: items,
                initializeController: (ctrl) {
                  controller = ctrl;
                },
                child: Column(
                  children: [
                    ListBuilder(),
                  ],
                )),
          ),
        ),
      );
      // Item 0 찾기
      final firstItemFinder = find.byKey(ValueKey(0));

      // CustomReorderableDragListener 위젯 찾기 (드래그 핸들)
      final dragHandleFinder = find.descendant(
        of: firstItemFinder,
        matching: find.byType(CustomReorderableDragListener),
      );

      // 드래그 시작 (드래그 핸들 위치에서 터치 시작)
      final gesture =
          await tester.startGesture(tester.getCenter(dragHandleFinder));

      // DelayedMultiDragGestureRecognizer의 딜레이를 처리하기 위해 pump (delay 디폴트 값 150ms 적용)
      await tester.pump(Duration(milliseconds: 150));

      // 드래그 동작 수행 (150px 아래로 이동)
      await gesture.moveBy(const Offset(0, 150));

      // 터치 해제 (드래그 종료)
      await gesture.up();

      // 애니메이션이 끝날 때까지 pumpAndSettle 호출
      await tester.pumpAndSettle();

      // 리스트 순서와 리스트 내용이 정렬 되었는지 확인
      expect(controller.draggableLists.value[0].listOrder, 1);
      expect(controller.draggableLists.value[1].listOrder, 0);
      expect(controller.draggableLists.value[0].listContent, 'Item 1');
      expect(controller.draggableLists.value[1].listContent, 'Item 0');
    });
  });
}
