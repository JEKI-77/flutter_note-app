import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  const NoteFormWidget({
    super.key,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.onChangeIsImportant,
    required this.onChangeNumber,
    required this.onChangeTitle,
    required this.onChangeDescription,
  });

  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final ValueChanged<bool> onChangeIsImportant;
  final ValueChanged<int> onChangeNumber;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangeDescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Switch(value: isImportant, onChanged: onChangeIsImportant),
                Expanded(
                  child: Slider(
                    value: number.toDouble(),
                    min: 0,
                    max: 5,
                    onChanged: (value) => onChangeNumber(
                      value.toInt(),
                    ),
                  ),
                ),
              ],
            ),
            buildTitleField(),
            const SizedBox(
              height: 8,
            ),
            buildDescriptionField(),
          ],
        ),
      ),
    );
  }

  buildTitleField() {
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      onChanged: onChangeTitle,
      validator: (title) {
        if (title!.isEmpty) {
          return 'The title cannot be empty';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  buildDescriptionField() {
    return TextFormField(
      maxLines: 5,
      initialValue: description,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      onChanged: onChangeDescription,
      validator: (desc) {
        if (desc!.isEmpty) {
          return 'The desc cannot be empty';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Type someting ...',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}