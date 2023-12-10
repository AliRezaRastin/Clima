import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class ErrorMesasge extends StatelessWidget {
  final String title;
  final String message;
  ErrorMesasge({Key? key, required this.title, required this.message})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_rounded,
              size: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: KTitalTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              message,
              style: KlocationTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
