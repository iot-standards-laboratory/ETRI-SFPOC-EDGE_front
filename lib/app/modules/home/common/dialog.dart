import 'package:flutter/material.dart';

void makeDialog(BuildContext context) async {
  var result = await showDialog(
    builder: (context) => AlertDialog(
      title: const Text('Title'),
      content: const Text('Content'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Ok'),
        ),
      ],
    ),
    context: context,
  );
}
