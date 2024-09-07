import 'package:flutter/material.dart';
import 'package:mobile_top_up/services/top_up/top_up_manager.dart';

class TopUpManagerProvider extends InheritedWidget {
  final TopUpManager topUpManager;

  const TopUpManagerProvider({
    super.key,
    required super.child,
    required this.topUpManager,
  });

  static TopUpManager of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<TopUpManagerProvider>();
    assert(result != null, 'No TopUpManager found in context');
    return result!.topUpManager;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
