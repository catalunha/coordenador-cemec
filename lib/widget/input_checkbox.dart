import 'package:coordenador/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InputCheckBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool? value;
  final void Function(bool?) onChanged;

  const InputCheckBox(
      {Key? key,
      required this.title,
      required this.onChanged,
      this.value,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.check,
                color: AppColors.primary,
              ),
            ),
            Container(
              width: 1,
              height: 48,
              color: AppColors.stroke,
            ),
            Expanded(
              child: CheckboxListTile(
                // checkColor: AppColors.delete,
                // activeColor: AppColors.delete,
                // selectedTileColor: AppColors.delete,
                // secondary: Icon(Icons.delete_forever_outlined),
                // selected: value!,
                // controlAffinity: ListTileControlAffinity.leading,
                title: Text(subtitle),
                onChanged: onChanged,
                value: value,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
