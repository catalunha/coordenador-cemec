import 'package:coordenador/course/course_model.dart';
import 'package:coordenador/module/module_model.dart';
import 'package:coordenador/resource/resource_card.dart';
import 'package:coordenador/resource/resource_model.dart';
import 'package:coordenador/user/user_model.dart';
import 'package:flutter/material.dart';

class ResourcePage extends StatelessWidget {
  final CourseModel courseModel;
  final ModuleModel moduleModel;
  final List<ResourceModel> resourceModelList;
  final UserModel? teacher;

  const ResourcePage({
    Key? key,
    required this.resourceModelList,
    required this.courseModel,
    required this.moduleModel,
    this.teacher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recursos'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 10,
            child: Column(
              children: [
                ListTile(
                  leading: courseModel.iconUrl == null
                      ? Icon(Icons.favorite_outline_rounded)
                      : CircleAvatar(
                          // radius: 20,
                          child: Image.network(courseModel.iconUrl!.toString()),
                          backgroundColor: Colors.transparent,
                        ),
                  title: Text(courseModel.title),
                  tileColor: Colors.green,
                ),
              ],
            ),
          ),
          Card(
              elevation: 10,
              child: Column(
                children: [
                  teacher != null
                      ? ListTile(
                          leading: teacher == null ||
                                  teacher!.photoURL == null ||
                                  teacher!.photoURL!.isEmpty
                              ? Icon(Icons.favorite_outline_rounded)
                              : CircleAvatar(
                                  // radius: 20,
                                  child: Image.network(
                                      teacher!.photoURL.toString()),
                                  backgroundColor: Colors.transparent,
                                ),
                          title: Text(moduleModel.title),
                          subtitle: Text(
                              'Nome: ${teacher!.displayName}\nemail: ${teacher!.email}\nMobile:${teacher!.phoneNumber}'),
                          tileColor: Colors.cyan,
                        )
                      : ListTile(
                          leading: Icon(Icons.favorite_outline_rounded),
                          title: Text(moduleModel.title),
                          tileColor: Colors.cyan,
                        ),
                ],
              )),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: resourceModelList
                    .map((e) => ResourceCard(resourceModel: e))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
