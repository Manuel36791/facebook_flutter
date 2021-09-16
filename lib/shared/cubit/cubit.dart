import 'package:bloc/bloc.dart';
import 'package:facebook_flutter/models/post_model.dart';
import 'package:facebook_flutter/shared/components/constants.dart';
import 'package:facebook_flutter/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<PostModel> postFetch = [];

  Future<void> getPosts() async {
    emit(AppLoadingDataState());
    await Future.delayed(const Duration(milliseconds: 2000), () {})
        .then((value) {
      postFetch = List.from(posts);
    });

    emit(AppSuccsessDataState());
  }
}
