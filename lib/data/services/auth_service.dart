import 'dart:io';

import 'package:findmitter_frontend/data/services/data_service.dart';
import 'package:findmitter_frontend/domain/models/push_token.dart';
import 'package:findmitter_frontend/domain/repository/api_repository.dart';
import 'package:findmitter_frontend/internal/config/shared_prefs.dart';
import 'package:findmitter_frontend/internal/config/token_storage.dart';
import 'package:findmitter_frontend/internal/dependencies/repository_module.dart';
import 'package:findmitter_frontend/internal/utils.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthService {
  final ApiRepository _api = RepositoryModule.apiRepository();
  final DataService _dataService = DataService();

  Future auth(String? login, String? password) async {
    if (login != null && password != null) {
      try {
        var token = await _api.getToken(login: login, password: password);
        if (token != null) {
          await TokenStorage.setStoredToken(token);
          var user = await _api.getUser();
          if (user != null) {
            SharedPrefs.setStoredUser(user);
          }
        }
      } on DioError catch (e) {
        if (e.error is SocketException) {
          throw NoNetworkException();
        } else if (<int>[401].contains(e.response?.statusCode)) {
          throw WrongCredentionalException();
        } else if (<int>[500].contains(e.response?.statusCode)) {
          throw ServerException();
        }
      }
    }
  }

  Future<bool> checkAuth() async {
    var res = false;

    if (await TokenStorage.getAccessToken() != null) {
      var user = await _api.getUser();

      if (user != null) {
        var token = await FirebaseMessaging.instance.getToken();
        if (token != null) await _api.subscribe(PushToken(token: token));
        await SharedPrefs.setStoredUser(user);
        await _dataService.cuUser(user);
      }

      res = true;
    }

    return res;
  }

  Future cleanToken() async {
    await TokenStorage.setStoredToken(null);
  }

  Future logout() async {
    try {
      await _api.unsubscribe();
    } on Exception catch (e, _) {
      e.toString().console();
    }
    await cleanToken();
  }
}

class WrongCredentionalException implements Exception {}

class NoNetworkException implements Exception {}

class ServerException implements Exception {}
