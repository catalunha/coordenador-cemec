import 'package:coordenador/user/user_model.dart';
import 'package:flutter/material.dart';

class TeacherCard extends StatelessWidget {
  final UserModel teacher;
  const TeacherCard({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: teacher.photoURL == null
          ? Icon(Icons.person_pin_outlined)
          : CircleAvatar(
              // radius: 20,
              child: Image.network(teacher.photoURL!.toString()),
              backgroundColor: Colors.transparent,
            ),
      title: Text(teacher.displayName ?? ''),
      subtitle: Text('email: ${teacher.email}\nMobile: ${teacher.phoneNumber}'),
    );
  }
}
