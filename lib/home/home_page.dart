import 'package:coordenador/course/course_card.dart';
import 'package:coordenador/course/controller/course_model.dart';
import 'package:coordenador/theme/app_colors.dart';
import 'package:coordenador/theme/app_icon.dart';
import 'package:coordenador/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String photoUrl;
  final String displayName;
  final String phoneNumber;
  final String email;
  final String uid;
  final String id;
  final VoidCallback signOut;
  final List<CourseModel> courseModelList;
  const HomePage({
    Key? key,
    required this.photoUrl,
    required this.displayName,
    required this.signOut,
    required this.phoneNumber,
    required this.email,
    required this.courseModelList,
    required this.uid,
    required this.id,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125),
        child: Container(
          height: 110,
          color: AppColors.primary,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: ListTile(
                  onTap: signOut,
                  title: Text(
                    'Olá, $displayName',
                    style: AppTextStyles.titleRegular,
                  ),
                  subtitle: Text('Cursos sob sua COORDENAÇÃO.'),
                  trailing: Tooltip(
                    message:
                        'email: $email\nMobile: $phoneNumber\nuid: ${uid.substring(0, 7)}\nid: ${id.substring(0, 7)}',
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(photoUrl),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topRight,
              child: Wrap(
                children: [
                  IconButton(
                      tooltip: 'Ir para cursos arquivados',
                      onPressed: () => Navigator.pushNamed(
                            context,
                            '/course_archived',
                          ),
                      icon: Icon(AppIconData.archived))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: SingleChildScrollView(
              child: Column(
                children: courseModelList
                    .map((e) => CourseCard(courseModel: e))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(AppIconData.addInCloud),
        onPressed: () async {
          Navigator.pushNamed(context, '/course_addedit', arguments: '');
        },
      ),
    );
  }
}
