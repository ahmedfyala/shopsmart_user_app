import 'package:flutter/material.dart';
import 'package:shopsmart_user/widgets/subtitle_text.dart';
import 'package:shopsmart_user/widgets/title_text.dart';

import '../services/assets_manager.dart';

class EmptyBagWidget extends StatelessWidget {
  const EmptyBagWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.bottomText,
    required this.subTitle,
  });

  final String imagePath, title, bottomText, subTitle;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0,right: 8.0,left: 8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              height: size.height * 0.65,
              width: double.infinity,
            ),
            TitlesTextWidget(
              label: title,
              fontSize: 20,
              color: Colors.red,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SubtitleTextWidget(
                  label: subTitle,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20)),
                onPressed: () {},
                child: Text(
                  bottomText,
                  style: TextStyle(fontSize: 22),
                ))
          ],
        ),
      ),
    );
  }
}
