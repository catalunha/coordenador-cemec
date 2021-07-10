import 'package:coordenador/course/course_model.dart';
import 'package:coordenador/module/module_model.dart';
import 'package:coordenador/resource/resource_card.dart';
import 'package:coordenador/resource/resource_model.dart';
import 'package:coordenador/theme/app_text_styles.dart';
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
        title: Text('Recursos deste curso e môdulo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4, right: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Colors.lightBlue,
              elevation: 10,
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10.0),
                  //   child: Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Text(
                  //       'Curso:',
                  //     ),
                  //   ),
                  // ),
                  ListTile(
                    leading: courseModel.iconUrl == null
                        ? Icon(Icons.favorite_outline_rounded)
                        : CircleAvatar(
                            // radius: 20,
                            child:
                                Image.network(courseModel.iconUrl!.toString()),
                            backgroundColor: Colors.transparent,
                          ),
                    title: Text(
                      courseModel.title,
                      style: AppTextStyles.titleBoldHeading,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4, right: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              color: Colors.lightBlueAccent,
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10.0),
                  //   child: Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Text(
                  //       'Môdulo:',
                  //     ),
                  //   ),
                  // ),
                  Text(
                    moduleModel.title,
                    style: AppTextStyles.titleBoldHeading,
                  ),
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
                          title: Text('${teacher!.displayName}'),
                          subtitle: Text(
                              'email: ${teacher!.email}\nMobile:${teacher!.phoneNumber}'),
                          // tileColor: Colors.cyan,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
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
