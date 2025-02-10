import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wyz/core/extensions/mediaquery_extension.dart';

class FormSkeleton extends StatelessWidget {
  const FormSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;
    double scrWidth = context.mediaQueryWidth;

    return Skeletonizer(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: scrWidth,
                height: scrHeight * 0.05,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            (scrHeight * 0.02).height,
            Container(
              width: scrWidth,
              height: scrHeight * 0.05,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
            (scrHeight * 0.02).height,
            Container(
              width: scrWidth,
              height: scrHeight * 0.05,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
            (scrHeight * 0.02).height,
            Container(
              width: scrWidth,
              height: scrHeight * 0.05,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
            (scrHeight * 0.02).height,
            Container(
              width: scrWidth,
              height: scrHeight * 0.05,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
            (scrHeight * 0.04).height,
            ElevatedButton(
              onPressed: () {},
              child: const Text("daasdasdasdasdta"),
            )
          ],
        ),
      ),
    );
  }
}
