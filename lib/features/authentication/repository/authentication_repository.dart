


import 'package:baby_feeding/core/helper/db_helper.dart';
import 'package:baby_feeding/core/utils/core_utils.dart';
import 'package:baby_feeding/features/authentication/views/otp_verification_screen.dart';
import 'package:baby_feeding/features/todo/views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final authRepoProvider = Provider((ref) => AuthenticationRepository(auth: FirebaseAuth.instance));

class AuthenticationRepository {
  const AuthenticationRepository({
    required this.auth,
});

  final FirebaseAuth auth;
  Future<void> sendOTP({
    required BuildContext context,
    required String phoneNumber,
}) async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) {
          auth.signInWithCredential(credential);
        },
        verificationFailed: (exception) {
          CoreUtils.showSnackBar(
            context: context,
           message: '${exception.code}: ${exception.message}',
          );
        },
        codeSent: (verificationId, _) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OTPVerificationScreen(verificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future<void> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String otp,
}) async{

    try {
      void showSnack(String message) =>
          CoreUtils.showSnackBar(context: context, message: message);
      
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      
      final navigatior = Navigator.of(context);
      final userCredential = await auth.signInWithCredential(credential);
      
      if(userCredential.user != null) {
        await DBHelper.createUser(isVerified: true);
        navigatior.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
                (route) => false,
        );
      //jump to home screen
      } else {
        showSnack('Error occured, Failed to sing up user');
      }
    } on FirebaseException catch (e) {
      CoreUtils.showSnackBar(
        context: context,
        message: '${e.code}: ${e.message}',
      );
    } catch (e) {
      CoreUtils.showSnackBar(
        context: context,
        message: '505: Error occured, Failed to sing up user',
      );
    }
  }
}
