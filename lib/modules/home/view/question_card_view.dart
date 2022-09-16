import 'package:client/core/core.dart';
import 'package:client/core/shared_widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:client/core/shared_service/auth_service.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:client/injection.dart';
import 'nothingSelectedView.dart';

class QuestionCardView extends StatefulWidget {
  @override
  _QuestionCardViewState createState() => _QuestionCardViewState();
}

class _QuestionCardViewState extends State<QuestionCardView>
    with TickerProviderStateMixin {
  List<QuestionModel> questions = [];
  int _totalSwipes = 0;
  List<String> _selectedCuisineTags = [];

  @override
  void initState() {
    super.initState();
    questions = allQuestions;
    questions.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.
    bool isLoggedIn = getIt<AuthService>().currentUserDetails != null;

    //
    //
    // PREVENT USER FROM GOING BACK FROM THIS SCREEN
    //

    return new Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: buildAppBar(
          context: context,
          title: Text(
            "Snarki",
            style: TextStyle(color: AppTheme.primaryColorDark),
          ),
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  if (isLoggedIn) {
                    Navigator.pushNamed(context, '/userProfile');
                  } else {
                    Navigator.pushNamed(context, '/login');
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: AutoSizeText(
                  'Select 3 cusines you like to eat',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Colors.black54,
                  ),
                  maxLines: 1,
                )
            ),
            SizedBox(
              height: 8,
            ),
            Text("Selected ${_selectedCuisineTags.length} of 3".toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.blue, fontWeight: FontWeight.bold)),

            SizedBox(
              height: 32,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: new TinderSwapCard(
                swipeUp: false,
                swipeDown: false,
                orientation: AmassOrientation.BOTTOM,
                totalNum: questions.length,
                stackNum: 3,
                swipeEdge: 4.0,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.height,
                minWidth: MediaQuery.of(context).size.width * 0.8,
                minHeight: MediaQuery.of(context).size.height * 0.9,
                cardBuilder: (context, index) => Card(
                  elevation: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: double.infinity,
                              child: Image.asset(
                                '${questions[index].imagePath}',
                                fit: BoxFit.cover,
                              ))),
                      new Expanded(
                        child: Center(
                          child: Text(
                          questions[index]
                              .toString()
                              .replaceAll("&amp;", "and"),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                        )),
                      ),
                    ],
                  ),
                ),
                cardController: controller = CardController(),
                swipeUpdateCallback:
                    (DragUpdateDetails details, Alignment align) {
                  /// Get swiping card's alignment
                  if (align.x < 0) {
                    //Card is LEFT swiping

                  } else if (align.x > 0) {
                    //Card is RIGHT swiping
                  }
                },
                swipeCompleteCallback:
                    (CardSwipeOrientation orientation, int index) async {
                  /// Get orientation & index of swiped card!

                  if (index >= 35) {
                    if (_selectedCuisineTags.length > 0) {
                      Navigator.of(context).pushNamed(
                          '/restaurantListView',
                          arguments: _selectedCuisineTags
                      );
                    }
                    if (_selectedCuisineTags.length == 0) {
                      await showDialog(context: context,
                        builder: (ctx) => NotingSelected(),
                      );
                      Navigator.of(context).pushNamed('/home');
                    }
                  }

                  if (orientation.index == 1) {
                    // Right Swap

                    setState(() {
                      _totalSwipes = _totalSwipes + 1;
                      _selectedCuisineTags.add(questions[index].cuisineTag);
                    });

                    if (_totalSwipes > 2) {
                      Navigator.of(context).pushNamed(
                          '/restaurantListView',
                        arguments: _selectedCuisineTags
                      );
                    }
                  }
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButtonCustom(
                    child: Row(
                      children: [
                        Icon(
                          AntDesign.close,
                          color: Colors.red,
                        ),
                        Text(
                          " No",
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                    borderRadius: 100,
                    btnColor: Colors.black.withOpacity(0.05),
                    onPressed: () {
                      controller.triggerLeft();
                    },
                  ),
                  RaisedButtonCustom(
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        Text(
                          " Yes",
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                    borderRadius: 100,
                    btnColor: Colors.black.withOpacity(0.05),
                    onPressed: () {
                      controller.triggerRight();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
