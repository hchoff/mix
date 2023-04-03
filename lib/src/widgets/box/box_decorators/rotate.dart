import 'package:flutter/material.dart';

import '../../../factory/mix_provider_data.dart';
import '../box.decorator.dart';

class RotateDecorator extends WidgetDecorator<RotateDecorator> {
  final int quarterTurns;
  const RotateDecorator({
    required this.quarterTurns,
    super.key,
  });

  @override
  RotateDecorator merge(RotateDecorator other) {
    return RotateDecorator(
      quarterTurns: other.quarterTurns,
    );
  }

  @override
  Widget build(MixData mix, Widget child) {
    return RotatedBox(
      key: key,
      quarterTurns: quarterTurns,
      child: child,
    );
  }

  @override
  get props => [quarterTurns];
}
