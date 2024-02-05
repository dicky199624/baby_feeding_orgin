import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/common/widgets/fading_text.dart';
import '../../../../core/common/widgets/white_space.dart';
import '../../../../core/res/image_res.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageRes.feeding),
            const WhiteSpace(height: 75),
            const FadingText(
              'FidDing For Baby',
              textAlign: TextAlign.center,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
            const WhiteSpace(height: 10),
            Text(
              'Hello, here you can custom your feeding plan for your baby',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.normal,
                color: Colors.pinkAccent,
              ),
            ),
          ],
        ),
      );
  }
}
