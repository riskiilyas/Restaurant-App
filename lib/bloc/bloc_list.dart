import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/model/detail_restaurant/restaurant_detail.dart';
import 'package:restaurant_app/model/list_restaurant/restaurant_list.dart';
import 'package:restaurant_app/util/network.dart';
import '../model/search_restaurant/restaurant_search.dart';

///////////////////// EVENT /////////////////////
class RestaurantEvent {}
class RestaurantEventList extends RestaurantEvent {}

///////////////////// STATE ///////////////////
class RestaurantStateList {}
class RestaurantStateListLoading extends RestaurantStateList {}
class RestaurantStateListError extends RestaurantStateList {
  final String? msg;
  RestaurantStateListError({this.msg});
}
class RestaurantStateListSuccess extends RestaurantStateList {
  final RestaurantList data;
  RestaurantStateListSuccess({required this.data});
}

///////////////////// BLoC /////////////////////
class RestaurantListBloc extends Bloc<RestaurantEvent, RestaurantStateList> {
  final network = Network();

  RestaurantListBloc(): super(RestaurantStateListLoading()) {
    on<RestaurantEventList>((event, emit) async {
      emit(RestaurantStateListLoading());
      try {
        final model = await network.getList();
        if(model.error) {
          emit(RestaurantStateListError(msg: model.message));
        } else {
          emit(RestaurantStateListSuccess(data: model));
        }
      } on Exception catch (e) {
        emit(RestaurantStateListError(msg: e.toString()));
      }
    });
  }
}
