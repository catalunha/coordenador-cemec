import 'package:coordenador/course/course_addedit_connector.dart';
import 'package:coordenador/course/course_model.dart';
import 'package:coordenador/widget/input_description.dart';
import 'package:coordenador/widget/input_file.dart';
import 'package:coordenador/widget/input_file_connector.dart';
import 'package:coordenador/widget/input_title.dart';
import 'package:flutter/material.dart';

class CourseAddEditPage extends StatefulWidget {
  final FormController formController;
  final Function(CourseModel) onSave;

  const CourseAddEditPage({
    Key? key,
    required this.formController,
    required this.onSave,
  }) : super(key: key);

  @override
  _CourseAddEditPageState createState() => _CourseAddEditPageState();
}

class _CourseAddEditPageState extends State<CourseAddEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formController.courseModel.id.isEmpty
            ? 'Adicionar curso'
            : 'Edit curso'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: widget.formController.formKey,
            child: Column(
              children: [
                InputTitle(
                  label: 'Título do curso',
                  initialValue: widget.formController.courseModel.title,
                  validator: widget.formController.validateRequiredText,
                  // icon: Icons.text_format,
                  onChanged: (value) {
                    widget.formController.onChange(title: value);
                  },
                ),
                InputDescription(
                  label: 'Descrição do curso',
                  initialValue: widget.formController.courseModel.description,
                  validator: widget.formController.validateRequiredText,
                  // icon: Icons.text_snippet_outlined,
                  onChanged: (value) {
                    widget.formController.onChange(description: value);
                  },
                ),
                InputDescription(
                  label: 'Ementa do curso',
                  initialValue: widget.formController.courseModel.syllabus,
                  validator: widget.formController.validateRequiredText,
                  // icon: Icons.text_snippet_outlined,
                  onChanged: (value) {
                    widget.formController.onChange(syllabus: value);
                  },
                ),
                InputFileConnector(
                  label: 'Informe o ícone do curso',
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload_outlined),
        onPressed: () {
          widget.formController.onCkechValidation();
          if (widget.formController.isFormValid) {
            widget.onSave(widget.formController.courseModel);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
