import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ItemController extends GetxController {
  final List<String> _itemOrder = <String>[].obs;
  final RxList<TextEditingController> _itemTextControllers =
      <TextEditingController>[].obs;

  List<String> get itemOrder => _itemOrder;
  List<TextEditingController> get itemTextControllers => _itemTextControllers;

  void initializeItems(int count) {
    _itemOrder.clear();
    _itemTextControllers.clear();

    _itemOrder.addAll(List.generate(count, (index) => 'Item $index'));
    _itemTextControllers.addAll(
      List.generate(count, (_) => TextEditingController()),
    );
  }

  void removeItem(int index) {
    if (index >= 0 && index < _itemTextControllers.length) {
      _itemTextControllers.removeAt(index);
    }
  }

  void reorderItem(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final item = _itemOrder.removeAt(oldIndex);
    _itemOrder.insert(newIndex, item);

    final textController = _itemTextControllers.removeAt(oldIndex);
    _itemTextControllers.insert(newIndex, textController);

    update();
  }
}
