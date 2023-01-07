
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

///////////////////// EVENT /////////////////////
class SettingsEvent {}

class SettingEventSwitch extends SettingsEvent {
  final bool isOn;
  SettingEventSwitch({required this.isOn});
}

///////////////////// STATE ///////////////////
class SettingState {}

class SettingStateSwitch extends SettingState {
  final bool isOn;
  SettingStateSwitch({required this.isOn});
}
class SettingStateError extends SettingState {}

///////////////////// BLoC /////////////////////
class SettingBloc extends Bloc<SettingsEvent, SettingState> {
  SharedPreferences? pref;

  Future<SharedPreferences> getPref() async{
    pref ??= await SharedPreferences.getInstance();
    return pref!;
  }

  SettingBloc() : super(SettingState()) {
    on<SettingEventSwitch>((event, emit) async {
      var prefs = await getPref();

      try {
        prefs.setBool('isOn', event.isOn);
        emit(SettingStateSwitch(isOn: event.isOn));
      } on Exception catch (e){
        emit(SettingStateError());
      }
    });

    on<SettingsEvent>((even, emit) async {
      var prefs = await getPref();

      try {
        final bool? isOn = prefs.getBool('isFirstLaunch');
        if(isOn==null) throw Exception();
        emit(SettingStateSwitch(isOn: isOn));
      } on Exception catch (e){
        emit(SettingStateError());
      }
    });
  }
}
