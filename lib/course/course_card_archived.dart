import 'package:coordenador/course/controller/course_model.dart';
import 'package:coordenador/theme/app_icon.dart';
import 'package:flutter/material.dart';

class CourseCardArchived extends StatelessWidget {
  final CourseModel courseModel;
  final Function(String) unArchived;

  const CourseCardArchived(
      {Key? key, required this.courseModel, required this.unArchived})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: courseModel.iconUrl == null
                ? Icon(AppIconData.undefined)
                // : CircleAvatar(
                //     // radius: 20,
                //     child: Image.network(courseModel.iconUrl!.toString()),
                //     backgroundColor: Colors.black26,
                //   ),
                : Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(courseModel.iconUrl!),
                      ),
                    ),
                  ),
            title: Text(courseModel.title),
            subtitle: Text(courseModel.description),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                courseModel.syllabus,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Wrap(
            children: [
              IconButton(
                tooltip: 'Retirar este curso do arquivo',
                icon: Icon(AppIconData.unArchive),
                onPressed: () {
                  unArchived(courseModel.id);
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
