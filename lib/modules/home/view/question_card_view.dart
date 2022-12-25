import 'package:client/core/core.dart';
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
  List<bool> _selectedQuestionView = <bool>[];
  List<bool> _selectedListCuisines = <bool>[];

  List<Widget> icons = <Widget>[
    Icon(Icons.image),
    Icon(Icons.list_sharp),
  ];

  @override
  void initState() {
    super.initState();
    questions = allQuestions;
    questions.shuffle();
    _selectedQuestionView = <bool>[true, false];
    _selectedListCuisines = <bool>[...List.filled(allQuestions.length, false)];
  }

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.
    bool isLoggedIn = getIt<AuthService>().currentUserDetails != null;

    //
    // TODO: PREVENT USER FROM GOING BACK FROM THIS SCREEN
    //

    Widget _cardView() {
      return Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: AutoSizeText(
                'Swipe 3 cusines you would like to eat',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.primaryColorLight.withOpacity(0.9),
                ),
                maxLines: 1,
              )
          ),
          SizedBox(
            height: 4,
          ),
          Text("${_selectedCuisineTags.length} / 3".toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 16,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
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
                color: AppTheme.primaryBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: double.infinity,
                            child: Image.asset(
                              '${questions[index].imagePath}',
                              fit: BoxFit.cover,
                            ))),

                    new Expanded(
                      child: Container(
                        color: AppTheme.primaryBackgroundColor,
                        child: Center(
                            child: Text(
                              questions[index]
                                  .toString()
                                  .replaceAll("&amp;", "and"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600
                              ),
                            )),
                      ),
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
                  borderColor: Color(0xffaaa6bd),
                  child: Row(
                    children: [
                      Icon(
                        AntDesign.close,
                        color: Colors.red,
                      ),
                      Text(
                        " No",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  borderRadius: 100,
                  btnColor: AppTheme.primaryBackgroundColor.withOpacity(0.05),
                  onPressed: () {
                    controller.triggerLeft();
                  },
                ),
                RaisedButtonCustom(
                  borderColor: Color(0xffaaa6bd),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      Text(
                        " Yes",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  borderRadius: 100,
                  btnColor: AppTheme.primaryBackgroundColor.withOpacity(0.05),
                  onPressed: () {
                    controller.triggerRight();
                  },
                )
              ],
            ),
          ),
        ],
      );
    }

    Widget _listView() {
      return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 40),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: AutoSizeText(
                  'Tap 3 cusines you would like to eat',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.primaryColorLight.withOpacity(0.9),
                  ),
                  maxLines: 1,
                )
            ),
            SizedBox(
              height: 4,
            ),
            Text("${_selectedCuisineTags.length} / 3".toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 40,
            ),
            Column(
              children: questions.map((question) {
                return new GestureDetector(
                  onTap: () {
                    var index = questions.indexOf(question);

                    setState(() {
                      _selectedListCuisines[index] = !_selectedListCuisines[index];
                      _selectedListCuisines[index] ?
                        _selectedCuisineTags.add(questions[index].cuisineTag)
                        : _selectedCuisineTags.remove(questions[index].cuisineTag);
                      _totalSwipes = _selectedListCuisines[index] ? _totalSwipes+1 : _totalSwipes-1;
                    });

                    if (_totalSwipes > 2) {
                      Navigator.of(context).pushNamed(
                          '/restaurantListView',
                          arguments: _selectedCuisineTags
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _selectedListCuisines[questions.indexOf(question)] ? AppTheme.primaryColorLight : Colors.grey.withOpacity(0.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: new AssetImage(question.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            question.cuisineTag,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight:FontWeight.w700
                            ),
                          ),
                          _selectedListCuisines[questions.indexOf(question)] ?
                            Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 35,
                            ) : Offstage()
                        ],
                      ),
                    )
                  ),
                );
              }).toList(),
            )
          ],
        ),
      );
    }

    return new Scaffold(
        backgroundColor: AppTheme.primaryBackgroundColor,
        resizeToAvoidBottomInset : false,
        appBar: buildAppBar(
            context: context,
            title: Text(
              "S N A R K I",
              style: TextStyle(
                  color: AppTheme.primaryColorLight,
                  fontWeight: FontWeight.w900
              ),
            ),
            automaticallyImplyLeading: true,
            actions: [
              IconButton(
                  icon: Icon(Icons.person),
                  color: Colors.white,
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
            iconThemeData: IconThemeData(color: Colors.white),
        ),
        drawer: DrawerCustom(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      questions.shuffle();
                      setState(() {
                        for (int i = 0; i < _selectedQuestionView.length; i++) {
                          _selectedQuestionView[i] = i == index;
                        }
                        setState(() {
                          _totalSwipes = 0;
                          _selectedCuisineTags = [];
                          _selectedListCuisines = [...List.filled(allQuestions.length, false)];
                        });
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.grey[700],
                    selectedColor: Colors.grey[200],
                    fillColor: AppTheme.primaryColorLight,
                    color: Colors.grey[600],
                    isSelected: _selectedQuestionView,
                    children: icons,
                  ),
                ),
              ),
              _selectedQuestionView[0] ? _cardView() : _listView(),
            ],
          ),
        )
    );
  }
}
