import 'package:client/core/shared_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:client/core/shared_widgets/app_bar.dart';
import 'package:client/core/core.dart';
import 'package:client/injection.dart';

class AppBarWidget extends StatelessWidget {
  final String message;
  final String icon;

  AppBarWidget({
    String message = '',
    String icon = ''
  }): this.message = message, this.icon = icon;

  @override
  Widget build(context) {
    bool isLoggedIn = getIt<AuthService>().currentUserDetails != null;
    return Scaffold(
        appBar: buildAppBar(
            context: context,
            title: Text(
              "S N A R K I",
              style: TextStyle(
                  fontSize: 25,
                  color: AppTheme.SnarkiTextColor,
                  fontWeight: FontWeight.bold
              ),
            ),
            automaticallyImplyLeading: true,
            actions: [
              IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    if (isLoggedIn) {
                      Navigator.of(context).pushNamed('/userProfile');
                    } else {
                      Navigator.of(context).pushNamed('/login');
                    }
                  })
            ],
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: PreferredSize(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  width: double.infinity,
                  height: 0.5,
                ),
                preferredSize: Size.fromHeight(1))),
        drawer: DrawerCustom(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              this.icon.length > 0 ?
              Image.asset(this.icon, fit: BoxFit.cover, width: 100,)
                  : CircularProgressIndicator(),
              SizedBox(
                height: 30,
              ),
              Text(
                this.message.length > 0 ?
                '${this.message}' :
                'Scanning Location Details ...',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18.0
                ),
              ),
            ],
          ),
        )
    );
  }
}