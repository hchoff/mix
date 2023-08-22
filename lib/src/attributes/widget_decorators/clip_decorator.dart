import 'package:flutter/material.dart';
import 'package:mix/src/attributes/common/attribute.dart';
import 'package:mix/src/mixer/mix_context.dart';

/// @nodoc
enum ClipDecoratorType {
  triangle,
  rect,
  rounded,
  oval,
}

/// ## Widget
/// - (All)
/// ## Utilities
/// - [ClipDecoratorUtility](ClipDecoratorUtility-class.html)
///
/// {@category Decorators}
class ClipDecorator extends ParentDecorator<ClipDecorator> {
  final BorderRadius? borderRadius;
  final ClipDecoratorType clipType;

  const ClipDecorator(
    this.clipType, {
    this.borderRadius,
  }) : super(const Key('ClipDecorator'));

  @override
  ClipDecorator merge(ClipDecorator other) {
    return other;
  }

  @override
  Widget render(MixContext mixContext, Widget child) {
    final shared = mixContext.sharedProps;

    if (clipType == ClipDecoratorType.triangle) {
      return ClipPath(
        clipper: TriangleClipper(),
        child: child,
      );
    }

    if (clipType == ClipDecoratorType.rect) {
      return ClipRect(
        child: child,
      );
    }

    if (clipType == ClipDecoratorType.rounded) {
      if (shared.animated) {
        return AnimatedClipRRect(
          duration: shared.animationDuration,
          curve: shared.animationCurve,
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          child: child,
        );
      } else {
        return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          child: child,
        );
      }
    }

    if (clipType == ClipDecoratorType.oval) {
      return ClipOval(
        child: child,
      );
    }

    throw Exception('Unknown clip type: $clipType');
  }
}

/// @nodoc
class AnimatedClipRRect extends StatelessWidget {
  const AnimatedClipRRect({
    required this.duration,
    this.curve = Curves.linear,
    required this.borderRadius,
    required this.child,
    Key? key,
  }) : super(key: key);

  final Duration duration;
  final Curve curve;
  final BorderRadius borderRadius;
  final Widget child;

  static Widget _builder(
    BuildContext context,
    BorderRadius radius,
    Widget? child,
  ) {
    return ClipRRect(borderRadius: radius, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<BorderRadius>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: BorderRadius.zero, end: borderRadius),
      builder: _builder,
      child: child,
    );
  }
}

/// @nodoc
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
