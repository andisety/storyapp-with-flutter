import 'dart:convert';

import 'package:story_app/utils/Authmanager.dart';

import '../model/model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final baseUrl = "https://story-api.dicoding.dev/v1";

  Future<LoginResult> login(String email, String password) async {
    try {
      // Map data = {'email': email, 'password': password};
      final response = await http.post(Uri.parse("$baseUrl/login"),
          body: jsonEncode(
              <String, String>{'email': email, 'password': password}));

      if (response.statusCode == 201) {
        final Map<String, dynamic> login = json.decode(response.body);
        LoginResult loginResult = login['loginResult'];
        AuthManager.saveAuthToken(loginResult.token);
        return LoginResult.fromJson(login['loginResult']);
      } else {
        throw Exception(
            'HTTP request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while making the HTTP request.');
    }
  }

  Future<ResponseApi> register(
      String name, String email, String password) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      // Map data = {'name': name, 'email': email, 'password': password};
      final response = await http.post(Uri.parse("$baseUrl/register"),
          headers: headers,
          body: jsonEncode(<String, String>{
            'name': name,
            'email': email,
            'password': password
          }));

      if (response.statusCode == 201) {
        final Map<String, dynamic> register = json.decode(response.body);
        print("register sukses");
        return ResponseApi.fromJson(register);
      } else {
        throw Exception(
            'HTTP request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while making the HTTP request.');
    }
  }

  Future<List<ListStory>> getStory() async {
    final token = await AuthManager.getAuthToken();
    try {
      final response = await http.post(Uri.parse("$baseUrl/stories"),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<ListStory> stories = it.map((e) => ListStory.fromJson(e)).toList();
        return stories;
      } else {
        throw Exception(
            'HTTP request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while making the HTTP request.');
    }
  }
}
