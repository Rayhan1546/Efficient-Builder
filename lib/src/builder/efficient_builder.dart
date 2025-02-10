import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EfficientBuilder<T> extends StatefulWidget {
  final ValueListenable<T> valueListenable;
  final ValueWidgetBuilder<T> builder;
  final bool Function(T previous, T current)? buildWhen;
  final Widget? child;

  const EfficientBuilder({
    super.key,
    required this.valueListenable,
    required this.builder,
    this.buildWhen,
    this.child,
  });

  @override
  State<StatefulWidget> createState() => _EfficientBuilderState<T>();
}

class _EfficientBuilderState<T> extends State<EfficientBuilder<T>> {
  late T value;

  @override
  void initState() {
    super.initState();
    value = widget.valueListenable.value;
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(EfficientBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
      value = widget.valueListenable.value;
      widget.valueListenable.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    final newValue = widget.valueListenable.value;

    if (widget.buildWhen?.call(value, newValue) ?? true) {
      setState(() => value = newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value, widget.child);
  }
}
