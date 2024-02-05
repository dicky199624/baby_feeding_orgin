import 'package:baby_feeding/core/common/widgets/round_bttton.dart';
import 'package:baby_feeding/features/authentication/views/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/widgets/white_space.dart';

import '../../../../core/res/image_res.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

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
            RoundButton(
              text: 'Login with phone',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignInScreen(),
                ),
                );
              },
            ),
          ],
        ),
      );
  }
}
