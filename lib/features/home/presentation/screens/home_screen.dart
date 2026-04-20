import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isScrolled = false;

  @override
  Widget build(BuildContext context) {
    return AppScafold(
      backgroundColor: context.colors.lightBackground,
      appBar: AppHeader(
        isScrolled: _isScrolled,
        title: 'Kinara Razania',
        label: AppHelpers.getGreeting(),
        avatarUrl: 'https://i.pravatar.cc/150?img=47',
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            final double offset = notification.metrics.pixels;
            if (offset > 10 && !_isScrolled) {
              setState(() => _isScrolled = true);
            } else if (offset <= 10 && _isScrolled) {
              setState(() => _isScrolled = false);
            }
          }
          return true;
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [AppContainer(height: 200)],
        ),
      ),
    );
  }
}
