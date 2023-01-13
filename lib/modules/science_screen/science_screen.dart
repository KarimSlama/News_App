import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var scienceList = NewsCubit.getContext(context).scienceData;
        return newsArticlesBuilder(
          article: scienceList,
          isSearched: false,
        );
      },
      listener: (context, state) {},
    );
  } //end build()
} //end class
