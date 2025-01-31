import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ListController extends GetxController {
  final List<int> _listOrder = <int>[].obs;
  final RxList<TextEditingController> _listTextControllers =
      <TextEditingController>[].obs;

  List<int> get listOrder => _listOrder;
  List<TextEditingController> get listTextControllers => _listTextControllers;

  void initializeListOrder(int count) {
    _listOrder.clear();
    _listOrder.addAll(List.generate(count, (index) => index));

    print('initializeListOrder');
  }

  void initializeListTextControllers(int count) {
    _listTextControllers.clear();
    _listTextControllers.addAll(
      List.generate(count, (_) => TextEditingController()),
    );
    print('initializeListTextControllers');
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

    update();
    print('reorderList');
  }

  void reorderListTextController(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final textController = _listTextControllers.removeAt(oldIndex);
    _listTextControllers.insert(newIndex, textController);

    update();
    print('reorderListTextController');
  }
}
