// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'base_url_utils.dart';
import 'log_utils.dart';

class ApiServices {
  static var client = http.Client();
  static final String _url = BaseUrl().getUrlDevice(); //base url rdl

  static Map<String, String> _setHeaders() {
    return {
      'app-id': '6624afe5bb0b39f737b34e87',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static Future getData(String endpoint) async {
    var response =
        await client.get(Uri.parse("$_url/$endpoint"), headers: _setHeaders());
    try {
      log("response getdata: ${response.body}");
      if (response.statusCode > 499) {
        log(response.body);
        var message = json.decode(response.body);
        return Future.error(message);
      }
      return json.decode(response.body);
    } catch (e) {
      debugPrint("error getData -> $e");
      return null;
    }
  }

  static Future<dynamic> postData(
    String endpoint,
    Map<String, dynamic> params,
  ) async {
    try {
      var response = await client.post(Uri.parse("$_url/$endpoint"),
          headers: _setHeaders(), body: jsonEncode(params));
      // if (response.statusCode == 400) {
      //   return Future.error(code400 ?? '');
      // }
      log("gagal ${response.statusCode}: ${params}");

      LogUtil().debug(response.body);
      if (response.statusCode > 499) {
        return Future.error("Error occured, please try again later!");
      }
      LogUtil().debug(response.body);

      return json.decode(response.body);
    } catch (e) {
      log("error post : $e");
      debugPrint("error post data -> $e");
    }
  }

  static Future<dynamic> postDataPath(
    String endpoint,
    Map<String, dynamic> params,
  ) async {
    try {
      var response = await client.post(Uri.parse("$_url/$endpoint"),
          headers: _setHeaders(), body: json.encode(params));
      // if (response.statusCode == 400) {
      //   return Future.error(code400 ?? '');
      // }

      LogUtil().debug(response.body);
      if (response.statusCode > 499) {
        return Future.error("Error occured, please try again later!");
      }
      // LogUtil().debug(response.body);

      return json.decode(response.body);
    } catch (e) {
      log("error post : $e");
      debugPrint("error post data -> $e");
    }
  }

  static Future<dynamic> postDataWithoutBody(
    String endpoint,
  ) async {
    try {
      var response = await client.post(Uri.parse("$_url/$endpoint"),
          headers: _setHeaders(), body: json.encode({}));
      // if (response.statusCode == 400) {
      //   return Future.error(code400 ?? '');
      // }

      LogUtil().debug(response.body);
      if (response.statusCode > 499) {
        return Future.error("Error occured, please try again later!");
      }
      LogUtil().debug(response.body);

      return json.decode(response.body);
    } catch (e) {
      log("error post : $e");
      debugPrint("error post data -> $e");
    }
  }

  static Future deleteData(String endpoint) async {
    var response = await client.delete(Uri.parse("$_url/$endpoint"),
        headers: _setHeaders());

    LogUtil().debug(response.body);
    return json.decode(response.body);
  }

  static Future logoutData(String endpoint) async {
    var response = await client.delete(Uri.parse("$_url/$endpoint"),
        headers: _setHeaders());

    LogUtil().debug(response.body);
  }

  static Future putData(String endpoint, Map<String, dynamic> params) async {
    var response = await client.put(Uri.parse("$_url/$endpoint"),
        headers: _setHeaders(), body: json.encode(params));
    log("response put data: ${response.statusCode}");
    if (response.statusCode > 499) {
      return Future.error("Error occured, please try again later!");
    }

    LogUtil().debug(response.body);
    return json.decode(response.body);
  }

  static Future<dynamic> postFile(
    String endpoint,
    String? imagePath,
    Map<String, dynamic>? otherParams, {
    String keyPhoto = 'signature',
  }) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse("$_url/$endpoint"));

      request.headers["Accept"] = 'application/json';

      otherParams?.forEach((key, value) {
        request.fields[key] = value;
      });

      request.files
          .add(await http.MultipartFile.fromPath(keyPhoto, imagePath ?? "-"));

      var rsp = await http.Response.fromStream(await request.send());
      log("response file: ${rsp.statusCode} ${rsp.body}");
      return json.decode(rsp.body);
    } on Exception catch (e) {
      LogUtil().errors("$e");
      return Future.error("$e");
    }
  }
}
