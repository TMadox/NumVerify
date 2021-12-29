import 'package:enterpreware_task/Data/Constants/colors.dart';
import 'package:flutter/material.dart';

void showErrorDialog(
    {required BuildContext context,
    required String title,
    required String description}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          description.toString(),
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(primary: petrolBlue),
              child: const Text("تم"))
        ],
      );
    },
  );
}
