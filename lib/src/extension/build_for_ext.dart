import 'package:efficient_builder/src/builder/efficient_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension BuildForExtension<T> on ValueListenable<T> {
  Widget buildFor<R>({
    required R Function(T state) select,
    required Widget Function(BuildContext context, T state) builder,
    Key? key,
  }) {
    return EfficientBuilder<T>(
      key: key,
      valueListenable: this,
      buildWhen: (previous, current) => select(previous) != select(current),
      builder: (context, state, _) => builder(context, state),
    );
  }
}
