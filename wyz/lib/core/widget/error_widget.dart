import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  const CustomErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            LottieBuilder.asset(
              "assets/lottie/error.json",
              repeat: false,
              reverse: false,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
