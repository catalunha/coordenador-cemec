import 'package:coordenador/module/controller/module_model.dart';
import 'package:coordenador/teacher/teacher_card.dart';
import 'package:coordenador/teacher/teacher_tile.dart';
import 'package:coordenador/theme/app_icon.dart';
import 'package:coordenador/theme/app_text_styles.dart';
import 'package:coordenador/user/controller/user_model.dart';
import 'package:coordenador/widget/text_description.dart';
import 'package:flutter/material.dart';

class ModuleCard extends StatelessWidget {
  final ModuleModel moduleModel;
  final UserModel? teacher;

  const ModuleCard({Key? key, required this.moduleModel, this.teacher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 2,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            child:
                Text('${moduleModel.title}', style: AppTextStyles.trailingBold),
            color: Colors.blue.shade50,
          ),
          TeacherTile(
            teacher: teacher,
          ),
          // teacher != null
          //     ? TeacherCard(teacher: teacher!)
          //     : ListTile(
          //         leading: Icon(AppIconData.undefined),
          //       ),
          TextDescription(
            firstWord: 'Descrição: ',
            text: moduleModel.description,
          ),
          TextDescription(
            firstWord: 'Ementa: ',
            text: moduleModel.syllabus,
          ),
          TextDescription(
            firstWord: 'moduleId: ',
            text: moduleModel.id,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: RichText(
          //       text: TextSpan(
          //         style: DefaultTextStyle.of(context).style,
          //         children: [
          //           TextSpan(
          //               text: 'Descrição: ',
          //               style: AppTextStyles.captionBoldBody),
          //           TextSpan(
          //             text: '${moduleModel.description}',
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: RichText(
          //       text: TextSpan(
          //         style: DefaultTextStyle.of(context).style,
          //         children: [
          //           TextSpan(
          //               text: 'Ementa: ', style: AppTextStyles.captionBoldBody),
          //           TextSpan(
          //             text: '${moduleModel.syllabus}',
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: Text(
          //       '${moduleModel.id}',
          //       // textAlign: TextAlign.start,
          //     ),
          //   ),
          // ),
          Wrap(
            children: [
              IconButton(
                tooltip: 'Editar este môdulo',
                icon: Icon(AppIconData.edit),
                onPressed: () async {
                  Navigator.pushNamed(context, '/module_addedit',
                      arguments: moduleModel.id);
                },
              ),
              IconButton(
                tooltip: 'Ver recursos para este môdulo',
                icon: Icon(AppIconData.resourse),
                onPressed: () async {
                  Navigator.pushNamed(context, '/resource',
                      arguments: moduleModel.id);
                },
              ),
              IconButton(
                tooltip: 'Ver situações para este môdulo',
                icon: Icon(AppIconData.situation),
                onPressed: () async {
                  Navigator.pushNamed(context, '/situation',
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
