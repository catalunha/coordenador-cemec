import 'package:coordenador/course/controller/course_model.dart';
import 'package:coordenador/module/controller/module_model.dart';
import 'package:coordenador/resource/resource_card.dart';
import 'package:coordenador/resource/controller/resource_model.dart';
import 'package:coordenador/theme/app_icon.dart';
import 'package:coordenador/theme/app_text_styles.dart';
import 'package:coordenador/user/controller/user_model.dart';
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
                  ListTile(
                    leading: courseModel.iconUrl == null
                        ? Icon(AppIconData.undefined)
                        : Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: NetworkImage(courseModel.iconUrl!),
                              ),
                            ),
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
                  Text(
                    moduleModel.title,
                    style: AppTextStyles.titleBoldHeading,
                  ),
                  teacher != null
                      ? ListTile(
                          leading: teacher == null ||
                                  teacher!.photoURL == null ||
                                  teacher!.photoURL!.isEmpty
                              ? Icon(AppIconData.undefined)
                              : Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: NetworkImage(teacher!.photoURL!),
                                    ),
                                  ),
                                ),
                          title: Text('${teacher!.displayName}'),
                          subtitle: Text(
                              'email: ${teacher!.email}\nMobile:${teacher!.phoneNumber}'),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Column(
          //       children: resourceModelList
          //           .map((e) => ResourceCard(resourceModel: e))
          //           .toList(),
          //     ),
          //   ),
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildItens(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildItens(context) {
    List<Widget> list = [];
    Map<String, ResourceModel> map = Map.fromIterable(
      resourceModelList,
      key: (element) => element.id,
      value: (element) => element,
    );
    for (var index in moduleModel.resourceOrder!) {
      if (map[index] != null) {
        list.add(Container(
            key: ValueKey(index),
            child: ResourceCard(resourceModel: map[index]!)));
      }
    }
    return list;
  }
}
