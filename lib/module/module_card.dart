import 'package:coordenador/course/course_model.dart';
import 'package:flutter/material.dart';

class ModuleCard extends StatelessWidget {
  final ModuleModel moduleModel;

  const ModuleCard({Key? key, required this.moduleModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text('Module'),
    );
  }
}
