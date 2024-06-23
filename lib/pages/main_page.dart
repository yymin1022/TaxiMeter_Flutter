import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_taxi,
              size: 224.0
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "택시",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold
                  )
                ),
                Text(
                  "미터기",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 48.0
                  )
                )
              ],
            ),
            Text(
              "터치하여 시작하기",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 24.0
              )
            )
          ],
        ),
      )
    );
  }
}