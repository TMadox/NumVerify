import 'package:enterpreware_task/Data/Constants/colors.dart';
import 'package:enterpreware_task/Data/Models/number_model.dart';
import 'package:flutter/material.dart';

void showInfoDialog(
    {required BuildContext context, required NumberModel number}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Number Info"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Valid"),
              subtitle: Text(number.valid.toString()),
            ),
            ListTile(
              title: const Text("Local Format"),
              subtitle: Text(number.localFormat.toString()),
            ),
            ListTile(
              title: const Text("Intl. Format"),
              subtitle: Text(number.intlFormat.toString()),
            ),
            ListTile(
              title: const Text("Country"),
              subtitle: Text(number.countryName.toString()),
            ),
            ListTile(
              title: const Text("Location"),
              subtitle: Text(number.location.toString() == ""
                  ? "Not Found"
                  : number.location.toString()),
            ),
            ListTile(
              title: const Text("Carrier"),
              subtitle: Text(number.carrier.toString()),
            ),
            ListTile(
              title: const Text("Line Type"),
              subtitle: Text(number.lineType.toString()),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(primary: petrolBlue),
              child: const Text("Ok"))
        ],
      );
    },
  );
}
