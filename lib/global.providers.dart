import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'models/auth/auth.model.dart';

final client = Provider((_) => Dio());

final navigator = Provider((_) => GlobalKey<NavigatorState>());

final authProvider = StateProvider<bool>((_) => null);

final session = FutureProvider.autoDispose<Auth>((_) async {
  final box = await Hive.openBox<Auth>("auth");

  final isEmpty = box.isEmpty;

  if (isEmpty) return null;

  return box.values.first;
});
