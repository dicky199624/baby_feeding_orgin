import 'package:baby_feeding/core/common/widgets/filled_field.dart';
import 'package:baby_feeding/core/common/widgets/round_bttton.dart';
import 'package:baby_feeding/core/common/widgets/white_space.dart';
import 'package:baby_feeding/core/utils/core_utils.dart';
import 'package:baby_feeding/features/authentication/app/country_code_provider.dart';
import 'package:baby_feeding/features/authentication/controller/authentication_controller.dart';
import 'package:baby_feeding/features/authentication/repository/authentication_repository.dart';
import 'package:baby_feeding/features/authentication/views/otp_verification_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/res/colours.dart';
import '../../../core/res/image_res.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final border = OutlineInputBorder(
        borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16)
    );
    final phoneController = useTextEditingController();
    final code = ref.watch(countryCodeProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            physics: const PageScrollPhysics(),
            shrinkWrap: true,
            children: [
              Image.asset(ImageRes.feeding),
              const WhiteSpace(height: 20),
              Text(
                'Please your number to get the verification code',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colours.light,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const WhiteSpace(height: 20),
              FilledFiled(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                readOnly: code == null,
                prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 14),
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          onSelect: (code) {
                            ref.read(countryCodeProvider.notifier)
                                .changeCountry(code);
                          },
                          countryListTheme: CountryListThemeData(
                            backgroundColor: Colours.light,
                            bottomSheetHeight: MediaQuery.of(context).size.height * .6,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12),
                            ),
                            textStyle: GoogleFonts.poppins(
                              color: Colours.darkBackground,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: code == null ? 6.h : 1.5.h),
                        child: Text(
                          code == null
                              ? 'Pick your country'
                              : '${code.flagEmoji} +${code.phoneCode} ',
                          style: GoogleFonts.poppins(
                            fontSize: code == null ? 15 : 18,
                            color: code == null ? Colours.lightBlue : Colours.darkBackground,
                            fontWeight: code == null ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
              ),
              const WhiteSpace(height: 20),
              RoundButton(
                text: 'Send Code',
                onPressed:() async {
                  if(code == null) return;
                  final navigatior = Navigator.of(context);
                  CoreUtils.showLoader(context);
                  await ref.read(authcontrollerProvider).sendOTP(context: context,
                      phoneNumber: '+${code.phoneCode}${phoneController.text}',
                  );
                  navigatior.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
