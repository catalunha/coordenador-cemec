import 'package:coordenador/course/course_model.dart';
import 'package:coordenador/module/module_card_connector.dart';
import 'package:coordenador/module/module_model.dart';
import 'package:flutter/material.dart';

class ModulePage extends StatefulWidget {
  final CourseModel courseModel;
  final List<ModuleModel> moduleModelList;
  final Function(List<String>) onChangeModuleOrder;

  const ModulePage({
    Key? key,
    required this.moduleModelList,
    required this.courseModel,
    required this.onChangeModuleOrder,
  }) : super(key: key);

  @override
  _ModulePageState createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulos deste curso'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4, right: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              color: Colors.lightBlue,
              child: Column(
                children: [
                  ListTile(
                    leading: widget.courseModel.iconUrl == null
                        ? Icon(Icons.favorite_outline_rounded)
                        : CircleAvatar(
                            // radius: 20,
                            child: Image.network(
                                widget.courseModel.iconUrl!.toString()),
                            backgroundColor: Colors.transparent,
                          ),
                    title: Text(widget.courseModel.title),
                    subtitle:
                        Text('Com ${widget.moduleModelList.length} môdulos.'),
                    // tileColor: Colors.green,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ReorderableListView(
              scrollDirection: Axis.vertical,
              onReorder: _onReorder,
              children: buildItens(),
            ),
          ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Column(
          //       children: moduleModelList
          //           .map((e) => ModuleCardConnector(moduleModel: e))
          //           .toList(),
          //     ),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.pushNamed(context, '/module_addedit', arguments: '');
        },
      ),
    );
  }

  buildItens() {
    List<Widget> list = [];
    Map<String, ModuleModel> map = Map.fromIterable(
      widget.moduleModelList,
      key: (element) => element.id,
      value: (element) => element,
    );

    for (var index in widget.courseModel.moduleOrder!) {
      print('$index');
      if (map[index] != null) {
        list.add(Container(
            key: ValueKey(index),
            child: ModuleCardConnector(moduleModel: map[index]!)));
      }
      // list.add(
      //   ListTile(
      //     key: ValueKey(index),
      //     title: Text('$index'),
      //   ),
      // );
    }
    setState(() {});
    return list;
  }

  void _onReorder(int oldIndex, int newIndex) {
    //print('oldIndex:$oldIndex | newIndex:$newIndex');
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    List<String> moduleOrderTemp = widget.courseModel.moduleOrder!;
    setState(() {
      String moduleId = moduleOrderTemp[oldIndex];
      moduleOrderTemp.removeAt(oldIndex);
      moduleOrderTemp.insert(newIndex, moduleId);
    });
    // var index = 1;
    // List<String> moduleModelListOrderned =
    //     _moduleModelList.map((e) => e.id).toList();
    widget.onChangeModuleOrder(moduleOrderTemp);
  }
}
