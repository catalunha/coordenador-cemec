import 'package:coordenador/course/controller/course_model.dart';
import 'package:coordenador/theme/app_icon.dart';
import 'package:coordenador/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

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
            title: Text('${courseModel.title}',
                style: AppTextStyles.titleBoldHeading),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                        text: 'Descrição: ',
                        style: AppTextStyles.captionBoldBody),
                    TextSpan(
                      text: '${courseModel.description}',
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                        text: 'Ementa: ', style: AppTextStyles.captionBoldBody),
                    TextSpan(
                      text: '${courseModel.syllabus}',
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                        text: 'Môdulos: ',
                        style: AppTextStyles.captionBoldBody),
                    TextSpan(
                      text: '${courseModel.moduleOrder?.length}',
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '${courseModel.id}',
              ),
            ),
          ),
          Wrap(
            children: [
              IconButton(
                tooltip: 'Editar este curso',
                icon: Icon(AppIconData.edit),
                onPressed: () async {
                  Navigator.pushNamed(context, '/course_addedit',
                      arguments: courseModel.id);
                },
              ),
              IconButton(
                tooltip: 'Ver os môdulos deste curso',
                icon: Icon(AppIconData.module),
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
