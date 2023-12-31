import 'dart:io';
import 'dart:typed_data';

import 'package:TeraFlex/pages/classes/firebaseApi.dart';
import 'package:TeraFlex/pages/dashboard/dashboard.dart';
import 'package:TeraFlex/pages/dashboard/options/detailTask.dart';
import 'package:TeraFlex/pages/dashboard/options/help.dart';
import 'package:TeraFlex/pages/dashboard/options/information.dart';
import 'package:TeraFlex/pages/dashboard/options/myAccount.dart';
import 'package:TeraFlex/pages/dashboard/options/notification.dart';
import 'package:TeraFlex/pages/dashboard/options/tasks.dart';
import 'package:TeraFlex/pages/security/forgotPassword.dart';
import 'package:TeraFlex/pages/security/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'firebase_options.dart';

String? savedResponse;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  savedResponse = await getString('token');
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/_.uteq.edu.ec.crt');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TeraFlex',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 6, 75, 170)),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      initialRoute: (savedResponse == null) ? 'login' : 'dashboard',
      routes: {
        'login': (context) => const Login(),
        'dashboard': (context) => const dashboardClient(),
        'recovery-password': (context) => const forgotPassword(),
        'tasks-list': (context) => const tasksList(),
        'detail-task': (context) => const detailTask(),
        'my-account': (context) => const myAccount(),
        'notification': (context) => const NotificationWidget(),
        'help': (context) => const helpMenu(),
        'information': (context) => const InformationDev(),
      },
    );
  }
}
