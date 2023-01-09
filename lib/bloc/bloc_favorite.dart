import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/model/list_restaurant/restaurant_list.dart';
import 'package:restaurant_app/model/restaurants.dart';
import 'package:restaurant_app/util/network.dart';

import '../util/db.dart';

///////////////////// EVENT /////////////////////
class FavoriteEvent {}

class FavoriteEventGet extends FavoriteEvent {}
class FavoriteEventDelete extends FavoriteEvent {
  final String id;
  FavoriteEventDelete({required this.id});
}
class FavoriteEventInsert extends FavoriteEvent {
  final Restaurants restaurants;
  FavoriteEventInsert({required this.restaurants});
}

///////////////////// STATE ///////////////////
class FavoriteState {}

class FavoriteStateLoading extends FavoriteState {}

class FavoriteStateError extends FavoriteState {}

class FavoriteStateRestaurants extends FavoriteState {
  final List<Restaurants> data;
  FavoriteStateRestaurants({required this.data});
}

///////////////////// BLoC /////////////////////
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {

  FavoriteBloc() : super(FavoriteState()) {
    on<FavoriteEventGet>((event, emit) async {
      emit(FavoriteStateLoading());
      try {
        final restaurants = await DatabaseHelper.instance.getRestaurants();
        emit(FavoriteStateRestaurants(data: restaurants));
      } on Exception {
        emit(FavoriteStateError());
      }
    });

    on<FavoriteEventDelete>((event, emit) async {
      try {
        await DatabaseHelper.instance.deleteRestaurant(event.id);
        final restaurants = await DatabaseHelper.instance.getRestaurants();
        emit(FavoriteStateRestaurants(data: restaurants));
      } on Exception {
        emit(FavoriteStateError());
      }
    });

    on<FavoriteEventInsert>((event, emit) async {
      try {
        await DatabaseHelper.instance.insertRestaurant(event.restaurants);
        final restaurants = await DatabaseHelper.instance.getRestaurants();
        emit(FavoriteStateRestaurants(data: restaurants));
      } on Exception {
        emit(FavoriteStateError());
      }
    });

    on<FavoriteEvent>((event, emit) async {
      emit(FavoriteState());
    });
  }
}
