import 'package:draggable_list/builder/custom_reorderable_drag_listener.dart';
import 'package:draggable_list/widget/text_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:draggable_list/draggable_list.dart';

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
      // listOrder : 0,1
      expect(controller.draggableLists.value.length, 2);

      await tester.tap(find.byKey(const Key('addButton')));
      await tester.pump();
      // listOrder : 0,1,2
      expect(controller.draggableLists.value.length, 3);
      expect(controller.draggableLists.value.last.listOrder, 2);

      await tester.tap(find.byKey(const Key('removeButton')));
      await tester.pump();
      // listOrder : 1,2
      expect(controller.draggableLists.value.length, 2);
      expect(controller.draggableLists.value.first.listOrder, 1);

      await tester.tap(find.byKey(Key(
          'deleteButton_${ValueKey(controller.draggableLists.value[0].listOrder)}')));
      await tester.pump();
      // listOrder : 2
      expect(controller.draggableLists.value.length, 1);
      expect(controller.draggableLists.value.first.listOrder, 2);
    });

    testWidgets('Test : 기본 리스트 드래그 앤 드롭', (WidgetTester tester) async {
      late ListController controller = ListController();
      final List<ListModel> items = [
        ListModel(listContent: 'Item 0', listOrder: 0),
        ListModel(listContent: 'Item 1', listOrder: 1),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraggableList(
                canWrite: false,
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
      final firstItemFinder =
          find.byKey(ValueKey(controller.draggableLists.value.first.listOrder));
      // Item 높이 찾기
      final itemHeight = tester.getSize(firstItemFinder).height;

      // 드래그 시작 (드래그 핸들 위치에서 터치 시작)
      final gesture =
          await tester.startGesture(tester.getCenter(firstItemFinder));

      // DelayedMultiDragGestureRecognizer의 딜레이를 처리하기 위해 pump (delay 디폴트 값 150ms 적용)
      await tester.pump(Duration(milliseconds: 150));

      // 드래그 동작 수행
      await gesture.moveBy(Offset(0, itemHeight + 200.0));

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

      // CustomReorderableDragListener 위젯들 찾기 (드래그 핸들)
      final dragHandleFinder = find.ancestor(
        of: find.byType(TextListWidget),
        matching: find.byType(CustomReorderableDragListener),
      );

      // 첫번째 위젯 드래그 시작 (드래그 핸들 위치에서 터치 시작)
      final gesture =
          await tester.startGesture(tester.getCenter(dragHandleFinder.first));

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

    testWidgets('Test : 텍스트 필드의 TextEditingController 생성 및 삭제',
        (WidgetTester tester) async {
      late ListController controller;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraggableList(
              canWrite: true,
              initListValues: [
                ListModel(listContent: 'Item 0', listOrder: 0),
              ],
              initializeController: (ctrl) {
                controller = ctrl;
              },
              child: Column(
                children: [
                  ListBuilder(),
                ],
              ),
            ),
          ),
        ),
      );

      // TextEditingController가 정상적으로 생성되었는지 확인
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);

      // 아이템 추가
      controller.addList();
      await tester.pump();

      // 새로운 아이템이 추가되었으므로 TextField도 추가되어야 함
      expect(find.byType(TextField), findsNWidgets(2));

      // 아이템 삭제
      controller.removeList(0);
      await tester.pump();

      // 삭제 후 하나 남아야 함
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('Test : 키보드 입력 시 리스트 내용이 정상적으로 저장되는지',
        (WidgetTester tester) async {
      late ListController controller;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraggableList(
              canWrite: true,
              initListValues: [
                ListModel(listContent: 'Item 0', listOrder: 0),
                ListModel(listContent: 'Item 1', listOrder: 1),
              ],
              initializeController: (ctrl) {
                controller = ctrl;
              },
              child: Column(
                children: [
                  ListBuilder(),
                ],
              ),
            ),
          ),
        ),
      );
      final firstItemFinder =
          find.byKey(ValueKey(controller.draggableLists.value.first.listOrder));
      final lastItemFinder =
          find.byKey(ValueKey(controller.draggableLists.value.last.listOrder));

      final firstTextFieldFinder = find.descendant(
          of: firstItemFinder, matching: find.byType(TextField));
      final lastTextFieldFinder =
          find.descendant(of: lastItemFinder, matching: find.byType(TextField));

      expect(firstTextFieldFinder, findsOneWidget);
      expect(lastTextFieldFinder, findsOneWidget);

      await tester.enterText(firstTextFieldFinder, 'Updated Item 0');
      await tester.pump();

      await tester.enterText(lastTextFieldFinder, 'Updated Item 1');
      await tester.pump();

      // 완료 버튼
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
          controller.draggableLists.value.first.listContent, 'Updated Item 0');
      expect(
          controller.draggableLists.value.last.listContent, 'Updated Item 1');
    });

    testWidgets('Test : 키보드 unfocus시 키보드 해제 및 content 저장',
        (WidgetTester tester) async {
      late ListController controller;
      final List<ListModel> items = List.generate(
        20,
        (index) => ListModel(listContent: 'Item $index', listOrder: index),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: DraggableList(
                canWrite: true,
                initListValues: items,
                initializeController: (ctrl) {
                  controller = ctrl;
                },
                child: Column(
                  children: [
                    ListBuilder(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      // 스크롤 가능한 위젯 찾기
      final scrollableFinder = find.ancestor(
        of: find.byType(DraggableList),
        matching: find.byType(Scrollable),
      );

      final firstItemFinder =
          find.byKey(ValueKey(controller.draggableLists.value.first.listOrder));

      final firstTextFieldFinder = find.descendant(
          of: firstItemFinder, matching: find.byType(TextField));

      expect(firstTextFieldFinder, findsOneWidget);

      await tester.enterText(firstTextFieldFinder, 'Updated Item 0');
      await tester.pump();

      // 첫 번째 입력 후 키보드가 올라와 있는지 확인
      expect(FocusManager.instance.primaryFocus, isNotNull);

      // 아래로 스크롤 (위에서 아래로 드래그)
      await tester.drag(scrollableFinder, const Offset(0, 300));
      await tester.pumpAndSettle();

      // 리스트의 마지막 아이템이 이제 보여야 함
      expect(find.text('Item 19'), findsOneWidget);
      // 첫 번째 아이템은 안 보여야 함
      expect(find.text('Item 0'), findsNothing);
      // Focus가 바뀌면서 기존 키보드가 내려가야 함
      expect(FocusManager.instance.primaryFocus, isNotNull);

      // 다시 위로 스크롤 (아래에서 위로 드래그)
      await tester.drag(scrollableFinder, const Offset(0, -300));
      await tester.pumpAndSettle();

      expect(
          controller.draggableLists.value.first.listContent, 'Updated Item 0');
    });
  });
}
