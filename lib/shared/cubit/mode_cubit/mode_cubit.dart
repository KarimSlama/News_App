import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/mode_cubit/mode_states.dart';
import 'package:news_app/shared/data/local/cache_helper.dart';

class ModeCubit extends Cubit<ModeStates> {
  ModeCubit() : super(ModeInitialState());

  static ModeCubit getContext(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      // when fromShared not equal null it means you choice light or dark
      isDark = fromShared;
    } else {
      // you not choice anything
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ModeChangeState());
      });
    } //end else
  } //end changeMode()
} //end class
