

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:airtel_lms/utils/app_modal.dart';
import 'package:airtel_lms/views/courses/all_courses_screen.dart';
import 'package:airtel_lms/views/home_screen.dart';
import 'package:airtel_lms/views/landing_screen.dart';
import 'package:airtel_lms/views/login_screen.dart';
import 'package:airtel_lms/views/pending_module_tab.dart';
import 'package:airtel_lms/views/assigned_training/given_training_screen.dart';
import 'package:airtel_lms/views/quiz/terms_screen.dart';
import 'package:airtel_lms/views/training/start_training_screen.dart';
import 'package:airtel_lms/widgets/dashboard_widget.dart';
import 'package:airtel_lms/widgets/tab_indicator.dart';
import 'package:airtel_lms/widgets/firebase/message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:lottie/lottie.dart';

import '../network/api_helper.dart';
import '../network/loader.dart';
import '../utils/app_theme.dart';
import 'completed_module_tab.dart';
import 'notification_screen.dart';

class NewDashboardScreen extends StatefulWidget
{
  DashboardState createState()=>DashboardState();
}
class DashboardState extends State<NewDashboardScreen>
{
  Map<String,dynamic> dashboardData={};
  bool isLoading=false;
  late AndroidNotificationChannel channel;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  bool isFlutterLocalNotificationsInitialized = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 27),

          Container(
            height: 57,
            color: Colors.black,
            child: Row(
              children: [
                SizedBox(width: 8),
                Image.asset("assets/payment_bank_ic.png"),

                Spacer(),

                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
                    },

                    child: Image.asset("assets/bell_ic.png",width:30,height: 30)),

                SizedBox(width: 12),




              ],
            ),
          ),

        Expanded(child:
        isLoading || dashboardData.isEmpty?
        Center(
            child: Loader(),
        ):


        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 27),


            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LandingScreen()));
              },
              child: Container(
                height: 261,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 52),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFF5F5F5)
                ),

                child: Column(
                  children: [




                    SizedBox(height: 15),

                    /*  SizedBox(
                    height: 150,
                    child: OverflowBox(
                        minHeight: 220,
                        maxHeight: 220,
                        child:   Lottie.asset("assets/my_training_anim.json")
                    ),
                  ),*/


                    SizedBox(
                        height:168,
                        child: Lottie.asset("assets/my_training_anim.json")),

                    SizedBox(height: 7),

                    Text(
                      "My Training",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),

                    Text(
                      "Today's Pending Task : "+dashboardData["my_training"]["today"].toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),

                    Text(
                      "Overall Pending Task : "+dashboardData["my_training"]["total"].toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

              ),
            ),

            SizedBox(height: 32),


            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GivenTrainingScreen()));

              },
              child: Container(
                height: 261,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 52),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFF5F5F5)
                ),

                child: Column(
                  children: [




                    SizedBox(height: 15),

                    /*  SizedBox(
                    height: 150,
                    child: OverflowBox(
                        minHeight: 220,
                        maxHeight: 220,
                        child:   Lottie.asset("assets/my_training_anim.json")
                    ),
                  ),*/


                    SizedBox(
                        height:168,
                        child: Lottie.asset("assets/given_training_anim.json")),

                    SizedBox(height: 7),

                    Text(
                      "Give Training",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),

                    Text(
                      "Training List : "+dashboardData["given_tarining"]["today"].toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),

                    Text(
                      "Completed Trainings : "+dashboardData["given_tarining"]["total"].toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

              ),
            ),


          ],
        ))

        ],
      )
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupFlutterNotifications();
   // obtainAuthenticatedClient();
    fetchDashboardData(context);
  }

  fetchDashboardData(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "Authorization": AppModel.token
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('profile-trainings', data, context);
    isLoading=false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    dashboardData=responseJSON["data"];
    setState(() {

    });


  }



  void showFlutterNotification(RemoteMessage message) {
    print("Show Notiof SDATA");
    print(message.data.toString());
    print(message.toString());

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;
    if (notification != null) {
      if (android != null) {
        flutterLocalNotificationsPlugin?.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'default_channel_id',
              'Default Channel',
              playSound: true,
              channelDescription: 'Default Channel Description',
              icon: 'payment_bank_ic',
            ),
          ),
          payload: jsonEncode(message.data),
        );
      } else if (apple != null) {
        flutterLocalNotificationsPlugin?.show(
          notification.hashCode,
          notification.title,
          notification.body,


          NotificationDetails(
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
        );

      }
    }
  }

/*
// Use service account credentials to get an authenticated and auto refreshing client.
  Future<AuthClient> obtainAuthenticatedClient() async {
    final accountCredentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "lms-key-28dcf",
      "private_key_id": "b918d3edb9a391b8292d2e6eb2e43723fef7c108",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC9Z4JxW+hqXRGz\nySX/XfefzbaA40IKtj1TL/Rvb9OYC5Fv1D3xkyJf3ZSC5PiOe8F/UuTPKkt66VVQ\nSXh8B8Nv5J6BfnaM884+BA0MGMjR7b9sewBELYK/wP5Xevgob6tgxqYDV0rrdv84\nxPN06E4XG58Gg+fBlp5Ixm2qejH4PqUY7b2Oc+IKvqyzG93BcCYlM0c4CN1kLFeB\npUJo7dPfYrm+Lh14Y7+nfUY5im2pvcx4TFRJ6K3XkarO8q0y+lq0AkUAxSXZDUGc\nSK4nggmkNOtVaLgmz5w4u1Q3o6Y6fczCRHTsv2NvKCudOJ1Hj8RMl1hl95aUnw0u\nVhtZFqt5AgMBAAECggEAHsF6KxIzkWH/h+Q36VnG5govgopkpPymxKVa2eWcxGnM\neg5K6LltsYd3oDGyMuDhsN0zDnjdvN263sivaeSQ1dCX9IsmkQjeCq/5tmcn5P7o\nQKNQjcGeI6khI+9x8I8Bkztupcg9ADNYik1hAzDdzV7M2e/9aDAfD8447J/fEWJD\nOB4CVGVT+ewqfbbBCHQjASelmXELrxwfmdmUe2VDz0BeGJ3TqIxEMZjs+SyM84F+\njP3Bb9TsstFSt5nQdDUOvfoojbi4dPynxehXasY2lIkZhVkzqCLBnmACpVnum9IR\nhcD9Z7mqy6FHeT0LPQcBYuH64uYCrrac2ZIJ3EBzKQKBgQDkwVLjX+LDd4XyZ9Lu\n5rREBPeU4ojNsIdS/gJURgzJ8ulDi5+S4rzCz5owU1+AkHsnTkZD6Fsrd8D8rJOX\nNYBXiW0pRQlpDpQxbOVIi/wOU80uYYhxTeq1jDfxCwH1pmm1JJUHXL603V457C55\n40gKzvSC8Q4YjGYMzWnpRUMnfwKBgQDT9mP+o/dxcNGRNb/MSBAK/UnrXiUOTYJP\n9AtGipCdqTXt3+dMzPtns6HhjTiu12KjRrDM8GLrBcAXz/3+/hDRfZnPetlGAuFy\nRTpfzqytvaAfhZZzLHQWCUfZZiikjns14di6SGMnM4l/IE75Vzx04wWQTLe1DdIN\nzBfYobLpBwKBgFWlT/xTVRpr8JmOZ7oMZGenGG8E1cV1F2VqNsMIqxcdPFqOtwMO\noy+o/IilXndLIODZfJNGNoQyxO2VS3jsjg24JUezUk+kJrXOmJWt24Qdug9ocuZB\nDuRECFnWDjjDwoYQmT91aO1ciD/Vfp0iDEIHtCImUGm+fyLB8aplxTvPAoGAFmgl\nifWrYsKaZM9Zxy6XA5JjDg6VvD1VWT5jMsHTJ9eLa+oPeX7x1LSYmE9lfpYmRzxh\n1EhVLKMe+2VxZFNXU84DRHuoHE6RppLK6PXgKz2wf6SPkv1QCERS5Bh4k2y8eaW2\nU3rzgGFiV54CuzkNmw2kuOxjPzCG1A6PNsdhMmECgYEAgjJdVK7+IWymdgiB26d7\nSELk/6KleJgK3lSIekmT9CbfNnEDJ4IYjDLVAyTlRzckRUYJKcdscQhLlpHfF4KS\npuUW/baL62j5UocL/7NNzuewPjjxrb7nfy9DMhXjzORQJQgPmeIgUCCNb5kApk0H\nHW+nu8NQ/sAF/YWx0QXabPw=\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-o17o2@lms-key-28dcf.iam.gserviceaccount.com",
      "client_id": "107162570802485924303",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-o17o2%40lms-key-28dcf.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    });
    var scopes = [
      "https://www.googleapis.com/auth/firebase.messaging",
    ];

    AuthClient client = await clientViaServiceAccount(accountCredentials, scopes);
    print("Client Token");
    log(client.credentials.accessToken.toString());

    return client; // Remember to close the client when you are finished with it.
  }
*/

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    print(notificationResponse.toString());
    print(notificationResponse.payload.toString());
    Map notificationPayload = (jsonDecode(notificationResponse.payload!));
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $notificationPayload');
      print(notificationPayload["model_id"].toString());

      if(notificationPayload["type"]=="training")
      {
        await Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) => SelfTrainingScreen(notificationPayload["model_id"].toString(),0.0,"self")),
        );
      }
      else if(notificationPayload["type"]=="test")
      {

        await Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) => MCQTermsScreen(notificationPayload["model_id"].toString())),
        );

      }


      else if(notificationPayload["type"]=="news")
      {

        await Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) => AllCoursesScreen()),
        );

      }
    }

  }
  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title??''),
        content: Text(body??''),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
             /* await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(payload),
                ),
              );*/
            },
          )
        ],
      ),
    );
  }
  Future<void> setupFlutterNotifications() async {
    // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    print("FRRR");

    print(FirebaseMessaging.instance.getInitialMessage());
    //  print(FirebaseMessaging.instance.c);


    NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
        announcement: true,
        carPlay: true,
        criticalAlert: true,
        sound: true
    );


   // await FirebaseMessaging.instance.subscribeToTopic('refresh22');
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/payment_bank_ic');
    final DarwinInitializationSettings  initializationSettingsIOS =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin!.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;



    FirebaseMessaging.instance.getInitialMessage().then(
          (value) async {

            if(value!=null)
              {
                print("Get Intial Message");

                print(value.data.toString());


                if(value.data["type"]=="training")
                {
                  await Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (context) => SelfTrainingScreen(value.data["model_id"].toString(),0.0,"self")),
                  );
                }
                else if(value.data["type"]=="test")
                {

                  await Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (context) => MCQTermsScreen(value.data["model_id"].toString())),
                  );

                }

                else if(value.data["type"]=="news")
                {

                  await Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (context) => AllCoursesScreen()),
                  );

                }
              }



          }
    );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      print(message.data.toString());

         if(message.data["type"]=="training")
          {
            await Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (context) => SelfTrainingScreen(message.data["model_id"].toString(),0.0,"self")),
            );
          }
          else if(message.data["type"]=="test")
          {

            await Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (context) => MCQTermsScreen(message.data["model_id"].toString())),
            );

          }

         else if(message.data["type"]=="news")
         {

           await Navigator.push(
             context,
             MaterialPageRoute<void>(builder: (context) => AllCoursesScreen()),
           );

         }




    });


    print("Firebase connected");
  }
}
