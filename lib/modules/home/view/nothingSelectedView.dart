import 'package:client/core/shared_widgets/button.dart';
import 'package:client/core/shared_widgets/rounded_card.dart';
import 'package:client/core/utils/appTheme.dart';
import 'package:flutter/material.dart';

class NotingSelected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

             Image.asset("assets/icon/icon.png", fit: BoxFit.cover, width: 100,),
                
              // CircleAvatar(
              //   radius: 75,
              //   child: Image.asset("assets/icon/icon.png", fit: BoxFit.cover,),
              // //  backgroundImage: AssetImage("assets/icon/icon.png", ),
              // ),
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
