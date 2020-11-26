import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'models/auth/auth.model.dart';
import 'providers/login_repository/login.repository.dart';

final client = Provider((_) => Dio());

final navigator = Provider((_) => GlobalKey<NavigatorState>());

final authProvider = StateProvider<bool>((_) => null);

final session = FutureProvider.autoDispose<Auth>((_) async {
  final box = await Hive.openBox<Auth>("auth");

  final isEmpty = box.isEmpty;

  if (isEmpty) return null;

  return box.get("session");
});

final loginRepository = Provider<LoginRepository>(
  (ref) => LoginRepository(
    client: ref.watch(client),
    // read: ref.read,
  ),
);

final userInfoProvider = Provider.autoDispose<Auth>((_) {
  final box = Hive.box<Auth>("auth");

  return box.get("session");
});
