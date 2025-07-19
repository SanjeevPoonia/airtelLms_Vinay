import 'package:airtel_lms/utils/app_modal.dart';
import 'package:airtel_lms/views/splash_screen.dart';
import 'package:airtel_lms/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppTheme.redColor, // status bar color
  ));

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token') ?? '';
  String? userID = prefs.getString('user_id') ?? '';
  print(token);
  if (token != '') {
    AppModel.setTokenValue(token.toString());
    AppModel.setUserID(userID);

  }
  runApp(MyApp(token));
}


class MyApp extends StatefulWidget
{
  final String token;
  MyApp(this.token);

  MyAppState createState()=>MyAppState(token);
}


class MyAppState extends State<MyApp>{
  final String token;
  MyAppState(this.token);
  String _version = 'Unknown';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMSKEY',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.redColor),
        useMaterial3: true,
        fontFamily: "Poppins"
      ),
      home: SplashScreen(token)
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

}

