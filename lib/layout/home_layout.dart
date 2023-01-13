import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search_screen/search_screen.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/mode_cubit/mode_cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit newsCubit = NewsCubit.getContext(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              newsCubit.screensTitles[newsCubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ));
                },
                icon: const Icon(Icons.search_rounded),
              ),
              IconButton(
                onPressed: () {
                  ModeCubit.getContext(context).changeMode();
                },
                icon: const Icon(Icons.light_mode_rounded),
              ),
            ],
          ),
          body: newsCubit.screens[newsCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: newsCubit.currentIndex,
            onTap: (value) {
              newsCubit.changeBottomNavigation(value);
            },
            items: newsCubit.bottomNavigationItem,
          ),
        );
      },
    );
  } //end build()
} //end class
