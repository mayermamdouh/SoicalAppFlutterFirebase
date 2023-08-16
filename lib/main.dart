import 'package:chat_app/Screens/HomePages/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc_observe.dart';
import 'CacheHelper.dart';
import 'Components.dart';
import 'Screens/HomePages/HomeCubit.dart';
import 'Screens/HomePages/HomeSates.dart';
import 'loginPage/login_Pgae.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('on background Message');
  print(message.data.toString());
  showToast(text: 'on background Message', states: ToastStates.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  //Token
  var token = await FirebaseMessaging.instance.getToken();
  print('Token//////');
  print(token);

  // when click to notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('Token.......');
    print(event.data.toString());
    showToast(text: 'on Message opened app', states: ToastStates.SUCCESS);
  });
  //foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print('Token.......');
    print(event.data.toString());
    showToast(text: 'on Message', states: ToastStates.SUCCESS);
  });
  //background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await CacheHelper.init();

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = LoginPage();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => CubitApp()
            ..GetUserData()
            ..GetPosts(),
        ),
      ],
      child: BlocConsumer<CubitApp, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            // theme: ThemeData(
            //   appBarTheme: const AppBarTheme(
            //     iconTheme: IconThemeData(color: Colors.black),
            //     //color: Colors.white,
            //   ),
            // ),
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
