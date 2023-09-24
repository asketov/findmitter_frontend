import 'dart:io';

import 'package:findmitter_frontend/data/clients/api_client.dart';
import 'package:findmitter_frontend/data/clients/auth_client.dart';
import 'package:findmitter_frontend/domain/models/post_model.dart';
import 'package:findmitter_frontend/domain/models/push_token.dart';
import 'package:findmitter_frontend/domain/models/refresh_token_request.dart';
import 'package:findmitter_frontend/domain/models/token_request.dart';
import 'package:findmitter_frontend/domain/models/token_response.dart';
import 'package:findmitter_frontend/domain/models/user.dart';
import 'package:findmitter_frontend/domain/repository/api_repository.dart';

import '../../domain/models/attach_meta.dart';

class ApiDataRepository extends ApiRepository {
  final AuthClient _auth;
  final ApiClient _api;
  ApiDataRepository(this._auth, this._api);

  @override
  Future<TokenResponse?> getToken({
    required String login,
    required String password,
  }) async {
    return await _auth.getToken(TokenRequest(
      login: login,
      pass: password,
    ));
  }

  @override
  Future<TokenResponse?> refreshToken(String refreshToken) async =>
      await _auth.refreshToken(RefreshTokenRequest(
        refreshToken: refreshToken,
      ));

  @override
  Future<User?> getUser() => _api.getUser();

  @override
  Future<List<PostModel>> getPosts(int skip, int take) =>
      _api.getPosts(skip, take);

  @override
  Future<List<AttachMeta>> uploadTemp({required List<File> files}) =>
      _api.uploadTemp(files: files);

  @override
  Future addAvatarToUser(AttachMeta model) => _api.addAvatarToUser(model);

  @override
  Future subscribe(PushToken model) => _api.subscribe(model);

  @override
  Future unsubscribe() => _api.unsubscribe();
}
