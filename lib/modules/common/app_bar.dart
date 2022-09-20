import 'package:client/core/shared_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:client/core/shared_widgets/app_bar.dart';
import 'package:client/core/core.dart';
import 'package:client/injection.dart';

class AppBarWidget extends StatelessWidget {
  final String message;
  final String icon;
  final bool drawerRequired;

  AppBarWidget({
    String message = '',
    String icon = '',
    bool drawerRequired = true
  }): this.message = message, this.icon = icon, this.drawerRequired = drawerRequired;

  @override
  Widget build(context) {
    bool isLoggedIn = getIt<AuthService>().currentUserDetails != null;
    return Scaffold(
        appBar: buildAppBar(
            backgroundColor: AppTheme.primaryBackgroundColor,
            context: context,
            title: Text(
              "S N A R K I",
              style: TextStyle(
                  color: AppTheme.primaryColorLight,
                  fontWeight: FontWeight.w900
              ),
            ),
            iconThemeData: IconThemeData(color: Colors.white),
            automaticallyImplyLeading: true,
            actions: [
              IconButton(
                  icon: Icon(Icons.person),
                  color: Colors.white,
                  onPressed: () {
                    if (isLoggedIn) {
                      Navigator.of(context).pushNamed('/userProfile');
                    } else {
                      Navigator.of(context).pushNamed('/login');
                    }
                  })
            ],
            centerTitle: true,
            elevation: 0,
            leading: !drawerRequired ? IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context, true);
                }) : null,
            bottom: PreferredSize(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  width: double.infinity,
                  height: 0.5,
                ),
                preferredSize: Size.fromHeight(1))),
        drawer: drawerRequired ? DrawerCustom() : null,
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