import 'package:coordenador/theme/app_icon.dart';
import 'package:coordenador/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class TeacherCard extends StatelessWidget {
  final UserModel teacher;
  const TeacherCard({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: teacher.photoURL == null
          ? Icon(AppIconData.undefined)
          : Tooltip(
              message: 'id: ${teacher.id}',
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(teacher.photoURL!.toString()),
                  ),
                ),
              ),
            ),
      title: Text(teacher.displayName ?? ''),
      subtitle: Text('email: ${teacher.email}\nMobile: ${teacher.phoneNumber}'),
    );
  }
}
