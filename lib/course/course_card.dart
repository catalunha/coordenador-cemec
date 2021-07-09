import 'package:coordenador/course/course_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CourseCard extends StatelessWidget {
  final CourseModel courseModel;
  const CourseCard({Key? key, required this.courseModel}) : super(key: key);

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
                ? Icon(Icons.favorite_outline_rounded)
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
                icon: Icon(Icons.edit),
                onPressed: () async {
                  Navigator.pushNamed(context, '/course_addedit',
                      arguments: courseModel.id);
                },
              ),
              IconButton(
                icon: Icon(Icons.post_add_outlined),
                onPressed: () async {
                  Navigator.pushNamed(context, '/module',
                      arguments: courseModel.id);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
