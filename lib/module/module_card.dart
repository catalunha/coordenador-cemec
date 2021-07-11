import 'package:coordenador/module/module_model.dart';
import 'package:coordenador/teacher/teacher_card.dart';
import 'package:coordenador/user/user_model.dart';
import 'package:flutter/material.dart';

class ModuleCard extends StatelessWidget {
  final ModuleModel moduleModel;
  final UserModel? teacher;

  const ModuleCard({Key? key, required this.moduleModel, this.teacher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // key: ValueKey(moduleModel),
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          teacher != null
              ? TeacherCard(teacher: teacher!)
              : ListTile(
                  leading: Icon(Icons.person_off_outlined),
                ),
          ListTile(
            title: Text('${moduleModel.id}\n${moduleModel.title}'),
            subtitle: Text('${moduleModel.description}'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                moduleModel.syllabus,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Wrap(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  Navigator.pushNamed(context, '/module_addedit',
                      arguments: moduleModel.id);
                },
              ),
              IconButton(
                icon: Icon(Icons.view_carousel_outlined),
                onPressed: () async {
                  Navigator.pushNamed(context, '/resource',
                      arguments: moduleModel.id);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
