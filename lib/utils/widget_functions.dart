import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSingleTextFieldInputDialog({
  required BuildContext context,
  required String title,
  String positiveButton = 'OK',
  String negativeButton = 'Close',
  required Function(String) onSubmit,
}) {
  final textController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Padding(
        padding: EdgeInsets.all(8),
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter $title',
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(negativeButton),
        ),
        TextButton(
          onPressed: () {
            if (textController.text.isEmpty) return;

            onSubmit(textController.text);
            Navigator.pop(context);
          },
          child: Text(
            positiveButton,
          ),
        ),
      ],
    ),
  );
}
