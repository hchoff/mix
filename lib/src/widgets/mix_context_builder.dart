import 'package:flutter/material.dart';

import '../../mix.dart';
import '../factory/mix_provider.dart';

typedef WidgetMixBuilder = Widget Function(
  MixData mix,
);

class MixBuilder extends StyledWidget {
  const MixBuilder({
    @Deprecated('Use the style parameter instead') super.mix,
    super.style,
    super.variants,
    super.key,
    required WidgetMixBuilder builder,
  }) : _builder = builder;

  final WidgetMixBuilder _builder;

  @override
  Widget build(BuildContext context) {
    final mix = createMixData(context);

    return MixProvider(
      mix,
      child: Builder(
        builder: (context) => _builder(mix),
      ),
    );
  }
}
