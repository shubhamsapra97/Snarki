import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:client/core/utils/appTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:client/core/shared_service/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:client/injection.dart';
import 'package:client/core/environments/environments.dart';

class DrawerCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = getIt<AuthService>().currentUserDetails != null;
    final bool trackEvents = Environments().config.trackEvents;

    return Drawer(
      elevation: 0.0,
      child: Container(
       // color: AppTheme.primaryColor.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add the rest here
            Container(
              height: 150,
              width: double.infinity,
              color: AppTheme.primaryColorDark,
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/sidebarLogo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ListTile(
                          leading: Icon(Icons.person,
                              color: Colors.black54),
                          title: Text(
                            isLoggedIn ? 'Profile' : 'Login',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          onTap: () {
                            Navigator.pop(context, true);

                            if (isLoggedIn) {
                              Navigator.of(context).pushNamed('/userProfile');
                            } else {
                              Navigator.of(context).pushNamed('/login');
                            }
                            //   Navigation.push(context, NotificationScreen());
                          },
                        )
                      ),
                      isLoggedIn ?
                        ListTile(
                          leading: Icon(Icons.lock,
                                color: Colors.black54),
                          title: Text(
                            'Change Password',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          onTap: () {
                            Navigator.pop(context, true);
                            Navigator.of(context).pushNamed('/changePassword');
                           // Navigation.push(context, MessageScreen());
                          },
                        ) : Offstage(),
                      ListTile(
                        leading: Icon(Icons.settings,
                            color: Colors.black54),
                        title: Text(
                          'Settings',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        onTap: () {
                          Navigator.pop(context, true);
                          Navigator.of(context).pushNamed('/settings');
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.verified,
                            color: Colors.black54),
                        title: Text(
                          'Privacy Policy',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        onTap: () {
                          launch('https://app.termly.io/document/privacy-policy/71bdbafc-1b12-4f0f-978a-eabe5095ea40');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.document_scanner,
                            color: Colors.black54),
                        title: Text(
                          'Terms and Conditions',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        onTap: () {
                          launch('https://app.termly.io/document/terms-of-use-for-ios-app/98b367c7-05db-4953-9fe3-49d6b15f5a3b');
                        },
                      ),
                      isLoggedIn ? Divider() : Offstage(),
                      isLoggedIn ?
                        ListTile(
                          leading: Icon(FontAwesome.sign_out,
                             color: Colors.black54),
                          title: Text(
                            'Logout',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          onTap: () async {
                            if (trackEvents) {
                              FirebaseAnalytics().logEvent(
                                name: 'user_logged_out',
                              );
                            }
                            FirebaseAuth.instance.signOut().then((value){
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/home', (Route<dynamic> route) => false);
                            });
                          },
                        ) : Offstage(),
                      SizedBox(
                        height: 16,
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Filters extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       elevation: 0.0,
//       child: Container(
//         color: AppTheme.primaryColor.withOpacity(0.2),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Add the rest here
//             Container(
//               height: 150,
//               width: double.infinity,
//               color: AppTheme.primaryTextColor,
//               child: Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(
//                     'Filters',
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.headline6.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: AppTheme.primaryColorLight,
//                         ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text(
//                           'Platform',
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context).textTheme.headline6.copyWith(
//                                 fontWeight: FontWeight.bold,
//                                 color: AppTheme.primaryTextColor,
//                               ),
//                         ),
//                       ),
//                       Divider(),
//                       ListTile(
//                         leading: Icon(FontAwesome.facebook,
//                             color: AppTheme.primaryTextColor),
//                         title: Text(
//                           'Facebook',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         leading: Icon(FontAwesome.instagram,
//                             color: AppTheme.primaryTextColor),
//                         title: Text(
//                           'Instagram',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         leading: Icon(FontAwesome.youtube,
//                             color: AppTheme.primaryTextColor),
//                         title: Text(
//                           'Youtube',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         leading: Icon(FontAwesome.snapchat,
//                             color: AppTheme.primaryTextColor),
//                         title: Text(
//                           'Snapchat',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         leading: Icon(FontAwesome.twitter,
//                             color: AppTheme.primaryTextColor),
//                         title: Text(
//                           'Snapchat',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         onTap: () {},
//                       ),
//                       Divider(),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 8),
//                         child: Text(
//                           'Location',
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context).textTheme.headline6.copyWith(
//                                 fontWeight: FontWeight.bold,
//                                 color: AppTheme.primaryTextColor,
//                               ),
//                         ),
//                       ),
//                       Divider(),
//                       ListTile(
//                         leading: Icon(FontAwesome.circle,
//                             color: AppTheme.primaryTextColor),
//                         title: Text(
//                           'No Preference',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         leading: Icon(FontAwesome.map_marker,
//                             color: AppTheme.primaryTextColor),
//                         title: Text(
//                           'Select Country',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         onTap: () {},
//                       ),
//                       Divider(),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 8),
//                         child: Text(
//                           'Bids',
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context).textTheme.headline6.copyWith(
//                                 fontWeight: FontWeight.bold,
//                                 color: AppTheme.primaryTextColor,
//                               ),
//                         ),
//                       ),
//                       Divider(),
//                       ListTile(
//                         leading: Icon(FontAwesome.arrow_circle_o_up,
//                             color: AppTheme.primaryTextColor),
//                         title: Text(
//                           'Maximum to Minimum',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         leading: Icon(FontAwesome.arrow_circle_o_down,
//                             color: AppTheme.primaryTextColor),
//                         title: Text(
//                           'Minimum to Maximum',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         onTap: () {},
//                       ),
//                       Divider(),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 8),
//                         child: Text(
//                           'Followers',
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context).textTheme.headline6.copyWith(
//                                 fontWeight: FontWeight.bold,
//                                 color: AppTheme.primaryTextColor,
//                               ),
//                         ),
//                       ),
//                       Divider(),
//                       ListTile(
//                         leading: Icon(FontAwesome.arrow_circle_o_up,
//                             color: AppTheme.primaryTextColor),
//                         title: Text(
//                           'Maximum to Minimum',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         leading: Icon(FontAwesome.arrow_circle_o_down,
//                             color: AppTheme.primaryTextColor),
//                         title: Text(
//                           'Minimum to Maximum',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         onTap: () {},
//                       ),
//                       SizedBox(
//                         height: 50,
//                       )
//                     ]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

