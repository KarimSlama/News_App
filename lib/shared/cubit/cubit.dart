import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen/business_screen.dart';
import 'package:news_app/modules/science_screen/science_screen.dart';
import 'package:news_app/modules/sports_screen/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/data/network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavigationItem = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball_outlined), label: 'sports'),
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center_outlined), label: 'business'),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined), label: 'science'),
  ];

  List<Widget> screens = const [
    SportsScreen(),
    BusinessScreen(),
    ScienceScreen(),
  ];

  List<String> screensTitles = [
    'Sports',
    'Business',
    'Science',
  ];

  List<dynamic> businessData = [];
  List<dynamic> sportsData = [];
  List<dynamic> scienceData = [];

  List<dynamic> searchList = [];

  static NewsCubit getContext(context) => BlocProvider.of(context);

  void changeBottomNavigation(int index) {
    currentIndex = index;
    if (index == 1)
      getBusinessData();
    else if (index == 2) getScienceData();
    emit(NewsBottomNavigationState());
  } //end changeBottomNavigation()

  void getBusinessData() {
    emit(NewsGetBusinessDataLoading());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'apiKey': '403faeb012a64cdcac453e2d167ff56a',
      'category': 'business',
    }).then((value) {
      // print(value.data['articles'][0]['source']['name'].toString());
      businessData = value.data['articles'];
      print(businessData[0]['title']);
      emit(NewsGetBusinessDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessDataErrorState('I think that the error is: $error'));
    });
  }

  void getSportsData() {
    emit(NewsGetSportsDataLoading());

    if (sportsData.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'apiKey': '403faeb012a64cdcac453e2d167ff56a',
        'category': 'sport',
      }).then((value) {
        sportsData = value.data['articles'];
        print(sportsData[0]['title']);
        emit(NewsGetSportsDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsDataErrorState('I think that the error is: $error'));
      });
    } else
      emit(NewsGetSportsDataSuccessState());
  } //end getSportsData()

  void getScienceData() {
    emit(NewsGetScienceDataLoading());
    if (scienceData.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'apiKey': '403faeb012a64cdcac453e2d167ff56a',
        'category': 'science',
      }).then((value) {
        scienceData = value.data['articles'];
        print(scienceData[0]['title']);
        emit(NewsGetScienceDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceDataErrorState('I think that the error is: $error'));
      });
    } else
      emit(NewsGetScienceDataSuccessState());
  } //end getScienceData()

  void searchData(String value) {
    emit(NewsSearchDataLoading());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': '403faeb012a64cdcac453e2d167ff56a',
    }).then((value) {
      searchList = value.data['articles'];
      print(searchList[0]['title']);
      emit(NewsSearchDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSearchDataErrorState('I think that the error is: $error'));
    });
  } //end getSportsData()

} //end class
