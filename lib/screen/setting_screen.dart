import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/bloc_settings.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<SettingBloc>(context);
    bloc.add(SettingsEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Allow Notification',
                    style: TextStyle(fontSize: 20),
                  ),
                  BlocBuilder(
                      bloc: bloc,
                      builder: (context, state) {
                        return Switch(
                            value: (state is SettingStateSwitch)
                                ? state.isOn
                                : false,
                            onChanged: (isOn) {
                              bloc.add(SettingEventSwitch(isOn: isOn));
                            });
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
