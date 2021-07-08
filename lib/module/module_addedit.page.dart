import 'package:coordenador/module/module_addedit_connector.dart';
import 'package:coordenador/course/course_model.dart';
import 'package:coordenador/widget/input_description.dart';
import 'package:coordenador/widget/input_title.dart';
import 'package:flutter/material.dart';

class ModuleAddEditPage extends StatefulWidget {
  final FormController formController;
  final Function(ModuleModel) onSave;

  const ModuleAddEditPage({
    Key? key,
    required this.formController,
    required this.onSave,
  }) : super(key: key);

  @override
  _ModuleAddEditPageState createState() =>
      _ModuleAddEditPageState(formController);
}

class _ModuleAddEditPageState extends State<ModuleAddEditPage> {
  final FormController formController;

  _ModuleAddEditPageState(this.formController);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(formController.moduleModel.id.isEmpty
            ? 'Adicionar môdulo'
            : 'Edit môdulo'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formController.formKey,
            child: Column(
              children: [
                InputTitle(
                  label: 'Título do môdulo',
                  initialValue: formController.moduleModel.title,
                  validator: formController.validateRequiredText,
                  // icon: Icons.text_format,
                  onChanged: (value) {
                    formController.onChange(title: value);
                  },
                ),
                InputDescription(
                  label: 'Descrição do môdulo',
                  initialValue: formController.moduleModel.description,
                  validator: formController.validateRequiredText,
                  // icon: Icons.text_snippet_outlined,
                  onChanged: (value) {
                    formController.onChange(description: value);
                  },
                ),
                InputDescription(
                  label: 'Ementa do môdulo',
                  initialValue: formController.moduleModel.syllabus,
                  validator: formController.validateRequiredText,
                  // icon: Icons.text_snippet_outlined,
                  onChanged: (value) {
                    formController.onChange(syllabus: value);
                  },
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload_outlined),
        onPressed: () {
          formController.onCkechValidation();
          if (formController.isFormValid) {
            widget.onSave(formController.moduleModel);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
