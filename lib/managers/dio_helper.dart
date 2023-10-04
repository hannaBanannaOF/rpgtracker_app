import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rpgtracker_app/constants/endpoints.dart';
import 'package:rpgtracker_app/managers/preferences.dart';
import 'package:rpgtracker_app/managers/get_it_helper.dart';
import 'package:rpgtracker_app/managers/session_manager.dart';

class DioClient {
  DioClient._();
  static final DioClient instance = DioClient._();

  static RestClientDio? _client;
  Future<RestClientDio> get client async {
    return _client ??= await _build();
  }

  Future<RestClientDio> _build() async {
    var client = RestClientDio();

    client.preferences = await Preferences.instance;
    client.accessToken = client.preferences.getAccessToken();
    client.refreshToken = client.preferences.getRefreshToken();

    // Autenticador url
    client._authDio.options.baseUrl = Endpoints.keycloakBaseUrl;
    client._authDio.options.contentType = ContentType.json.value;

    // Backend url
    client._clientDio.options.baseUrl = Endpoints.rpgtrackerBaseUrl;
    await client.loadInterceptors();

    return client;
  }
}

class RestClientDio {
  final Dio _clientDio = Dio();
  final Dio _authDio = Dio();

  late String? accessToken;
  late String? refreshToken;
  late Preferences preferences;

  String? _hAuthorization;

  Future loadInterceptors() async {
    _clientDio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        _hAuthorization = 'Bearer $accessToken';
        options.headers[Headers.contentTypeHeader] = Headers.jsonContentType;
        options.headers['Authorization'] = _hAuthorization;

        return handler.next(options);
      },
      onError: _refreshToken,
    ));
  }

  void _refreshToken(error, handler) {
    // https://github.com/flutterchina/dio/blob/master/example/lib/queued_interceptor_crsftoken.dart
    if (error.response?.statusCode == HttpStatus.unauthorized) {
      var options = error.response!.requestOptions;

      // If the token has been updated, repeat directly.
      if (_hAuthorization != options.headers['Authorization']) {
        options.headers['Authorization'] = _hAuthorization;

        //repeat
        _repeatRequest(options, handler);
        return;
      }

      debugPrint('Refresh token...');

      _authDio
          .post(Endpoints.keycloakTokenEndpoint,
              data: {
                'grant_type': 'refresh_token',
                'client_id': 'rpgtracker',
                'refresh_token': refreshToken,
              },
              options: Options(contentType: Headers.formUrlEncodedContentType))
          .then((response) {
        if (response.statusCode == 200) {
          accessToken = response.data['access_token'];
          refreshToken = response.data['refresh_token'];
          preferences.setAccessToken(accessToken!);
          preferences.setRefreshToken(refreshToken!);
          _hAuthorization = 'Bearer $accessToken';
          options.headers['Authorization'] = _hAuthorization;
        } else {
          getIt<SessionManager>().signOut();
        }
      }).catchError((e, t) {
        getIt<SessionManager>().signOut();
      }).then((_) {
        _repeatRequest(options, handler);
      });
      return;
    }

    handler.next(error);
  }

  void _repeatRequest(RequestOptions options, handler) {
    debugPrint('Repeat request...');
    _clientDio.fetch(options).then(
      (r) => handler.resolve(r),
      onError: (e) {
        handler.reject(e);
      },
    );
  }

  Future<Response<dynamic>> get(String endpoint,
      {CancelToken? cancelToken, ResponseType? responseType}) async {
    var options =
        Options(headers: {Headers.contentTypeHeader: Headers.jsonContentType});

    if (responseType != null) {
      options.responseType = responseType;
    }

    try {
      var response = await _clientDio.get(endpoint,
          cancelToken: cancelToken, options: options);

      return response;
    } on DioException catch (e, t) {
      return await onDioError(e, t);
    }
  }

  Future<Response<dynamic>> post(String endpoint,
      {dynamic body,
      CancelToken? cancelToken,
      ResponseType? responseType}) async {
    var options =
        Options(headers: {Headers.contentTypeHeader: Headers.jsonContentType});

    if (responseType != null) {
      options.responseType = responseType;
    }

    try {
      var response = await _clientDio.post(endpoint,
          data: body, cancelToken: cancelToken, options: options);

      return response;
    } on DioException catch (e, t) {
      return await onDioError(e, t);
    }
  }

  Future<Response<dynamic>> put(String endpoint, {body}) async {
    var options =
        Options(headers: {Headers.contentTypeHeader: Headers.jsonContentType});

    try {
      var response =
          await _clientDio.put(endpoint, data: body, options: options);

      return response;
    } on DioException catch (e, t) {
      return await onDioError(e, t);
    }
  }

  Future<Response<dynamic>> delete(String endpoint, {body}) async {
    var options =
        Options(headers: {Headers.contentTypeHeader: Headers.jsonContentType});

    try {
      var response =
          await _clientDio.delete(endpoint, data: body, options: options);

      return response;
    } on DioException catch (e, t) {
      return await onDioError(e, t);
    }
  }

  dynamic onDioError(e, t) async {
    throw (e);
  }
}
