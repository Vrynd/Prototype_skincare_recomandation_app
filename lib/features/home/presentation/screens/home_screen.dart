import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skincare_recomendation/core/core.dart';
import 'package:skincare_recomendation/features/home/provider/date_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isScrolled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _isScrolled.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final scrolled = _scrollController.offset > 10;
    if (scrolled != _isScrolled.value) {
      _isScrolled.value = scrolled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DateProvider(),
      child: Builder(
        builder: (context) {
          final date = context.select<DateProvider, String>((p) => p.date);

          return AppScafold(
            backgroundColor: context.colors.lightBackground,
            extendBody: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80.0),
              child: ValueListenableBuilder<bool>(
                valueListenable: _isScrolled,
                builder: (context, scrolled, _) {
                  return AppHeader(
                    isScrolled: scrolled,
                    title: 'Semarang, Jawa Tengah',
                    label: date,
                    avatarUrl: 'https://i.pravatar.cc/150?img=47',
                  );
                },
              ),
            ),
            body: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                AppContainer(
                  height: 180,
                  opacity: 0.7,
                  borderRadius: AppRadius.br24,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
