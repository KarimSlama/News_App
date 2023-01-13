abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavigationState extends NewsStates {}

//businessData
class NewsGetBusinessDataLoading extends NewsStates {}

class NewsGetBusinessDataSuccessState extends NewsStates {}

class NewsGetBusinessDataErrorState extends NewsStates {
  final String error;

  NewsGetBusinessDataErrorState(this.error);
}

//sportData
class NewsGetSportsDataLoading extends NewsStates {}

class NewsGetSportsDataSuccessState extends NewsStates {}

class NewsGetSportsDataErrorState extends NewsStates {
  final String error;

  NewsGetSportsDataErrorState(this.error);
}

//scienceData
class NewsGetScienceDataLoading extends NewsStates {}

class NewsGetScienceDataSuccessState extends NewsStates {}

class NewsGetScienceDataErrorState extends NewsStates {
  final String error;

  NewsGetScienceDataErrorState(this.error);
}

//scienceData
class NewsSearchDataLoading extends NewsStates {}

class NewsSearchDataSuccessState extends NewsStates {}

class NewsSearchDataErrorState extends NewsStates {
  final String error;

  NewsSearchDataErrorState(this.error);
}
