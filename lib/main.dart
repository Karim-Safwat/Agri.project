import 'package:final_agriculture_project/components/constants.dart';
import 'package:final_agriculture_project/layout/cubit/cubit.dart';
import 'package:final_agriculture_project/layout/cubit/states.dart';
import 'package:final_agriculture_project/layout/home_screen.dart';
import 'package:final_agriculture_project/modules/login/Login_Screen.dart';
import 'package:final_agriculture_project/network/local/cache_helper.dart';
import 'package:final_agriculture_project/services/bluetooth_controller.dart';
import 'package:final_agriculture_project/styles/bloc/cubit.dart';
import 'package:final_agriculture_project/styles/bloc/observer.dart';
import 'package:final_agriculture_project/styles/bloc/states.dart';
import 'package:final_agriculture_project/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  var token = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  print(token);
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  //bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  uid = CacheHelper.getData(key: 'uid');
  //print(token);
  Widget widget;
  if (uid != null) {
    widget = LayoutScreen();
  } else {
    widget = LoginScreen();
  }

  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget = const ShopLayoutScreen();
  //   } else {
  //     widget = const LoginScreen();
  //   }
  // } else {
  //   widget = const OnBoardingScreen();
  // }
  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  final bool? isDark;
  const MyApp({this.startWidget, this.isDark, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProjectCubit()..GetUserData(),
        ),
        BlocProvider(
          create: (context) => AppThemeModeCubit()
            ..changeAppThemeMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<AppThemeModeCubit, AppThemeModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: AppThemeModeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
