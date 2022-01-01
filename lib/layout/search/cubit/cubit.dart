import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/layout/search/cubit/states.dart';
import 'package:shoppy/models/searchmodel.dart';
import 'package:shoppy/shared/components/components.dart';
import 'package:shoppy/shared/network/end_points.dart';
import 'package:shoppy/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit():super (SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel model;

  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH,token: token, data: {
      'text':text
    }).then((value) {
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((onError){
      emit(SearchErrorState());
      print(onError.toString());
      });
  }
}