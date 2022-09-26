import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
SearchModel? model;
  void search(String txt) {
    emit(GetSearchDataLoading());

    DioHelper.postData(
        url: SEARCH,
        data: {
          'text': txt,
        },
      token: token,
    ).then((value) {
      model=SearchModel(value.data);
      emit(GetSearchDataSuccess());
    }).catchError((error){
      emit(GetSearchDataError());
    });
  }
}
