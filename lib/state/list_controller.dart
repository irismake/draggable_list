import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ListController extends GetxController {
  final List<String> _listOrder = <String>[].obs;
  final RxList<TextEditingController> _listTextControllers =
      <TextEditingController>[].obs;

  List<String> get listOrder => _listOrder;
  List<TextEditingController> get listTextControllers => _listTextControllers;

  void initializeLists(int count) {
    _listOrder.clear();
    _listTextControllers.clear();

    _listOrder.addAll(List.generate(count, (index) => 'List $index'));
    _listTextControllers.addAll(
      List.generate(count, (_) => TextEditingController()),
    );
  }

  void removeList(int index) {
    if (index >= 0 && index < _listTextControllers.length) {
      _listTextControllers.removeAt(index);
    }
  }

  void reorderList(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final list = _listOrder.removeAt(oldIndex);
    _listOrder.insert(newIndex, list);

    final textController = _listTextControllers.removeAt(oldIndex);
    _listTextControllers.insert(newIndex, textController);

    update();
  }
}
