import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';

import 'package:get/get.dart';
import 'package:invitation/firebase_options.dart';

import 'app/routes/app_pages.dart';

// fvm flutter build web --wasm --dart-define=Dart2jsOptimization=O2 && firebase deploy
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lukman & Yuniar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Builder(builder: (context) {
          return FlutterWebFrame(
              builder: (context) => child ?? const SizedBox.shrink(),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              maximumSize: Size(480, MediaQuery.of(context).size.height));
        });
      },
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
    );
  }
}
