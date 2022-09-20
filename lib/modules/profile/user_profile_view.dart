import 'package:client/core/core.dart';
import 'package:client/core/shared_service/auth_service.dart';
import 'package:client/core/shared_widgets/info_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:client/injection.dart';

class UserProfileView extends StatelessWidget {
  final currentUser = getIt<AuthService>().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(height: 0.0),
      appBar: buildAppBar(
        context: context,
        backgroundColor: AppTheme.primaryBackgroundColor,
        automaticallyImplyLeading: true,
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
        bottom: PreferredSize(
          child: Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: 0.5,
          ),
          preferredSize: Size.fromHeight(1),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Widget>[
          //     // Padding(
          //     //   padding: const EdgeInsets.only(left: 28.0, top: 7.0),
          //     //   child: CircleAvatar(
          //     //     radius: 44,
          //     //     backgroundImage: currentUser.photoUrl.isEmpty ?  NetworkImage(imageUrl) :  NetworkImage(currentUser.photoUrl),
          //     //   ),
          //     // ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 38.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Text(
          //             currentUser.name.toUpperCase(),
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .headline5
          //                 ,
          //           ),

          //           // Padding(
          //           //   padding: const EdgeInsets.only(top: 8.0),
          //           //   child: Row(
          //           //     crossAxisAlignment: CrossAxisAlignment.center,
          //           //     children: <Widget>[
          //           //       Icon(Icons.location_on,
          //           //           color: Colors.white, size: 17),
          //           //       Padding(
          //           //         padding: const EdgeInsets.only(left: 5.0),
          //           //         child: Text(
          //           //           currentUser.address.toUpperCase(),
          //           //           style: TextStyle(
          //           //             color: Colors.white,
          //           //           ),
          //           //         ),
          //           //       )
          //           //     ],
          //           //   ),
          //           // )
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 40.0),
              child: Column(
                children: <Widget>[
                  InfoSection(
                    icon: Icons.person,
                    titleColor: Colors.black54,
                    title: "Name",
                    value: Text(currentUser!.name!,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w400,
                            )),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InfoSection(
                    icon: Icons.email,
                    titleColor: Colors.black54,
                    title: "Email",
                    value: Text(currentUser!.email!,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w400,
                            )),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
