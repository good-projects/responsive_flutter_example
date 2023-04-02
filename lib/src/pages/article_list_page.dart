import 'package:flutter/material.dart';

import '../config.dart';
import '../sidebar.dart';
import '../helpers.dart';

const _dummyArticles = [
  "10 Simple Tips for Improving Your Mental Health",
  "How to Get Started with Meditation: A Beginner's Guide",
  "The Benefits of Regular Exercise for Your Physical and Mental Health",
  "How to Build a Successful Career in Tech: Insights from Top Industry Leaders",
  "Exploring the Best Destinations for Solo Travelers",
  "A Comprehensive Guide to Building a Successful Startup",
  "The Future of Artificial Intelligence: Trends and Implications for Business",
  "How to Stay Productive and Focused While Working from Home",
  "The Importance of Diversity and Inclusion in the Workplace",
  "Understanding Blockchain Technology: A Beginner's Guide",
  "The Role of Social Media in Today's Society: Trends and Challenges",
  "The Power of Positive Thinking: Strategies for Building Resilience and Overcoming Adversity",
  "Exploring the Best Foods for Boosting Your Immune System",
  "The Science of Sleep: Strategies for Better Rest and Recovery",
  "The Benefits of Learning a New Language: Opportunities and Challenges",
  "The Impact of Climate Change on Our Planet: A Call to Action",
  "How to Build Strong and Lasting Relationships: Insights from Relationship Experts",
  "The Role of Artificial Intelligence in Transforming Healthcare",
  "The Best Strategies for Saving Money and Building Wealth",
  "Navigating the Digital Age: Tips for Maintaining Your Privacy and Security Online",
];

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({
    super.key,
    required this.categoryId,
  });

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    final isBigScreen = context.isBigScreen();
    final titleText =
        categoryId.isEmpty ? 'All Articles' : 'Category $categoryId';

    final id = categoryId.isEmpty ? 0 : int.parse(categoryId);
    final articles = categoryId.isEmpty
        ? _dummyArticles
        : _dummyArticles.getRange((id - 1) * 10, id * 10);

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(RouteNames.create);
            },
          ),
        ],
      ),
      drawer: isBigScreen ? null : const Drawer(child: Sidebar()),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, index) {
          final article = articles.elementAt(index);
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(article),
            onTap: () {
              Navigator.of(context).pushNamed(
                RouteNames.articles,
                arguments: _dummyArticles.indexOf(article).toString(),
              );
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: articles.length,
      ),
    );
  }
}
