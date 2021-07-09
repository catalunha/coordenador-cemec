import 'package:coordenador/teacher/teacher_card.dart';
import 'package:coordenador/teacher/teacher_list_connector.dart';
import 'package:coordenador/user/user_model.dart';
import 'package:flutter/material.dart';

class TeacherSearch extends StatelessWidget {
  final String label;
  final UserModel? teacher;
  const TeacherSearch({Key? key, required this.label, required this.teacher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        teacher != null ? TeacherCard(teacher: teacher!) : Container(),
      ],
    );
  }
}
