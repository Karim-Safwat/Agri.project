

import 'package:final_agriculture_project/network/local/cache_helper.dart';
import 'package:final_agriculture_project/styles/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeModeCubit extends Cubit<AppThemeModeStates>
{
  AppThemeModeCubit() : super(AppThemeInitialModeState());

  static AppThemeModeCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  void changeAppThemeMode({bool? fromShared})
  {
    if(fromShared != null)
    {
      isDark = fromShared;
      emit(AppThemeChangeModeState());
    }else{
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value)
      {
        emit(AppThemeChangeModeState());
      });
    }
  }

}