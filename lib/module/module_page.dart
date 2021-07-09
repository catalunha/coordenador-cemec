import 'package:coordenador/course/course_model.dart';
import 'package:coordenador/module/module_card.dart';
import 'package:coordenador/module/module_card_connector.dart';
import 'package:coordenador/module/module_model.dart';
import 'package:flutter/material.dart';

class ModulePage extends StatelessWidget {
  final List<ModuleModel> moduleModelList;
  final CourseModel courseModel;

  const ModulePage({
    Key? key,
    required this.moduleModelList,
    required this.courseModel,
  }) : super(key: key);

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
                    leading: courseModel.iconUrl == null
                        ? Icon(Icons.favorite_outline_rounded)
                        : CircleAvatar(
                            // radius: 20,
                            child:
                                Image.network(courseModel.iconUrl!.toString()),
                            backgroundColor: Colors.transparent,
                          ),
                    title: Text(courseModel.title),
                    // tileColor: Colors.green,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: moduleModelList
                    .map((e) => ModuleCardConnector(moduleModel: e))
                    .toList(),
              ),
            ),
          ),
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
}
