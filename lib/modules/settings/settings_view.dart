import 'package:client/modules/profile/change_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:client/core/shared_service/auth_service.dart';
import 'package:client/modules/locationPicker/location_picker_view.dart';
import 'package:client/core/shared_widgets/Tile/SettingsTile.dart';
import 'package:client/core/core.dart';
import 'package:client/injection.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsView extends StatefulWidget {
  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<SettingsView> {
  bool isLoggedIn = getIt<AuthService>().currentUserDetails != null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        automaticallyImplyLeading: true,
        backgroundColor: AppTheme.primaryBackgroundColor,
        title: Text(
          "S N A R K I",
          style: TextStyle(
              color: AppTheme.primaryColorLight,
              fontWeight: FontWeight.w900
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context, true);
            }),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SettingsGroup(
            title: 'Geo settings',
            children: <Widget>[
              SliderSettingsTile(
                title: 'Restaurant Search Radius (miles)',
                settingKey: 'radius',
                defaultValue: 5.round().toDouble(),
                min: 1,
                max: 100,
                leading: Icon(FontAwesome.globe),
              ),
              SimpleSettingsTile(
                leading: Icon(Icons.location_pin),
                title: 'Location',
                subtitle: 'Update your location',
                child: LocationPickerView(
                    arguments: {
                      'fetchLocation': false,
                      'drawerRequired': false
                    }),
              )
            ],
          ),
          isLoggedIn ? SettingsGroup(
            title: 'Account',
            children: <Widget>[
              SimpleSettingsTile(
                  leading: Icon(Icons.lock),
                  title: 'Password',
                  subtitle: 'Change Password',
                  child: ChangePassword()
              ),
              SettingsTile(
                leading: Icons.delete_forever,
                onPressed: () async {
                  var response = await getIt<DialogService>().showDialog(
                      title: "Are you sure you want to remove this Account?",
                      description: "On clicking Confirm, you will lose all your data and access to all the account functionalities.",
                      buttonTitle: "Confirm",
                      cancelTitle: "Cancel"
                  );

                  if (response.confirmed) {
                    await getIt<AuthService>().removeUserAccount();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', (Route<dynamic> route) => false);
                  }
                },
                title: 'Delete Account',
                subtitle: 'Delete Snarki Account',
              )
            ],
          ) : Offstage(),
        ],
      ),
    );
  }
}
