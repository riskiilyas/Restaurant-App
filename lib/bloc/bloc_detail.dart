import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/model/detail_restaurant/restaurant_detail.dart';
import 'package:restaurant_app/model/list_restaurant/restaurant_list.dart';
import 'package:restaurant_app/util/network.dart';
import '../model/search_restaurant/restaurant_search.dart';

///////////////////// EVENT /////////////////////
class RestaurantEvent {}
class RestaurantEventDetail extends RestaurantEvent {
  final String id;
  RestaurantEventDetail({required this.id});
}

///////////////////// STATE ///////////////////
class RestaurantStateDetail {}
class RestaurantStateDetailLoading extends RestaurantStateDetail {}
class RestaurantStateDetailError extends RestaurantStateDetail {
  final String? msg;
  RestaurantStateDetailError({this.msg});
}
class RestaurantStateDetailSuccess extends RestaurantStateDetail {
  final RestaurantDetail data;
  RestaurantStateDetailSuccess({required this.data});
}

///////////////////// BLoC /////////////////////
class RestaurantDetailBloc extends Bloc<RestaurantEvent, RestaurantStateDetail> {
  final network = Network();

  RestaurantDetailBloc(): super(RestaurantStateDetailLoading()) {

    on<RestaurantEventDetail> ((event, emit) async {
      emit(RestaurantStateDetailLoading());
      try {
        final model = await network.getDetail(event.id);
        if(model.error) {
          emit(RestaurantStateDetailError(msg: model.message));
        } else {
          emit(RestaurantStateDetailSuccess(data: model));
        }
      } on Exception catch (e) {
        emit(RestaurantStateDetailError(msg: e.toString()));
      }
    });

  }
}
