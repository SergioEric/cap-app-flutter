import 'package:cap_sahagun/models/auth/auth.model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cap_sahagun/providers/base.url.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../global.providers.dart';

class LoginRepository {
  LoginRepository({
    Dio client,
    Reader read,
  })  :
        // : assert(client != null && read != null),
        _client = client,
        _read = read;

  final Dio _client;
  final Reader _read;

  Future<Auth> getLogin(
      {@required String email, @required String password}) async {
    try {
      final response = await _client.post(
        "$baseUrl/auth/local",
        data: {
          "identifier": "test@gmail.co",
          "password": "123456789",
        },
      );

      if (response.statusCode == 200) {
        print(response.data);
        _read(authProvider).state = true;
        return Auth.fromMap(response.data);
      }
      if (response.statusCode == 400) {
        print(response.data);
      }
    } on DioError catch (e) {
      throw Exception(e.message);
      // print(e.response);
    } catch (e) {
      throw Exception(e.message);
    }

    return null;
  }
}

// class MyLoginNotifier extends StateNotifier<AsyncValue<Auth>> {
//   final Dio _client;

//   MyLoginNotifier(this._client) : super(const AsyncValue.loading()) {
//     // _fetchData();
//   }

//   Future<void> fetchData(String email, String password) async {
//     state = const AsyncValue.loading();
//     // does the try/catch for us like previously
//     state = await AsyncValue.guard(() async {
//       final response = await _client.post(
//         "$baseUrl/auth/local",
//         data: {
//           "identifier": "test@gmail.com",
//           "password": "123456789",
//         },
//       );
//       return Auth.fromJson(response.data);
//     });
//   }
// }
