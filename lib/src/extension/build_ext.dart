import 'package:efficient_builder/src/builder/efficient_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension BuildExtension<T> on ValueListenable<T> {
  Widget build({
    bool Function(T previous, T current)? buildWhen,
    required Widget Function(BuildContext context, T value) builder,
    Key? key,
  }) {
    return EfficientBuilder<T>(
      key: key,
      valueListenable: this,
      buildWhen: buildWhen,
      builder: (context, value, _) => builder(context, value),
    );
  }
}
