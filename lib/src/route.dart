import 'package:flutter/material.dart';
import 'pages/create_page.dart';
import 'pages/article_list_page.dart';
import 'pages/article_detail_page.dart';
import 'main_body.dart';
import 'pages/settings_page.dart';
import 'config.dart';

/// For the app's root navigator.
Route<dynamic> onGenerateRootRoute(RouteSettings settings) {
  late Widget page;
  final path = settings.name;

  if (path == RouteNames.articles || path == RouteNames.categories) {
    page = MainBody(routeName: path!);
  } else if (path == RouteNames.settings) {
    page = const SettingsPage();
  } else {
    throw Exception('Unknown route: ${settings.name}');
  }

  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
}

/// For the nested navigator in [MainBody] widget.
Route<dynamic> onGenerateMainRoute(RouteSettings settings) {
  final path = settings.name;

  if (path == 'create') {
    return _SlideLeftPageRoute(
      builder: (context) => const CreatePage(),
      settings: settings,
    );
  } else if (path == RouteNames.categories) {
    return _FadePageRoute(
      builder: (context) => ArticleListPage(
        categoryId: (settings.arguments as String?) ?? '',
      ),
      settings: settings,
    );
  } else if (path == RouteNames.articles) {
    return _SlideLeftPageRoute(
      builder: (context) => ArticleDetailPage(
        articleId: (settings.arguments as String?) ?? '',
      ),
      settings: settings,
    );
  } else {
    throw Exception('Unknown sub route: ${settings.name}');
  }
}

/// MaterialPageRoute with slide left transition.
class _SlideLeftPageRoute<T> extends MaterialPageRoute<T> {
  _SlideLeftPageRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.ease,
        )),
        child: child,
      );
}

/// MaterialPageRoute with fade transition.
class _FadePageRoute<T> extends MaterialPageRoute<T> {
  _FadePageRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> _,
    Widget child,
  ) =>
      FadeTransition(
        opacity: animation,
        child: child,
      );
}
