import 'package:coordenador/teacher/teacher_card.dart';
import 'package:coordenador/teacher/controller/teacher_list_connector.dart';
import 'package:coordenador/theme/app_colors.dart';
import 'package:coordenador/theme/app_icon.dart';
import 'package:coordenador/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class TeacherSearch extends StatelessWidget {
  final String label;
  final UserModel? teacher;
  final VoidCallback onDeleteTeacher;

  const TeacherSearch({
    Key? key,
    required this.label,
    required this.teacher,
    required this.onDeleteTeacher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Text(label),
          color: Colors.black12,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                AppIconData.search,
                color: AppColors.primary,
              ),
            ),
            Container(
              width: 1,
              height: 48,
              color: AppColors.stroke,
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(AppIconData.search),
                    title: Text('Clique para buscar da lista'),
                    onTap: () async {
                      await showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return TeacherListConnector(
                              label: 'Selecione um professor',
                            );
                          });
                    },
                  ),
                  teacher != null
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TeacherCard(teacher: teacher!),
                            ListTile(
                              title: Text(
                                'Retirar este professor deste môdulo',
                                textAlign: TextAlign.end,
                              ),
                              trailing: Icon(AppIconData.delete),
                              onTap: onDeleteTeacher,
                            )
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.stroke,
        ),
      ],
    );
  }
}
