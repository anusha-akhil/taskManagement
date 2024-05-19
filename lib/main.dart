import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taskmanagementapp/pages/noti_details.dart';
import 'package:taskmanagementapp/pages/task%20folder/add_task.dart';
import 'package:taskmanagementapp/pages/home.dart';
import 'package:taskmanagementapp/pages/login.dart';
import 'package:taskmanagementapp/pages/registration.dart';
import 'package:taskmanagementapp/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initialize();
  await Alarm.init();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBlE8kACPdDRFa3J_NA81e7w6t-xZQ-Jic",
          appId: "1:72714634367:android:a38904311d906749786b4a",
          messagingSenderId: "72714634367",
          projectId: "taskmanagemntapp"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: 'Main Navigator');
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationPage(),
        '/home': (context) => const HomePage(),
        '/addtask': (context) => AddTask(),
        '/noti': (context) => Notidetail(),
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
        primaryColor: Colors.purple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const RegistrationPage()
    );
  }
}
