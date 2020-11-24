import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cap_sahagun/providers/base.url.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

final client = Provider((ref) => Dio());

class LoginRepository {
  LoginRepository(this.client);

  final Dio client;

  getLogin({@required String email, String password}) async {
    try {
      final response = await client.post(
        "$baseUrl/auth/local",
        data: {
          "identifier": "test@gmail.com",
          "password": "123456789",
        },
      );

      if (response.statusCode == 200) {
        print(response.data);
      }

      // Auth auth = Auth.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }
}
