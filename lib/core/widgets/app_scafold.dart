import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';

class AppScafold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final bool isFullScreen;
  final bool extendBody;
  final Color? backgroundColor;
  final Widget? background;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const AppScafold({
    super.key,
    this.appBar,
    required this.body,
    this.isFullScreen = false,
    this.extendBody = false,
    this.backgroundColor,
    this.background,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  void _sytemUIOverlay() {
    if (isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _sytemUIOverlay();

    final scaffold = Scaffold(
      backgroundColor: background != null ? Colors.transparent : backgroundColor,
      extendBody: extendBody,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );

    if (background != null) {
      return Material(
        color: context.colors.surface,
        child: Stack(
          children: [
            Positioned.fill(child: background!),
            scaffold,
          ],
        ),
      );
    }

    return scaffold;
  }
}
