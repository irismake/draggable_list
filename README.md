# **draggable_list**

This package is a Flutter package that allows you to intuitively sort the order of a list by dragging. It is designed to work smoothly not only with simple container elements but also with complex lists that include text fields.

&nbsp;

## **Features**
- Smooth transition during item insertion and removal from the list with animations.
- Supports creation and reordering of lists containing text fields
- All Lists can be customized
- List creation and deletion buttons can be customized
- Selectable list drag activation/deactivation

&nbsp;

## **Demo**

| Basic List        | Customized List            | Textfield List
|------------------|----------------------|----------------------|
|![KakaoTalk_Photo_2025-02-04-01-16-55](https://github.com/user-attachments/assets/07731453-c512-469b-abd8-76914e78df3c) | ![KakaoTalk_Photo_2025-02-04-01-19-14](https://github.com/user-attachments/assets/3a994c35-1160-4345-9d71-38dd476e4ce5) | ![KakaoTalk_Photo_2025-02-04-01-31-47](https://github.com/user-attachments/assets/50e67fd5-1598-427e-bfd7-01f0c4c1f445)
 
&nbsp;

## **How to use it?**

### **1. Add dependency**
Add this to your package's pubspec.yaml file:
```bash
dependencies:
  draggable_list: <latest_version>
```

&nbsp;

### **2. Install it**
You can install packages from the command line:
with pub:
```bash
$ pub get
```
with Flutter:
```bash
$ flutter pub get
```

&nbsp;


### **3. Import it**
Now in your Dart code, you can use:
```bash
import 'package:draggable_list/draggable_list.dart';
```

&nbsp;

### **4. Use it**

[Example code](https://github.com/irismake/draggable_list/blob/main/example/lib/main.dart) demonstrates a simple draggable list implementation


&nbsp;

### **5. Example Description**

* **Define DraggableList**

  * `listValues` : Initial list data
  * `listController` : Save the controller received from DraggableList
  * `child` : Widget
  * `canWrite` : True when using a list that contains text fields
  * `enableDrag` : Whether dragging is possible
  * `duration` : Specify a waiting time before starting the drag

```
import 'package:draggable_list/draggable_list.dart';

// listValues initialize
late List<ListModel> listValues;

listValues = List.generate(
  contents.length,
  (index) => ListModel(
    listOrder: index,
    listContent: contents[index],
    ),
);
    
// listController lazy initialization
late ListController listController;

DraggableList(
  listValues: listValues,
  canWrite: canWrite,
  enableDrag: true,
  duration: const Duration(milliseconds: 100),
  initializeController: ((controller) {
// listController 초기화
  listController = controller;
  }),
  child:
)
```

&nbsp;

* **Use listController**

  * `addList` function of listController : Added to the last list
  * `removeList` function of listController : The last list is deleted
  * `listController.draggableLists.value` : Get the current list order and contents

```
// Add Lists

Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: ElevatedButton(
        onPressed: () {
          listController.addList();
        },
        child: const Text('Add list'),
      ),
    );
    
// Remove Lists

Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: ElevatedButton(
        onPressed: () {
          listController
              .removeList(listController.draggableLists.value.length - 1);
        },
        child: const Text('Delete list'),
      ),
    ); 

// Get Lists info

Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: ElevatedButton(
        onPressed: () {
          List<ListModel> finalLists = listController.draggableLists.value;
          List<String> contentList =
              finalLists.map((item) => item.listContent ?? "").toList();

          String contentString = contentList.map((item) => item).join(", ");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(contentString),
            ),
          );
        },
        child: const Text('Save list'),
      ),
    );

```

&nbsp;

* **Customizing list styles**

  * `ListBuilder` : A widget that displays a list must be defined within the child of DraggableList.
  * `ListStyle` : A class to customize a list containing text fields (canwrite = true). You can define hintText, textStyle, animateScale, etc.
  * `customListBuilde` : Customization of list items that do not contain a text field (canwrite=false) is possible.

```
// ListStyle

final ListStyle listStyle = ListStyle(
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
    textPadding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 16.0),
    animateBeginScale: 1.0,
    animateEndScale: 1.2,
    deleteIcon: const Icon(
      Icons.cancel,
      color: Color(0xFF212529),
      size: 18.0,
    ),
  );


// ListBuilder

Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ListBuilder(
          style: listStyle,
          customListBuilder: (context, index) {
            return Padding(
              key: ValueKey(index),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 50,
              ),
            );
          }),
);
```
