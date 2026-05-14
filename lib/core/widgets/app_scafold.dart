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
  final Color? bodyBackgroundColor;
  final bool isFullScreen;
  final bool isBalanced;
  final int headerFlex;
  final int bodyFlex;
  final Brightness statusBarIconBrightness;
  final bool showHandle;

  const AppScafold({
    super.key,
    this.header,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.bodyBackgroundColor,
    this.isFullScreen = false,
    this.isBalanced = false,
    this.headerFlex = 2,
    this.bodyFlex = 8,
    this.statusBarIconBrightness = Brightness.dark,
    this.showHandle = false,
  });

  double _getRatio() =>
      isBalanced ? (headerFlex / (headerFlex + bodyFlex)) : 0.4;

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
    WidgetsBinding.instance.addPostFrameCallback((_) => _sytemUIOverlay());

    return Scaffold(
      backgroundColor: backgroundColor ?? context.colors.primary.withValues(alpha: 0.8),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height * _getRatio()) + 20,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: context.colors.primary),
            child: Stack(
              children: [
                // Layer Dekorasi 1 (Luar - Presisi Corner)
                Positioned(
                  top: -110,
                  right: -120,
                  child: Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: .08),
                    ),
                  ),
                ),
                // Layer Dekorasi 2 (Dalam - Presisi Corner)
                Positioned(
                  top: -60,
                  right: -60,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: .12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            spacing: isBalanced ? 0 : 2,
            children: [
              if (header != null)
                isBalanced
                    ? Expanded(flex: headerFlex, child: header!)
                    : header!,

              Expanded(
                flex: isBalanced ? bodyFlex : 1,
                child: AppContainer(
                  color: bodyBackgroundColor ?? context.colors.lightBackground,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  padding: EdgeInsets.zero,
                  showBorder: false,
                  showShadow: false,
                  child: Column(
                    children: [
                      if (showHandle) _buildHandle(context),
                      Expanded(child: body),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12, bottom: 12),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: context.colors.outline.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
