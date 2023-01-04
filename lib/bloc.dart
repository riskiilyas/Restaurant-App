import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/data.dart';

///////////////////// EVENT /////////////////////
class RestaurantEvent {}
class RestaurantEventList extends RestaurantEvent {}
class RestaurantEventDetail extends RestaurantEvent {
  final String name;
  RestaurantEventDetail({required this.name});
}

///////////////////// STATE ///////////////////
class RestaurantState {}
class RestaurantStateLoading extends RestaurantState {}
class RestaurantStateError extends RestaurantState {
  final String? msg;
  RestaurantStateError({this.msg});
}
class RestaurantStateList extends RestaurantState {
  final Data data;
  RestaurantStateList({required this.data});
}
class RestaurantStateDetail extends RestaurantState {

}

///////////////////// BLoC /////////////////////
// class FactBloc extends Bloc<RestaurantEvent, RestaurantState> {
//   final network = ServiceLocator.getFactNetwork();
//
//   FactBloc(): super(RestaurantStateLoading()) {
//     on<RestaurantEventList>((event, emit) async {
//       emit(RestaurantStateLoading());
//       try {
//         final model = await network.getFact(event.number, event.type);
//         emit(RestaurantStateList(model: FactModel(model)));
//       } on Exception catch (e) {
//         emit(RestaurantStateError(msg: e.toString()));
//       }
//     });
//
//     on<RestaurantEventDetail> ((event, emit) async {
//       emit(RestaurantStateLoading());
//       try {
//         final model = await network.getFactDate(event.month, event.day);
//         emit(RestaurantStateDetail(model: model));
//       } on Exception catch (e) {
//         emit(RestaurantStateError(msg: e.toString()));
//       }
//     });
//   }
// }
