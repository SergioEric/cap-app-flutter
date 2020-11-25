import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/all.dart';

extension NewPodContext on BuildContext {
  T readPod<T>(RootProvider<Object, T> provider) {
    return ProviderScope.containerOf(this, listen: false).read(provider);
  }

  Created refreshPod<Created>(RootProvider<Created, Object> provider) {
    return ProviderScope.containerOf(this, listen: false).refresh(provider);
  }
}
