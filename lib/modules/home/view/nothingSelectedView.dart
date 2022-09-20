import 'package:client/core/shared_widgets/button.dart';
import 'package:client/core/core.dart';
import 'package:client/core/utils/appTheme.dart';
import 'package:flutter/material.dart';

class NotingSelected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0,
        iconThemeData: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             Image.asset("assets/icon/icon.png", fit: BoxFit.cover, width: 100,),
              SizedBox(
                height: 70,
              ),
              Text("Hey, you have Selected",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 8,
              ),
              Text("No",
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: AppTheme.primaryColorLight,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 8,
              ),
              Text("cuisines.",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 16,
              ),
              Text("Please, Try again with selections!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2),
              SizedBox(
                height: 50,
              ),
              RaisedButtonCustom(
                btnColor: AppTheme.primaryColorLight,
                onPressed: () {
                  Navigator.pop(context, true);
                },
                btnText: "Ok",
              )
            ],
          ),
        ),
      ),
    );
  }
}
