import 'package:baby_feeding/core/common/widgets/white_space.dart';
import 'package:baby_feeding/core/utils/core_utils.dart';
import 'package:baby_feeding/features/authentication/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import '../../../core/res/colours.dart';
import '../../../core/res/image_res.dart';

class OTPVerificationScreen extends ConsumerWidget {
  const OTPVerificationScreen({required this.verificationId, super.key});

  final String verificationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageRes.feeding),
              const WhiteSpace(height: 26),
              Pinput(
                length: 6,
                onCompleted: (pin) async {
                  CoreUtils.showLoader(context);
                 await ref.read(authcontrollerProvider).verifyOTP(
                      context: context,
                      verificationId: verificationId,
                      otp: pin,
                  );
                },
                defaultPinTheme: PinTheme(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                      vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colours.light,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      );
  }
}
