import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/widgets/app_toast.dart';

class AppToastOverlay extends StatefulWidget {
  final String message;
  final AppToastVariant variant;
  final VoidCallback onDismiss;

  const AppToastOverlay({
    super.key,
    required this.message,
    required this.variant,
    required this.onDismiss,
  });

  @override
  State<AppToastOverlay> createState() => _AppToastOverlayState();
}

class _AppToastOverlayState extends State<AppToastOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _fadeAnimation;
  bool _isDismissed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0, -1.5), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeInBack,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  void _dismiss() async {
    if (_isDismissed) return;
    _isDismissed = true;
    await _controller.reverse();
    if (mounted) {
      widget.onDismiss();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: SlideTransition(
            position: _offsetAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: _dismiss,
                  child: AppToast(
                    message: widget.message,
                    variant: widget.variant,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
