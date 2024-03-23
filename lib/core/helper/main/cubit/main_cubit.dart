import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cache/cache_helper.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  void changeLang() {
    emit(ChangeLangState());
  }

  String? language;

  void changeAppLang({
    String? fromSharedLang,
    String? langMode,
  }) {
    if (fromSharedLang != null) {
      language = fromSharedLang;
      emit(AppChangeModeState());
    } else {
      language = langMode;
      CacheHelper.saveData(
        key: 'language',
        value: langMode!,
      ).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
