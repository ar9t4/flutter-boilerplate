import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/model/data/local/async_response.dart';
import 'package:flutter_boilerplate/remote/dio_service.dart';
import 'package:flutter_boilerplate/remote/end_points.dart';

import '../model/data/remote/user.dart';

class UsersProvider extends ChangeNotifier {
  AsyncResponse<List<User>>? asyncResponse;

  void fetchUsers({bool onRefresh = false}) async {
    if (asyncResponse == null ||
        asyncResponse?.data == null ||
        asyncResponse?.data?.isEmpty == true ||
        onRefresh) {
      try {
        // show loader
        asyncResponse = AsyncResponse(loading: true);
        notifyListeners();
        final dio = DioService().dio;
        final response =
            await dio.get(EndPoints.baseUrl, queryParameters: {'results': 20});
        // hide loader
        asyncResponse = AsyncResponse(loading: false);
        notifyListeners();
        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! <= 300) {
          if (response.data['results'] != null) {
            final users = <User>[];
            response.data['results']
                .forEach((e) => users.add(User.fromJson(e)));
            // show data
            asyncResponse = AsyncResponse(data: users);
            notifyListeners();
          }
        } else {
          // show error
          asyncResponse = AsyncResponse(error: 'Something went wrong');
          notifyListeners();
        }
      } catch (exception) {
        log('error fetching users: $exception');
        // show error
        asyncResponse = AsyncResponse(error: exception.toString());
        notifyListeners();
      }
    }
  }
}
