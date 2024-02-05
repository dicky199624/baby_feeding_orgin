import 'package:baby_feeding/features/authentication/app/user_provider.dart';
import 'package:baby_feeding/features/on_boarding/views/on_boarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/res/colours.dart';
import 'features/todo/views/home_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    debugPrint(screenSize.toString());
    return ScreenUtilInit(
      designSize: const Size(392.7, 802.9),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
            title: 'baby feeding',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              scaffoldBackgroundColor: Colours.pinkRed,
              useMaterial3: true,
            ),
            home: ref.watch(userProvider).when(
              data:  (userExists) {
                if (userExists) return const HomeScreen();
                return const OnBoardingScreeen();
              },
              error: (error, stackTrace) {
                debugPrint('Error: $error');
                debugPrint(stackTrace.toString());
                return const OnBoardingScreeen();
              },
              loading: () {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }),
        );
      },
    );
  }
}


