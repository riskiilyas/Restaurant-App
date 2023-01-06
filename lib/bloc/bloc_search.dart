import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/util/network.dart';
import '../model/search_restaurant/restaurant_search.dart';

///////////////////// EVENT /////////////////////
class RestaurantEvent {}

class RestaurantEventSearch extends RestaurantEvent {
  final String query;

  RestaurantEventSearch({required this.query});
}

///////////////////// STATE ///////////////////
class RestaurantStateSearch {}

class RestaurantStateSearchLoading extends RestaurantStateSearch {}

class RestaurantStateSearchError extends RestaurantStateSearch {
  final String? msg;

  RestaurantStateSearchError({this.msg});
}

class RestaurantStateSearchSuccess extends RestaurantStateSearch {
  final SearchRestaurant data;

  RestaurantStateSearchSuccess({required this.data});
}

///////////////////// BLoC /////////////////////
class RestaurantSearchBloc
    extends Bloc<RestaurantEvent, RestaurantStateSearch> {
  final network = Network();

  RestaurantSearchBloc() : super(RestaurantStateSearch()) {
    on<RestaurantEventSearch>((event, emit) async {
      emit(RestaurantStateSearchLoading());
      try {
        final model = await network.getSearch(event.query);
        if (model.error) {
          emit(RestaurantStateSearchError());
        } else {
          emit(RestaurantStateSearchSuccess(data: model));
        }
      } on Exception catch (e) {
        emit(RestaurantStateSearchError(msg: e.toString()));
      }
    });
  }
}
