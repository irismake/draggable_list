import 'package:flutter/material.dart';

import '../model/list_model.dart';

class ListController {
  static final ListController _instance = ListController._internal();
  factory ListController() => _instance;
  ListController._internal();

  final ValueNotifier<List<ListModel>> draggableLists = ValueNotifier([]);
  final ValueNotifier<List<TextEditingController>> listTextControllers =
      ValueNotifier([]);

  bool canWrite = false;

  set saveWriteState(bool writeState) {
    canWrite = writeState;
  }

  void initializeListOrder(List<ListModel> lists) {
    draggableLists.value = List<ListModel>.from(lists);
    if (canWrite) {
      initializeListTextControllers();
    }
  }

  void initializeListTextControllers() {
    int count = draggableLists.value.length;
    listTextControllers.value = List.generate(count, (index) {
      return TextEditingController(
          text: draggableLists.value[index].listContent);
    });
  }

  void addList() {
    int newOrder = draggableLists.value.isNotEmpty
        ? draggableLists.value
                .reduce((a, b) => a.listOrder > b.listOrder ? a : b)
                .listOrder +
            1
        : 1;
    ListModel newItem = ListModel(listOrder: newOrder);
    draggableLists.value = [...draggableLists.value, newItem];
    if (canWrite) {
      addListTextControllers();
    }
  }

  void addListTextControllers() {
    listTextControllers.value = [
      ...listTextControllers.value,
      TextEditingController()
    ];
  }

  void removeList(int index) {
    if (index >= 0 && index < draggableLists.value.length) {
      final updatedList = List<ListModel>.from(draggableLists.value);
      updatedList.removeAt(index);
      draggableLists.value = updatedList;
    }
    if (canWrite) {
      removeTextController(index);
    }
  }

  void removeTextController(int index) {
    if (index >= 0 && index < listTextControllers.value.length) {
      final updatedTextList =
          List<TextEditingController>.from(listTextControllers.value);
      updatedTextList.removeAt(index);
      listTextControllers.value = updatedTextList;
    }
  }

  void reorderList({required int oldIndex, required int newIndex}) {
    if (canWrite) {
      reorderListTextController(oldIndex: oldIndex, newIndex: newIndex);
    }
    if (oldIndex < newIndex) newIndex -= 1;
    final updatedList = List<ListModel>.from(draggableLists.value);
    final item = updatedList.removeAt(oldIndex);
    updatedList.insert(newIndex, item);
    draggableLists.value = updatedList;
  }

  void reorderListTextController(
      {required int oldIndex, required int newIndex}) {
    if (oldIndex < newIndex) newIndex -= 1;
    final updatedListTextController =
        List<TextEditingController>.from(listTextControllers.value);
    final item = updatedListTextController.removeAt(oldIndex);
    updatedListTextController.insert(newIndex, item);
    listTextControllers.value = updatedListTextController;
  }
}
