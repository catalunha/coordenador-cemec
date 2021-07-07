import 'package:coordenador/theme/app_colors.dart';
import 'package:coordenador/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class InputTitle extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String) onChanged;
  const InputTitle({
    Key? key,
    required this.label,
    this.icon = Icons.text_format,
    this.initialValue,
    this.validator,
    this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        children: [
          Text(label),
          TextFormField(
            controller: controller,
            initialValue: initialValue,
            validator: validator,
            onChanged: onChanged,
            style: AppTextStyles.input,
            decoration: InputDecoration(
              // contentPadding: EdgeInsets.zero,
              // labelText: label,
              labelStyle: AppTextStyles.input,
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Icon(
                      icon,
                      color: AppColors.primary,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 48,
                    color: AppColors.stroke,
                  ),
                ],
              ),
              border: InputBorder.none,
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.stroke,
          ),
        ],
      ),
    );
  }
}
