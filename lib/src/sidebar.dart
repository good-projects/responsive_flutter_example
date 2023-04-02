import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
    this.navigator,
  });

  /// The nested navigator.
  final GlobalKey<NavigatorState>? navigator;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: const [
                    SizedBox(width: 16),
                    CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    SizedBox(width: 16),
                    Text('User Name'),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  if (Scaffold.of(context).isDrawerOpen) {
                    Navigator.of(context).pop();
                  }

                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamed('settings');
                },
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView(
              children: ['', '1', '2']
                  .map(
                    (categoryId) => ListTile(
                      title: Text(categoryId.isEmpty
                          ? 'All Articles'
                          : 'Category $categoryId'),
                      onTap: () {
                        final navigatorState =
                            navigator?.currentState ?? Navigator.of(context);
                        navigatorState.pushNamedAndRemoveUntil(
                          'categories',
                          (_) => false,
                          arguments: categoryId,
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
