import 'package:flutter/material.dart';

class ListController {
  static final ListController _instance = ListController._internal();
  factory ListController() => _instance;
  ListController._internal();

  final ValueNotifier<List<int>> listOrder = ValueNotifier([]);
  final ValueNotifier<List<TextEditingController>> listTextControllers =
      ValueNotifier([]);

  void initializeListOrder(List<int> list) {
    listOrder.value = List<int>.from(list);
  }

  void initializeListTextControllers() {
    int count = listOrder.value.length;
    listTextControllers.value =
        List.generate(count, (_) => TextEditingController());
  }

  void addList({required bool canWrite}) {
    int newItem = (listOrder.value.isNotEmpty)
        ? listOrder.value.reduce((a, b) => a > b ? a : b) + 1
        : 1;
    listOrder.value = [...listOrder.value, newItem];
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
    if (index >= 0 && index < listTextControllers.value.length) {
      final updatedList = List<int>.from(listOrder.value);
      updatedList.removeAt(index);
      listOrder.value = updatedList;
    }
  }

  void reorderList(
      {required int oldIndex, required int newIndex, required bool canWrite}) {
    if (oldIndex < newIndex) newIndex -= 1;
    final updatedList = List<int>.from(listOrder.value);
    final item = updatedList.removeAt(oldIndex);
    updatedList.insert(newIndex, item);
    listOrder.value = updatedList;

    if (canWrite) {
      reorderListTextController(oldIndex, newIndex);
    }
  }

  void reorderListTextController(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    final updatedListTextController =
        List<TextEditingController>.from(listTextControllers.value);

    final item = updatedListTextController.removeAt(oldIndex);

    updatedListTextController.insert(newIndex, item);
    listTextControllers.value = updatedListTextController;
  }
}
