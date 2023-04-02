import 'package:flutter/material.dart';
import 'helpers.dart';
import 'route.dart';
import 'sidebar.dart';

class MainBody extends StatefulWidget {
  const MainBody({
    super.key,
    required this.routeName,
  });

  final String routeName;

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final isBigScreen = context.isBigScreen();

    final subNavigator = Navigator(
      key: _navigatorKey,
      initialRoute: widget.routeName,
      onGenerateRoute: onGenerateMainRoute,
    );

    return Scaffold(
        body: isBigScreen
            ? Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: Sidebar(
                      navigator: _navigatorKey,
                    ),
                  ),
                  const VerticalDivider(width: 1, thickness: 0.5),
                  Expanded(
                    child: subNavigator,
                  ),
                ],
              )
            : subNavigator);
  }
}
