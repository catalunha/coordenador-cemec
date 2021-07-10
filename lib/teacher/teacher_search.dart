import 'package:coordenador/teacher/teacher_card.dart';
import 'package:coordenador/teacher/teacher_list_connector.dart';
import 'package:coordenador/user/user_model.dart';
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
    return Row(
      children: [
        Column(
          children: [
            ListTile(
              leading: Icon(Icons.search),
              title: Text(label),
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
                    children: [
                      TeacherCard(teacher: teacher!),
                      ListTile(
                        title: Text(
                          'Retirar este professor deste môdulo',
                          textAlign: TextAlign.end,
                        ),
                        trailing: Icon(Icons.delete_forever_outlined),
                        onTap: onDeleteTeacher,
                      )
                    ],
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
