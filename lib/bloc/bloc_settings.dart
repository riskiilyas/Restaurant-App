import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/background_service.dart';
import '../util/date_time_helper.dart';

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

  Future<SharedPreferences> getPref() async {
    pref ??= await SharedPreferences.getInstance();
    return pref!;
  }

  SettingBloc() : super(SettingState()) {
    on<SettingEventSwitch>((event, emit) async {
      var prefs = await getPref();

      try {
        prefs.setBool('isOn', event.isOn);
        if (event.isOn) {
          await AndroidAlarmManager.periodic(
            const Duration(hours: 24),
            1,
            BackgroundService.callback,
            startAt: DateTimeHelper.format(),
            exact: true,
            wakeup: true,
          );
        } else {
          await AndroidAlarmManager.cancel(1);
        }
        emit(SettingStateSwitch(isOn: event.isOn));
      } on Exception {
        emit(SettingStateError());
      }
    });

    on<SettingsEvent>((even, emit) async {
      var prefs = await getPref();

      try {
        final bool? isOn = prefs.getBool('isOn');
        if (isOn == null) throw Exception();
        emit(SettingStateSwitch(isOn: isOn));
      } on Exception {
        emit(SettingStateError());
      }
    });
  }
}
