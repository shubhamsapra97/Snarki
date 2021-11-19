
import 'package:flutter/material.dart';


PreferredSizeWidget buildAppBar({
    @required BuildContext? context,
    Widget? title,
    List<Widget> actions = const [],
    bool centerTitle= false,
    Widget? leading,
    IconThemeData? iconThemeData,
    Color? backgroundColor,
    bool automaticallyImplyLeading = false,
    double elevation = 4.0,
    PreferredSizeWidget? bottom
}) {
    return  PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
            elevation: elevation,
            backgroundColor: backgroundColor,
            title: title,
            centerTitle: centerTitle,
            leading: leading,
            iconTheme: iconThemeData != null && context != null ? iconThemeData : Theme.of(context!).iconTheme,
            actionsIconTheme: Theme.of(context).iconTheme,
            automaticallyImplyLeading: automaticallyImplyLeading,
            bottom: bottom,
            actions: actions
        ),
    );
}
