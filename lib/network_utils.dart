import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

class NetworkUtils {
  Future<dynamic> getMethod(String url,{VoidCallback? onunauthorized, String? token}) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json", 'token': token ?? ''},
      );
      log(response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if(onunauthorized != null)
        {
          onunauthorized();
        }
        else
        {

        }
      }
      else {
        log("Something went wrong ${response.statusCode}");
      }
    } catch (e) {
      log('Error $e');
    }
  }

  Future<dynamic> postMethod(String url,
      {Map<String, String>? body,
        VoidCallback? onunauthorized,
        String? token}) async {
    try {
      final http.Response response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json", 'token': token ?? ''},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onunauthorized != null) {
          onunauthorized();
        }
        else
        {
        }

      } else {
        log("Something went wrong");
      }
    } catch (e) {
      log('Error $e');
    }



  }
}
