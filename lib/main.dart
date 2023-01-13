import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/home_layout.dart';
import 'package:news_app/shared/cubit/mode_cubit/mode_cubit.dart';
import 'package:news_app/shared/cubit/mode_cubit/mode_states.dart';
import 'package:news_app/shared/cubit/observer.dart';
import 'package:news_app/shared/data/local/cache_helper.dart';
import 'package:news_app/shared/data/network/dio_helper.dart';

import 'shared/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(
    isDark: isDark,
  ));
} //end main()

class MyApp extends StatelessWidget {
  bool? isDark;

  MyApp({this.isDark, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getSportsData()
            ..getBusinessData()
            ..getScienceData(),
        ),
        BlocProvider(
            create: (context) => ModeCubit()..changeMode(fromShared: isDark)),
      ],
      child: BlocConsumer<ModeCubit, ModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.deepOrange,
              appBarTheme: const AppBarTheme(
                color: Colors.white,
                titleSpacing: 16.0,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black26,
                  size: 30.0,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                unselectedItemColor: Colors.black26,
                selectedItemColor: Colors.deepOrange,
                elevation: 50.0,
                type: BottomNavigationBarType.fixed,
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: const AppBarTheme(
                  titleSpacing: 16.0,
                  backgroundColor: Colors.black,
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                      statusBarIconBrightness: Brightness.light)),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.black,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.white24,
              ),
            ),
            themeMode: ModeCubit.getContext(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const HomeLayout(),
          );
        },
      ),
    );
  } //end build()
} //end class
