import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidjet extends StatelessWidget {
  const LoadingWidjet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingCircle(
              color: KligtColor,
              size: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Feaching Data',
              style: TextStyle(
                fontSize: 20,
                color: KligthColorText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
