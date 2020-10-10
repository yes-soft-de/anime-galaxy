import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/utils/logger/logger.dart';

@provide
class ApiClient {
  Dio _client;
  final Logger _logger;

  final String tag = 'ApiClient';

  ApiClient(this._logger) {
    _client = new Dio(BaseOptions(connectTimeout: 3000, receiveTimeout: 6000));
    _client.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
  }

  Future<Map<String, dynamic>> get(String url,
      {Map<String, String> queryParams}) async {
    _logger.info(tag, 'GET $url');
    try {
      Response response = await _client.get(
        url,
        queryParameters: queryParams,
        options: buildCacheOptions(Duration(seconds: 15)),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _logger.info(tag, response.data.toString());
        return response.data;
      } else {
        _logger.error(tag, response.statusCode.toString() + ' for link ' + url);
        await Fluttertoast.showToast(
            msg: 'Error Code ' +
                response.statusCode.toString() +
                ' Please Retry',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } catch (e) {
      _logger.error(tag, e.toString());
      await Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> payLoad) async {
    try {
      _logger.info(tag, 'Requesting Post to: ' + url);
      _logger.info(tag, 'POST: ' + jsonEncode(payLoad));
      Response response = await _client.post(url, data: json.encode(payLoad));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _logger.info(tag, response.data.toString());
        return response.data;
      } else {
        _logger.error(tag, response.statusCode.toString());
        _logger.error(tag, response.data.toString());
        return null;
      }
    } catch (e) {
      _logger.error(tag, e.toString());
      await Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>> put(
      String url, Map<String, dynamic> payLoad) async {
    try {
      _logger.info(tag, 'Requesting Put to: ' + url);
      _logger.info(tag, 'PUT: ' + jsonEncode(payLoad));
      var response = await _client.put(url, data: json.encode(payLoad));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _logger.info(tag, response.data.toString());
        return response.data;
      } else {
        _logger.error(tag, response.statusCode.toString());
        return null;
      }
    } catch (e) {
      _logger.error(tag, e.toString());
      await Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }
}
