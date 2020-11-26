// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cap_sahagun/models/exceptions/exception.model.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import 'package:cap_sahagun/helpers/helpers.dart';
import 'package:cap_sahagun/providers/base.url.dart';
import 'package:cap_sahagun/models/auth/auth.model.dart';
// import '../../global.providers.dart';

class LoginRepository {
  LoginRepository({
    @required Dio client,
    // Reader read,
  })  : assert(client != null),
        _client = client;
  // _read = read;

  final Dio _client;
  // final Reader _read;

  Future<Auth> getLogin({String email, String password}) async {
    try {
      final response = await _client.post(
        "$baseUrl/auth/local",
        data: {
          "identifier": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        Auth auth = Auth.fromMap(response.data);
        print(response.data);
        // _read(authProvider).state = true;
        var box = Hive.box<Auth>("auth");
        box.put("session", auth);

        return auth;
      }
      print(response);
      // if (response.statusCode == 400) {
      //   print(response.data);
      // }
    } on DioError catch (e) {
      // print(e.response.toString());
      throw CleanException(
        CleanExeptionModel.fromJson(e.response.toString())
            .message
            .first
            .messages[0]
            .message,
      );
    } catch (e) {
      throw CleanException(e.message);
    }

    return null;
  }

  Future<void> logOut() async {
    var box = Hive.box<Auth>("auth");

    await box.clear();
  }
}
