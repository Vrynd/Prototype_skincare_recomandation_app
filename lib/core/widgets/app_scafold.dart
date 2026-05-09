import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';

class AppScafold extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool isFullScreen;
  final Brightness statusBarIconBrightness;

  const AppScafold({
    super.key,
    this.header,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.isFullScreen = false,
    this.statusBarIconBrightness = Brightness.dark,
  });

  void _sytemUIOverlay() {
    if (isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: statusBarIconBrightness,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: statusBarIconBrightness,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _sytemUIOverlay();

    return Scaffold(
      backgroundColor: backgroundColor ?? const Color(0xFF0D1B0E),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF3D6A56),
                  Color(0xFF234433),
                  Color(0xFF0D1B0E),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (header != null) header!,

              const SizedBox(height: 4),

              Expanded(
                child: AppContainer(
                  color: context.colors.lightBackground,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                  padding: EdgeInsets.zero,
                  showBorder: false,
                  showShadow: false,
                  child: body,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
