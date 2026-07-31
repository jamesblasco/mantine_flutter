import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import '../button/close_button.dart';

Future<T?> showMantineModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  double overlayOpacity = 0.55,
  Duration transitionDuration = const Duration(milliseconds: 200),
  MantineSize size = MantineSize.md,
  bool centered = true,
  bool fullScreen = false,
  bool withCloseButton = true,
  Widget? title,
  EdgeInsetsGeometry? padding,
  MantineSize? radius,
}) {
  return Navigator.of(context, rootNavigator: true).push<T>(
    _MantineModalRoute<T>(
      builder: builder,
      barrierDismissible: barrierDismissible,
      overlayOpacity: overlayOpacity,
      transitionDuration: transitionDuration,
      size: size,
      centered: centered,
      fullScreen: fullScreen,
      withCloseButton: withCloseButton,
      title: title,
      padding: padding,
      radius: radius,
    ),
  );
}

class _MantineModalRoute<T> extends PopupRoute<T> {
  _MantineModalRoute({
    required this.builder,
    required this.barrierDismissible,
    required double overlayOpacity,
    required this.transitionDuration,
    required this.size,
    required this.centered,
    required this.fullScreen,
    required this.withCloseButton,
    required this.title,
    required this.padding,
    required this.radius,
  }) : barrierColor = Color.fromRGBO(0, 0, 0, overlayOpacity);

  final WidgetBuilder builder;
  final MantineSize size;
  final bool centered;
  final bool fullScreen;
  final bool withCloseButton;
  final Widget? title;
  final EdgeInsetsGeometry? padding;
  final MantineSize? radius;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  String? get barrierLabel => 'Dismiss';

  @override
  final Duration transitionDuration;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _MantineModalPanel(
      animation: animation,
      size: size,
      centered: centered,
      fullScreen: fullScreen,
      withCloseButton: withCloseButton,
      title: title,
      padding: padding,
      radius: radius,
      onClose: () => Navigator.of(context).pop(),
      child: builder(context),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final fade = CurvedAnimation(parent: animation, curve: Curves.easeOut);
    return FadeTransition(opacity: fade, child: child);
  }
}

class _MantineModalPanel extends StatelessWidget {
  const _MantineModalPanel({
    required this.animation,
    required this.size,
    required this.centered,
    required this.fullScreen,
    required this.withCloseButton,
    required this.title,
    required this.padding,
    required this.radius,
    required this.onClose,
    required this.child,
  });

  final Animation<double> animation;
  final MantineSize size;
  final bool centered;
  final bool fullScreen;
  final bool withCloseButton;
  final Widget? title;
  final EdgeInsetsGeometry? padding;
  final MantineSize? radius;
  final VoidCallback onClose;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    final maxWidth = switch (size) {
      MantineSize.xs => 320.0,
      MantineSize.sm => 440.0,
      MantineSize.md => 560.0,
      MantineSize.lg => 720.0,
      MantineSize.xl => 1000.0,
    };

    final resolvedRadius =
        theme.radius.resolve(radius ?? theme.defaultRadius);
    final resolvedPadding =
        padding ?? EdgeInsets.all(theme.spacing.md);

    Widget panel = KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.escape) {
          onClose();
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.mantineSurface,
          borderRadius:
              fullScreen ? BorderRadius.zero : BorderRadius.circular(resolvedRadius),
          boxShadow: theme.shadows.resolve(MantineSize.xl),
        ),
        child: Column(
          mainAxisSize: fullScreen ? MainAxisSize.max : MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null || withCloseButton)
              _ModalHeader(
                title: title,
                withCloseButton: withCloseButton,
                onClose: onClose,
                padding: resolvedPadding,
              ),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: title == null && !withCloseButton
                      ? resolvedPadding
                      : resolvedPadding.subtract(
                          const EdgeInsets.only(top: 0)),
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (!fullScreen) {
      panel = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: panel,
      );
    }

    final alignment =
        centered ? Alignment.center : Alignment.topCenter;
    final topPad = centered ? 0.0 : theme.spacing.xl * 2;

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -0.03),
        end: Offset.zero,
      ).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOut)),
      child: fullScreen
          ? panel
          : Padding(
              padding: EdgeInsets.only(
                  top: topPad, left: 16, right: 16, bottom: 16),
              child: Align(alignment: alignment, child: panel),
            ),
    );
  }
}

class _ModalHeader extends StatelessWidget {
  const _ModalHeader({
    required this.title,
    required this.withCloseButton,
    required this.onClose,
    required this.padding,
  });

  final Widget? title;
  final bool withCloseButton;
  final VoidCallback onClose;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    return Padding(
      padding: padding,
      child: Row(
        children: [
          if (title != null)
            Expanded(
              child: DefaultTextStyle.merge(
                style: theme.typography.h4.copyWith(
                  color: context.mantineBodyText,
                  fontFamily: theme.typography.fontFamily,
                ),
                child: title!,
              ),
            )
          else
            const Spacer(),
          if (withCloseButton)
            MantineCloseButton(
              onPressed: onClose,
              color: 'gray',
            ),
        ],
      ),
    );
  }
}

