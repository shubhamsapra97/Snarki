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
        title: Text(
          "Settings",
          style: TextStyle(color: AppTheme.primaryColorDark),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: 0.5,
          ),
          preferredSize: Size.fromHeight(1),
        ),
      ),
      body: Column(
        children: [
          isLoggedIn ?
            SimpleSettingsTile(
                leading: Icon(Icons.lock),
                title: 'Account',
                subtitle: 'Change Password',
                child: ChangePassword()
            ) : Offstage(),
          SettingsGroup(
            title: 'Geo settings',
            children: <Widget>[
              SliderSettingsTile(
                title: 'Restaurant Search Radius (miles)',
                settingKey: 'radius',
                defaultValue: 5.round().toDouble(),
                min: 1,
                max: 100,
                leading: Icon(FontAwesome.globe)
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
          isLoggedIn ?
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
                  }
                },
                title: 'Delete Account',
                subtitle: 'Delete Snarki Account',
            ) : Offstage(),
        ],
      ),
    );
  }
}
