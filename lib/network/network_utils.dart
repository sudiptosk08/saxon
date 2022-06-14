import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:saxonmarket/constants/shared_preference_constant.dart';
import 'package:saxonmarket/services/navigation_service.dart';
import 'package:saxonmarket/views/screens/auth/account_verification_screen.dart';
import 'package:saxonmarket/views/styles/k_colors.dart';

import 'api.dart';

class Network {
  static String noInternetMessage = "Check your connection!";

  static getRequest(String endPoint, {bool requireToken = true, bool noBaseUrl = false}) async {
    if (await isNetworkAvailable()) {
      Response response;

      var accessToken = getStringAsync(TOKEN);

      var headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      if (requireToken) {
        var header = {"Authorization": "Bearer $accessToken"};
        headers.addAll(header);
      }

      print('\nURL: ${API.BASE}$endPoint');
      print("Headers: $headers\n");
      if (requireToken) {
        response = await get(Uri.parse(noBaseUrl ? '$endPoint' : '${API.BASE}$endPoint'), headers: headers);
      } else {
        response = await get(Uri.parse(noBaseUrl ? '$endPoint' : '${API.BASE}$endPoint'));
      }

      return response;
    } else {
      throw noInternetMessage;
    }
  }

  static postRequest(String endPoint, body, {bool requireToken = true}) async {
    if (await isNetworkAvailable()) {
      var accessToken = getStringAsync(TOKEN);

      var headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      if (requireToken) {
        var header = {"Authorization": "Bearer $accessToken"};
        headers.addAll(header);
      }

      print('\nURL: ${API.BASE}$endPoint');
      print("Headers: $headers");
      print('Request Body: ${jsonEncode(body)}\n');

      Response response = await post(Uri.parse('${API.BASE}' + '$endPoint'), body: jsonEncode(body), headers: headers);

      //print('Response: $response');

      return response;
    } else {
      throw noInternetMessage;
    }
  }

  static deleteRequest(String endPoint, {bool requireToken = true}) async {
    if (await isNetworkAvailable()) {
      Response response;

      var accessToken = getStringAsync(TOKEN);

      var headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      if (requireToken) {
        var header = {"Authorization": "Bearer $accessToken"};
        headers.addAll(header);
      }

      print('\nURL: ${API.BASE}$endPoint');
      print("Headers: $headers\n");
      if (requireToken) {
        response = await delete(Uri.parse('${API.BASE}$endPoint'), headers: headers);
      } else {
        response = await delete(Uri.parse('${API.BASE}$endPoint'));
      }

      return response;
    } else {
      throw noInternetMessage;
    }
  }

  static multiPartRequest(String endPoint, String methodName, {Map<String, String>? body, List<File>? files, String filedName = 'images'}) async {
    if (await isNetworkAvailable()) {
      var request = MultipartRequest(
        methodName.toUpperCase(),
        Uri.parse('${API.BASE}' + '$endPoint'),
      );
      print('URL: ${API.BASE}$endPoint');

      var accessToken = getStringAsync(TOKEN);

      Map<String, String> headers = {
        "Authorization": "Bearer $accessToken",
      };

      if (body != null) request.fields.addAll((body));
      if (files!.isNotEmpty) {
        files.forEach((file) async {
          request.files.add(await MultipartFile.fromPath(
            filedName,
            file.path,
            contentType: MediaType(
              mime(file.path)!.split('/')[0],
              mime(file.path)!.split('/')[1],
            ),
          ));
        });
      }
      print('Request Files: ${request.files}');

      request.headers.addAll(headers);

      print('Headers: ${request.headers}');
      print('Request Fields: ${request.fields}');
      StreamedResponse streamedResponse = await request.send();
      Response response = await Response.fromStream(streamedResponse);
      return response;
    } else {
      throw noInternetMessage;
    }
  }

  static handleResponse(Response response) async {
    if (!await isNetworkAvailable()) {
      toast('No network available');
    } else if (response.statusCode >= 200 && response.statusCode <= 210) {
      print('\nSuccessCode: ${response.statusCode}');
      print('SuccessResponse: ${response.body}\n');
      if (response.body.isNotEmpty)
        return json.decode(response.body);
      else
        return response.body;
    } else {
      print('\nErrorCode: ${response.statusCode}');
      print("ErrorResponse: ${response.body}\n");

      if (response.statusCode == 401 || response.statusCode == 400 || response.statusCode == 404) {
        /// Session expired
        if (jsonDecode(response.body)['message'] == "Invalid Token!") {
          // toast('Session expired! Login to continue...', bgColor: KColor.red);

          // setValue(LOGGED_IN, false);
          // NavigationService.navigateToReplacement(CupertinoPageRoute(builder: (_) => LoginScreen()));
          return;
        }

        if (jsonDecode(response.body)['message'] == "User not verified") {
          toast("Verify account first");
          NavigationService.navigateToReplacement(CupertinoPageRoute(builder: (context) => AccountVerificationScreen()));
          return;
        }

        if (jsonDecode(response.body)['errors'] != null) {
          toast("${jsonDecode(response.body)['errors'][0]}", bgColor: KColor.red);
          return;
        }

        /// Custom error message
        else {
          toast('${jsonDecode(response.body)['message']}', bgColor: KColor.red);
        }
      } else {
        toast('Something went wrong!', bgColor: KColor.red);
      }
    }
  }
}
