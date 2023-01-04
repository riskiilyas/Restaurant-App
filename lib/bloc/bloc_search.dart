import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/model/detail_restaurant/restaurant_detail.dart';
import 'package:restaurant_app/model/list_restaurant/restaurant_list.dart';
import 'package:restaurant_app/network.dart';
import '../data/data.dart';
import '../model/search_restaurant/restaurant_search.dart';

///////////////////// EVENT /////////////////////
class RestaurantEvent {}
class RestaurantEventSearch extends RestaurantEvent {
  final String query;
  RestaurantEventSearch({required this.query});
}

///////////////////// STATE ///////////////////
class RestaurantState {}
class RestaurantStateLoading extends RestaurantState {}
class RestaurantStateError extends RestaurantState {
  final String? msg;
  RestaurantStateError({this.msg});
}
class RestaurantStateSearch extends RestaurantState {
  final SearchRestaurant data;
  RestaurantStateSearch({required this.data});
}

///////////////////// BLoC /////////////////////
class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final network = Network();

  RestaurantBloc(): super(RestaurantStateLoading()) {
    on<RestaurantEventSearch>((event, emit) async {
      emit(RestaurantStateLoading());
      try {
        final model = await network.getSearch(event.query);
        if(model.error) {
          emit(RestaurantStateError());
        } else {
          emit(RestaurantStateSearch(data: model));
        }
      } on Exception catch (e) {
        emit(RestaurantStateError(msg: e.toString()));
      }
    });
  }
}
